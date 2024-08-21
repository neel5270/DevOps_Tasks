#!/bin/bash

# Alerting Mechanism
echo "Alerting Mechanism Report"
echo "========================="

# Define thresholds
CPU_THRESHOLD=80       # CPU usage percentage
MEMORY_THRESHOLD=80    # Memory usage percentage

# Check CPU usage
CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}')
echo "CPU Usage: ${CPU_USAGE}%"

if [ $(echo "$CPU_USAGE > $CPU_THRESHOLD" | bc) -eq 1 ]; then
    echo "Alert: CPU usage is above ${CPU_THRESHOLD}%"
    ALERT="CPU usage is above ${CPU_THRESHOLD}%. Current usage is ${CPU_USAGE}%."
fi

# Check Memory usage
MEMORY_USAGE=$(free | grep Mem | awk '{print $3/$2 * 100.0}')
echo "Memory Usage: ${MEMORY_USAGE}%"

if [ $(echo "$MEMORY_USAGE > $MEMORY_THRESHOLD" | bc) -eq 1 ]; then
    echo "Alert: Memory usage is above ${MEMORY_THRESHOLD}%"
    ALERT="${ALERT} Memory usage is above ${MEMORY_THRESHOLD}%. Current usage is ${MEMORY_USAGE}%."
fi

# Send email notification if there are critical alerts
if [ ! -z "$ALERT" ]; then
    # Email parameters
    EMAIL_SUBJECT="Critical Alert: System Metrics Exceeded Threshold"
    EMAIL_BODY="Subject:${EMAIL_SUBJECT}\n\n${ALERT}"
    EMAIL_RECIPIENT="sysadmin@example.com"

    # Send email (requires `mail` or `mailx` to be installed)
    echo -e "$EMAIL_BODY" | mail -s "$EMAIL_SUBJECT" "$EMAIL_RECIPIENT"
    echo "Alert email sent to $EMAIL_RECIPIENT."
fi
