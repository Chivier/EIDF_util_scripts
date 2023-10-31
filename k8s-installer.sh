#!/bin/bash

DRY_RUN=0

run() {
    if [[ $DRY_RUN -eq 1 ]]; then
        echo "$@"
    else
        "$@" 2>&1 | tee log.txt
    fi
}

while IFS= read -r podname
do
    echo "$podname"
    kubectl cp installer.sh $podname:/tmp
    run kubectl exec $podname -- sh -c "sh /tmp/installer.sh" > /dev/null 2>&1 &
    kubectl cp collect.py $podname:/tmp
done < "pod-list.txt"


