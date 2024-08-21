#!/bin/bash

# Health Checks
echo "Health Check Report"
echo "==================="

# Check the status of essential services

# Apache
echo "Apache Status:"
if systemctl is-active --quiet apache2; then
    echo "Apache is running"
else
    echo "Apache is not running"
fi
echo

# MySQL
echo "MySQL Status:"
if systemctl is-active --quiet mysql; then
    echo "MySQL is running"
else
    echo "MySQL is not running"
fi
echo

# Verify connectivity to external services or databases

# Example: Check connectivity to Google's DNS server
echo "Checking connectivity to Google's DNS server (8.8.8.8):"
if ping -c 4 8.8.8.8 > /dev/null 2>&1; then
    echo "Connectivity to Google's DNS server is up"
else
    echo "Connectivity to Google's DNS server is down"
fi
echo

# Example: Verify MySQL connectivity (replace with your own credentials and database name)
DB_HOST="localhost"
DB_USER="root"
DB_PASS="your_password"
DB_NAME="test_db"

echo "Checking MySQL connectivity:"
if mysql -h "$DB_HOST" -u "$DB_USER" -p"$DB_PASS" -e "USE $DB_NAME;" > /dev/null 2>&1; then
    echo "MySQL connectivity is up"
else
    echo "MySQL connectivity is down"
fi
