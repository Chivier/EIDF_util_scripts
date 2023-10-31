#!/bin/bash

if command -v pip3 &>/dev/null; then
	PIP_COMMAND=pip3
elif command -v pip &>/dev/null; then
	PIP_COMMAND=pip
else
	echo "Neither pip nor pip3 is installed"
	exit 1
fi

echo "Using $PIP_COMMAND"

$PIP_COMMAND install -U nvitop
