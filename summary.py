import sys
import os
import json

filename = sys.argv[1]
tag = sys.argv[2]
interval = float(sys.argv[3])
duration = float(sys.argv[4])

final_dict = {}

with open(filename, "r") as file:
    lines = file.readlines()
    for line in lines:
        json_line = json.loads(line)
        for key, value in json_line.items():
            if "utilization" in key:
                if "last" in key:
                    continue
                if key not in final_dict:
                    final_dict[key] = value
                else:
                    if "mean" in key:
                        final_dict[key] += value
                    elif "max" in key:
                        final_dict[key] = max(final_dict[key], value)
                    elif "min" in key:
                        final_dict[key] = min(final_dict[key], value)

for key, value in final_dict.items():
    if "mean" in key:
        final_dict[key] = final_dict[key] * interval / duration
        
print(final_dict)
        