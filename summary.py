import sys
import os
import json

filename = sys.argv[1]
tag = sys.argv[2]
interval = float(sys.argv[3])
duration = float(sys.argv[4])

with open(filename, "r") as file:
    lines = file.readlines()
    for line in lines:
        json_line = json.loads(line)
        for key, value in json_line.items():
            if "utilization" in key:
                print(key, value)
        