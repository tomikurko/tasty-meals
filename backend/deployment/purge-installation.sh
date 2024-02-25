#!/bin/bash

echo -e -n "\n>> REMOVING TASTY MEALS PRODUCTION SYSTEM AND ALL ITS DATA. Are you sure? [YES|NO] "
read answer

if [ "$answer" == "YES" ]; then
    echo -e "\n"
    ssh tastymeals "cd ~/tastymeals && docker-compose down --volumes && cd && rm -rf ~/tastymeals"
    echo -e "\n>> Removed.\n"
else
    echo -e "\n>> Canceled.\n"
fi
