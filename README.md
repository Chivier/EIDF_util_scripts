# EIDF Fine-grained GPU Activity Monitor

## Local Script

- collect.py: core script, based on nvitop
- installer.sh: install nvitop on pip/pip3

Usage: python3 collect.py filename tagname interval duration

## K8s Script

- k8s-installer.sh: copy installer.sh to every pod
- k8s-monitor.sh: monitor the given pods in `pod-list.txt`

Usage: set `FILENAME`, `TAG`, `INTERVAL` and `DURATION` in `k8s-monitor.sh`

