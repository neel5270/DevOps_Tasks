#!/bin/bash

# Log Analysis
echo "Log Analysis Report"
echo "==================="

# Parse system logs for critical events and errors
echo "Last 5 Critical Events and Errors:"
grep -i 'crit\|error\|fail' /var/log/syslog | tail -n 5
echo

# Generate summaries of recent log entries based on severity
echo "Log Entries Summary by Severity (Total Counts):"

# Count occurrences of different severity levels in syslog
echo "Critical:"
grep -i 'crit' /var/log/syslog | wc -l
echo "Error:"
grep -i 'error' /var/log/syslog | wc -l
echo "Failure:"
grep -i 'fail' /var/log/syslog | wc -l
echo

# Show recent log entries
echo "Last 5 Recent Log Entries:"
tail -n 5 /var/log/syslog
