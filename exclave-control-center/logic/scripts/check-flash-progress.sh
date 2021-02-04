#!/bin/bash

DEFAULTVALUE="/images/raspberrypi3.img"
curl -s testblockbot:5001/flash?path="${1:-$defaultImagePath}"

echo "Flashing ${1:-$defaultImagePath} on the DUT"

while :; do
  progress=$(curl -s testblockbot:5001/flash-progress)
  if [[ "$progress" == *"Flashing Completed"* ]]; then
    echo "Flashing Completed"
    exit 0
  fi
done
