#!/bin/bash

THRESHOLD=90  # Example threshold
USAGE=$(df -h / | grep / | awk '{print $5}' | cut -d'%' -f1)

if [ "$USAGE" -gt $THRESHOLD ]; then
    echo "$(date): Disk usage on / exceeds ${THRESHOLD}%" >> /var/log/disk.log
fi
