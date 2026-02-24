#!/bin/bash

# Script is copied into container for ralph loop.

set -e

if [ -z "$1" ]; then
  echo "Usage: $0 <iterations>"
  exit 1
fi

for ((i=1; i<=$1; i++)); do
  echo "Starting iteration $i"
  result=$(cat ./RALPH_PROMPT.md | claude --permission-mode bypassPermissions -p)

  echo "$result"

  if [[ "$result" == *"<promise>COMPLETE</promise>"* ]]; then
    echo "RALPH_PRD complete after $i iterations"
    exit 0
  fi
done