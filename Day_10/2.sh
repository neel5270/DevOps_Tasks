#!/bin/bash

# System Metrics Report
echo "System Metrics Report"
echo "====================="

# Monitor CPU Usage
echo "CPU Usage:"
top -b -n1 | grep "Cpu(s)" | awk '{print "CPU Load: " $2 + $4 "%"}'
echo

# Monitor Memory Utilization
echo "Memory Utilization:"
free -m | awk 'NR==2{printf "Memory Usage: %s/%sMB (%.2f%%)\n", $3,$2,$3*100/$2}'
echo

# Monitor Disk Space
echo "Disk Space Utilization:"
df -h | awk '$NF=="/"{printf "Disk Usage: %d/%dGB (%s)\n", $3,$2,$5}'
echo

# Monitor Network Statistics
echo "Network Statistics:"
ifconfig | grep -A 1 'eth0' | awk '/RX packets/ {print "RX Packets: " $3} /TX packets/ {print "TX Packets: " $3}'
echo

# Capture Top Processes Consuming Resources
echo "Top Processes:"
ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem | head -n 10
