from nvitop import ResourceMetricCollector, Device, collect_in_background
import sys
import os
import time
import logging
import json
import threading

# Configure the logger to write to a file

def print_log(filename, collector_metric):
    with open(filename, "a") as file:
        json.dump(collector_metric, file)

if len(sys.argv) != 5:
    print("Usage: python3 collect.py filename tagname interval duration")
    exit(1)

filename = sys.argv[1]
tagname = sys.argv[2]
interval = float(sys.argv[3])
duartion = float(sys.argv[4])

start_time = time.time()

def run():
    collector = ResourceMetricCollector(devices=Device.cuda.all())
    with collector(tag=tagname):
        if time.time() - start_time < duartion:
            threading.Timer(interval, run).start()  # schedule the function to run
            collector_metric = collector.collect()
            print_log(filename, collector_metric)
        else:
            return

run()
