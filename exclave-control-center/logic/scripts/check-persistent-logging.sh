#!/bin/bash

balena env add RESIN_SUPERVISOR_PERSISTENT_LOGGING true --application socks-device

source /root/.bashrc
echo ${DUT_UUID}

balena device reboot "${DUT_UUID}"
node /usr/src/core/logic/balenaSDK/devicefinder.js
echo "Reboot 1 Complete"

balena device reboot "${DUT_UUID}"
node /usr/src/core/logic/balenaSDK/devicefinder.js
echo "Reboot 2 Complete"

balena device reboot "${DUT_UUID}"
node /usr/src/core/logic/balenaSDK/devicefinder.js
echo "Reboot 3 Complete"

result=$(echo "journalctl --list-boots | wc -l" | balena ssh ${DUT_UUID})

if [[ "$result" == *"4"* ]]; then
    echo "Persistent Logging Test Completed ${result} reboots"
    exit 0
else
    echo "Test Failed with ${result} reboots"
    exit 1
fi
