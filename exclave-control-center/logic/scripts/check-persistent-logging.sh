#!/bin/bash

balena env add RESIN_SUPERVISOR_PERSISTENT_LOGGING true --application socks-device

source /root/.bashrc

balena device reboot "${DUT_UUID}"
node ../balenaSDK/deviceFinder.js

balena device reboot "${DUT_UUID}"
node ../balenaSDK/deviceFinder.js

balena device reboot "${DUT_UUID}"
node ../balenaSDK/deviceFinder.js


result=$(echo “journalctl --list-boots | wc -l ; exit” | balena ssh ${DUT_UUID})

if [[ "$result" == *"4"* ]]; then
    echo "Persistent Logging Test Completed ${result} reboots"
    exit 0
else
    echo "Test Failed with ${result} reboots"
    exit 1
fi
