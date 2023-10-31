#!/bin/bash

FILENAME=log.txt
TAG=log
INTERVAL=1
DURATION=10

while IFS= read -r podname
do
    echo "$podname"
    kubectl cp collect.py $podname:/tmp
done < "pod-list.txt"


while IFS= read -r podname
do
    echo "$podname"
    kubectl exec $podname -- rm /tmp/log.txt
    kubectl exec $podname -- python3 /tmp/collect.py /tmp/log.txt $TAG $INTERVAL $DURATION > /dev/null 2>&1 &
done < "pod-list.txt"
sleep $DURATION

while IFS= read -r podname
do
    echo "Copy back from $podname..."
    kubectl cp $podname:/tmp/log.txt $podname-log.txt
done < "pod-list.txt"


