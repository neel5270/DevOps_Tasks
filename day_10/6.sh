#!/bin/bash

# Report Generation
REPORT_FILE="system_report_$(date +%Y%m%d_%H%M%S).txt"
echo "Generating Detailed Report: $REPORT_FILE"

# Collect System Metrics
CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}')
MEMORY_USAGE=$(free | grep Mem | awk '{print $3/$2 * 100.0}')
DISK_USAGE=$(df -h | grep '^/dev/' | awk '{print $5 " " $1}')
NETWORK_STATS=$(netstat -i | awk 'NR>2 {print $1, $3, $4}')

# Collect Last 5 Log Entries
LAST_LOG_ENTRIES=$(tail -n 5 /var/log/syslog)

# Collect Health Check Results
APACHE_STATUS=$(systemctl is-active --quiet apache2 && echo "Running" || echo "Not Running")
MYSQL_STATUS=$(systemctl is-active --quiet mysql && echo "Running" || echo "Not Running")

# Generate Report
echo "System Report - $(date)" > "$REPORT_FILE"
echo "====================" >> "$REPORT_FILE"
echo "" >> "$REPORT_FILE"

echo "CPU Usage: ${CPU_USAGE}%" >> "$REPORT_FILE"
echo "Memory Usage: ${MEMORY_USAGE}%" >> "$REPORT_FILE"
echo "Disk Usage:" >> "$REPORT_FILE"
echo "$DISK_USAGE" >> "$REPORT_FILE"
echo "" >> "$REPORT_FILE"

echo "Network Statistics:" >> "$REPORT_FILE"
echo "$NETWORK_STATS" >> "$REPORT_FILE"
echo "" >> "$REPORT_FILE"

echo "Last 5 Log Entries:" >> "$REPORT_FILE"
echo "$LAST_LOG_ENTRIES" >> "$REPORT_FILE"
echo "" >> "$REPORT_FILE"

echo "Apache Status: $APACHE_STATUS" >> "$REPORT_FILE"
echo "MySQL Status: $MYSQL_STATUS" >> "$REPORT_FILE"

echo "Report generated: $REPORT_FILE"
