#!/bin/bash

# Function to collect system metrics
collect_system_metrics() {
    echo "===== System Metrics Collection ====="
    echo "CPU Usage:"
    top -b -n 1 | head -n 10  # Adjust as needed for your system
    echo ""
    echo "Memory Utilization:"
    free -h
    echo ""
    echo "Disk Space:"
    df -h
}

collect_system_metrics