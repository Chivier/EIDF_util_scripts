#!/bin/bash

FILENAME=log.txt
TAG=log
INTERVAL=5
DURATION=300

# Copy new script
while IFS= read -r podname
do
    echo "$podname"
    kubectl cp collect.py $podname:/tmp
done < "pod-list.txt"

# Collect metrics
while IFS= read -r podname
do
    echo "$podname"
    kubectl exec $podname -- rm /tmp/log.txt
    kubectl exec $podname -- python3 /tmp/collect.py /tmp/log.txt $TAG $INTERVAL $DURATION > /dev/null 2>&1 &
done < "pod-list.txt"
sleep $DURATION

# Copy log to head
while IFS= read -r podname
do
    echo "Copy back from $podname..."
    kubectl cp $podname:/tmp/log.txt $podname-log.txt
done < "pod-list.txt"

# Generate summary
while IFS= read -r podname
do
    echo "$podname"
    python3 summary.py $podname-log.txt $TAG $INTERVAL $DURATION > $podname-summary.json
done < "pod-list.txt"
sleep $DURATION
