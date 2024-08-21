#!/bin/bash

# Initialization
initialize_script() {
  echo "Initializing script..."
  # Check for required commands and utilities
  for cmd in awk grep sed mail ip; do
    if ! command -v $cmd &> /dev/null; then
      echo "Error: $cmd is not installed." >&2
      exit 1
    fi
  done

  # Set default variables
  EMAIL="sysadmin@example.com"
  LOG_FILE="/var/log/sys_monitor.log"
  ALERT_THRESHOLD_CPU=80
  ALERT_THRESHOLD_MEM=80
}

# System Metrics Collection
collect_metrics() {
  echo "Collecting system metrics..."
  CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}')
  MEM_USAGE=$(free | grep Mem | awk '{print $3/$2 * 100.0}')
  DISK_USAGE=$(df -h / | grep / | awk '{ print $5 }')
  NETWORK_STATS=$(ip -s link show eth0)
  TOP_PROCESSES=$(ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem | head)

  echo "CPU Usage: $CPU_USAGE%"
  echo "Memory Usage: $MEM_USAGE%"
  echo "Disk Usage: $DISK_USAGE"
  echo "Network Statistics: $NETWORK_STATS"
  echo "Top Processes: $TOP_PROCESSES"
}

# Log Analysis
analyze_logs() {
  echo "Analyzing logs..."
  CRITICAL_LOGS=$(grep "CRITICAL" /var/log/syslog | tail -n 20)
  ERROR_LOGS=$(grep "ERROR" /var/log/syslog | tail -n 20)

  echo "Recent Critical Logs:"
  echo "$CRITICAL_LOGS"
  echo "Recent Error Logs:"
  echo "$ERROR_LOGS"
}

# Health Checks
perform_health_checks() {
  echo "Performing health checks..."
  if systemctl is-active --quiet apache2; then
    echo "Apache is running"
  else
    echo "Apache is not running"
  fi

  if systemctl is-active --quiet mysql; then
    echo "MySQL is running"
  else
    echo "MySQL is not running"
  fi
}

# Alerting Mechanism
send_alerts() {
  echo "Sending alerts..."
  if (( $(echo "$CPU_USAGE > $ALERT_THRESHOLD_CPU" | bc -l) )); then
    echo "High CPU usage: $CPU_USAGE%" | mail -s "CPU Alert" $EMAIL
  fi

  if (( $(echo "$MEM_USAGE > $ALERT_THRESHOLD_MEM" | bc -l) )); then
    echo "High memory usage: $MEM_USAGE%" | mail -s "Memory Alert" $EMAIL
  fi
}

# Report Generation
generate_report() {
  echo "Generating report..."
  {
    echo "System Metrics Report"
    echo "====================="
    echo "CPU Usage: $CPU_USAGE%"
    echo "Memory Usage: $MEM_USAGE%"
    echo "Disk Usage: $DISK_USAGE"
    echo "Network Statistics: $NETWORK_STATS"
    echo "Top Processes: $TOP_PROCESSES"
    echo "Recent Critical Logs: $CRITICAL_LOGS"
    echo "Recent Error Logs: $ERROR_LOGS"
    echo
  } > $LOG_FILE
}

# Automation and Scheduling
setup_cron() {
  echo "Setting up cron job..."
  CRON_SCHEDULE="*/10 * * * *"
  (crontab -l 2>/dev/null; echo "$CRON_SCHEDULE $(realpath $0) > /dev/null 2>&1") | crontab -
}

# User Interaction
interactive_mode() {
  echo "Interactive mode activated. Choose an option:"
  echo "1. Collect Metrics"
  echo "2. Analyze Logs"
  echo "3. Perform Health Checks"
  echo "4. Generate Report"
  echo "5. Send Alerts"
  read -p "Enter your choice: " choice
  case $choice in
    1) collect_metrics ;;
    2) analyze_logs ;;
    3) perform_health_checks ;;
    4) generate_report ;;
    5) send_alerts ;;
    *) echo "Invalid option" ;;
  esac
}

# Documentation
show_help() {
  cat << EOF
Usage: $(basename $0) [options]
Options:
  --help          Show this help message
  --interactive   Run in interactive mode
  --setup-cron    Setup cron job for automated monitoring
EOF
}

# Main script logic
main() {
  initialize_script

  if [[ $1 == "--help" ]]; then
    show_help
  elif [[ $1 == "--interactive" ]]; then
    interactive_mode
  elif [[ $1 == "--setup-cron" ]]; then
    setup_cron
  else
    collect_metrics
    analyze_logs
    perform_health_checks
    send_alerts
    generate_report
  fi
}

main "$@"
