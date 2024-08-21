###  Project 01

### **Deploy a Database Server with Backup Automation**

**Objective**: Automate the deployment and configuration of a PostgreSQL
database server on an Ubuntu instance hosted on AWS, and set up regular
backups.

### **Problem Statement**

**Objective**: Automate the deployment, configuration, and backup of a
PostgreSQL database server on an Ubuntu instance using Ansible.

**Requirements**:

1.  **AWS Ubuntu Instance**: You have an Ubuntu server instance running
     on AWS.

2.  **Database Server Deployment**: Deploy and configure PostgreSQL on
     the Ubuntu instance.

3.  **Database Initialization**: Create a database and a user with
    specific permissions.

4.  **Backup Automation**: Set up a cron job for regular database
     backups and ensure that backups are stored in a specified
     directory.

5.  **Configuration Management**: Use Ansible to handle the deployment
     and configuration, including managing sensitive data like database
     passwords.

### **Deliverables**

1.  **Ansible Inventory File**

    -   **Filename**: inventory.ini

    -   **Content**: Defines the AWS Ubuntu instance and connection
         details for Ansible.
```
[web]
green ansible_host=18.119.105.83 ansible_user=ubuntu ansible_ssh_private_key_file=/home/einfochips/.ssh/ansible-worker.pem
```
 ![](.//media/image1.png)

2.  **Ansible Playbook**

    -   **Filename**: deploy\_database.yml

    -   **Content**: Automates the installation of PostgreSQL, sets up
         the database, creates a user, and configures a cron job for
         backups. It also includesvariables for databaseconfiguration
         and backup settings.
```
- name: Performing Day_17_Project_1
  hosts: web
  gather_facts: no
  become: yes
  vars:
    mysql_custom_settings:
      max_connections: 200
      query_cache_size: 16M

  tasks:
    - name: update cache as apt-get update
      apt:
        update_cache: yes

    - name: install mysql and its dependencies
      apt:
        name: ['mysql-server', 'mysql-client', 'python3-mysqldb', 'libmysqlclient-dev']
        state: present

    - name: enable the service
      service:
        name: mysql
        state: started
        enabled: yes

    - name: create a user in the database
      mysql_user:
        name: utsav
        password: utsav1234
        priv: '*.*:ALL'
        host: '%'
        state: present

# mysql -u siddh -p
# priv: '*.*:ALL' means user fansari will have all privileges (ALL) on all databases (*) and all tables (*).
# host: '%' means This specifies from which hosts the user can connect. The wildcard character % means the user can connect from any host.

    - name: changing mysql configuration file using template
      template:
        src: "/home/einfochips/DevOps_Final/Day_17/project1/my.cnf.j2"
        dest: "/etc/mysql/my.cnf.j2"
      notify:
        - restart mysql

    - name: copy the script
      ansible.builtin.copy:
        src: "/home/einfochips/DevOps_Final/Day_17/project1/backup.sh"
        dest: "/home/ubuntu/backup.sh"
        mode: '777'

    - name: Set up cron job for database backup
      cron:
        name: "Daily MySQL Backup"
        minute: "*/30"
        job: /home/ubuntu/backup.sh

  handlers:
    - name: restart mysql
      service:
        name: mysql
        state: restarted

```


3.  **Jinja2 Template**

    -   **Filename**: templates/pg\_hba.conf.j2

    -   **Content**: Defines the PostgreSQL configuration file
         (pg\_hba.conf) using Jinja2 templates to manage access
         controls dynamically.
```
[mysqld]
user = mysql
pid-file = /var/run/mysqld/mysqld.pid
socket = /var/run/mysqld/mysqld.sock
port = 3306
basedir = /usr
datadir = /var/lib/mysql
tmpdir = /tmp
lc-messages-dir = /usr/share/mysql
skip-external-locking

# Instead of skip-networking the default is now to listen only on
# localhost which is more compatible and is not less secure.
bind-address = 0.0.0.0

# Disabling symbolic-links is recommended to prevent assorted security risks
symbolic-links = 0

# Custom settings
{% for setting, value in mysql_custom_settings.items() %}
{{ setting }} = {{ value }}
{% endfor %}

[mysqld_safe]
log-error = /var/log/mysql/error.log
pid-file = /var/run/mysqld/mysqld.pid

!includedir /etc/mysql/conf.d/

```


4.  **Backup Script**

    -   **Filename**: scripts/backup.sh

    -   **Content**: A script to perform the backup of the PostgreSQL
         database. This script should be referenced in the cron job
         defined in the playbook.
```
#!/bin/bash

# Database credentials
USER="utsav"
PASSWORD="utsav1234"
HOST="localhost"
DB_NAME="my_database"

# Other options
BACKUP_PATH='/path/to/backup/directory'
DATE=$(date +%F)

# Set default file permissions
umask 177

# Dump database into SQL file
mysqldump --user=$USER --password=$PASSWORD --host=$HOST $DB_NAME > $BACKUP_PATH/$DB_NAME-$DATE.sql

# Remove backups older than 7 days
find $BACKUP_PATH/* -mtime +7 -exec rm {} \;
```


![](.//media/image6.png)

### **Project 02**

**Objective**: Automate the setup of a multi-tier web application stack
with separate database and application servers using Ansible.

### **Problem Statement**

**Objective**: Automate the deployment and configuration of a multi-tier
web application stack consisting of:

1.  **Database Server**: Set up a PostgreSQL database server on one
     Ubuntu instance.

2.  **Application Server**: Set up a web server (e.g., Apache or Nginx)
     on another Ubuntu instance to host a web application.

3.  **Application Deployment**: Ensure the web application is deployed
     on the application server and is configured to connect to the
     PostgreSQL database on the database server.

4.  **Configuration Management**: Use Ansible to automate the
    configuration of both servers, including the initialization of the
     database and the deployment of the web application.

### **Deliverables**

1.  **Ansible Inventory File**

    -   **Filename**: inventory.ini

    -   **Content**: Defines the database server and application server
         instances, including their IP addresses and connection
         details.
```
[db_server]
green ansible_host=18.119.105.83 ansible_user=ubuntu ansible_ssh_private_key_file=/home/einfochips/.ssh/ansible-worker.pem

[app_server]
green ansible_host=18.119.105.83 ansible_user=ubuntu ansible_ssh_private_key_file=/home/einfochips/.ssh/ansible-worker.pem
```


2.  **Ansible Playbook**

    -   **Filename**: deploy\_multitier\_stack.yml

    -   **Content**: Automates:

        -   The deployment and configuration of the PostgreSQL database
            server.

        -   The setup and configuration of the web server.

        -   The deployment of the web application and its configuration
             to connect to the database.

 ```
---
- hosts: db_server
  become: yes
  vars:
    mysql_root_password: "neel1234"
    mysql_database: "webapp_db"
    mysql_user: "webapp_user"
    mysql_password: "neel1234"
  tasks:
    - name: update cache as apt-get update
      apt:
        update_cache: yes

    - name: install mysql and its dependencies
      apt:
        name: ['mysql-server', 'mysql-client', 'python3-mysqldb', 'libmysqlclient-dev']
        state: present

    - name: enable the service
      service:
        name: mysql
        state: started
        enabled: yes

    # - name: Secure MySQL installation
    #   mysql_secure_installation:
    #     login_user: root
    #     login_password: "{{ mysql_root_password }}"
    #     root_password: "{{ mysql_root_password }}"
    #     state: present
    #     change_root_password: yes
    #     remove_anonymous_users: yes
    #     disallow_root_login_remotely: yes
    #     remove_test_db: yes

    - name: Create MySQL database
      mysql_db:
        name: "{{ mysql_database }}"
        state: present

    - name: Create MySQL user
      mysql_user:
        name: "{{ mysql_user }}"
        password: "{{ mysql_password }}"
        priv: "{{ mysql_database }}.*:ALL"
        state: present

- hosts: app_server
  become: yes
  vars:
    app_repo_url: "/home/einfochips/DevOps_Final/Task2/files/index.html"
    app_directory: "/var/www/html/"
    db_host: "{{ hostvars['db_server']['ansible_host'] }}"
    db_name: "webapp_db"
    db_user: "webapp_user"
    db_password: "secure_user_password"
  tasks:
    - name: Update apt cache
      apt:
        update_cache: yes

    - name: Install Apache2
      apt:
        name: apache2
        state: present

    - name: Install PHP and extensions
      apt:
        name:
          - php
          - php-mysql
          - libapache2-mod-php
        state: present

    - name: Ensure Apache is started and enabled
      service:
        name: apache2
        state: started
        enabled: yes

    # - name: Install Git
    #   apt:
    #     name: git
    #     state: present

    - name: Copy Web Application
      ansible.builtin.copy:
        src: "{{ app_repo_url }}"
        dest: "{{ app_directory }}"

    # - name: Clone web application repository
    #   git:
    #     repo: "{{ app_repo_url }}"
    #     dest: "{{ app_directory }}"
    #     update: yes

    - name: Deploy Apache configuration file
      template:
        src: "/home/einfochips/DevOps_Final/Task2/templates/apache_server.conf.j2"
        dest: "/etc/apache2/apache_server.conf"
        owner: root
        group: root
        mode: 0644
      notify:
        - Restart Apache

    - name: Ensure appropriate permissions for application directory
      file:
        path: "{{ app_directory }}"
        owner: www-data
        group: www-data
        state: directory
        recurse: yes
  handlers:
    - name: Restart Apache
      service:
        name: apache2
        state: restarted
 ```

3.  **Jinja2 Template**

    -   **Filename**: templates/app\_config.php.j2

    -   **Content**: Defines a configuration file for the web
     application that includes placeholders for dynamic values such
         as database connection details.

```
# This is the main Apache server configuration file. It contains the
# configuration directives that give the server its instructions.
# See <URL:http://httpd.apache.org/docs/2.4/> for detailed information about
# the directives and parameters.

ServerRoot "/etc/apache2"

# The file with the process id
PidFile ${APACHE_PID_FILE}

# Timeout: The number of seconds before receives and sends time out.
Timeout 300

# KeepAlive: Whether or not to allow persistent connections (more than
# one request per connection). Set to "Off" to deactivate.
KeepAlive On

# MaxKeepAliveRequests: The maximum number of requests to allow
# during a persistent connection. Set to 0 to allow an unlimited amount.
# We recommend you leave this number high, for maximum performance.
MaxKeepAliveRequests 100

# KeepAliveTimeout: Number of seconds to wait for the next request from the
# same client on the same connection.
KeepAliveTimeout 5

# These need to be set in /etc/apache2/envvars
User ${APACHE_RUN_USER}
Group ${APACHE_RUN_GROUP}

# HostnameLookups: Log the names of clients or just their IP addresses
HostnameLookups Off

# ErrorLog: The location of the error log file.
ErrorLog ${APACHE_LOG_DIR}/error.log

# LogLevel: Control the number of messages logged to the error_log.
LogLevel warn

# Include module configuration:
IncludeOptional mods-enabled/*.load
IncludeOptional mods-enabled/*.conf

# Include all the user configurations:
IncludeOptional conf-enabled/*.conf

# Include ports listing
Include ports.conf

# The default server name
ServerName {{ ansible_fqdn }}

# Global configuration
Mutex file:${APACHE_LOCK_DIR} default
PidFile ${APACHE_PID_FILE}
Timeout 300
KeepAlive On

<Directory />
    AllowOverride none
    Require all denied
</Directory>

<Directory /usr/share>
    AllowOverride none
    Require all granted
</Directory>

<Directory /var/www/>
    Options Indexes FollowSymLinks
    AllowOverride None
    Require all granted
</Directory>

<Directory /var/www/html/webapp>
    Options Indexes FollowSymLinks
    AllowOverride All
    Require all granted
</Directory>

AccessFileName .htaccess

<FilesMatch "^\.ht">
    Require all denied
</FilesMatch>

LogFormat "%v:%p %h %l %u %t \"%r\" %>s %b" vhost_combined
LogFormat "%h %l %u %t \"%r\" %>s %b" common
LogFormat "%{Referer}i -> %U" referer
LogFormat "%{User-agent}i" agent

CustomLog ${APACHE_LOG_DIR}/access.log combined

<IfModule alias_module>
    ScriptAlias /cgi-bin/ /usr/lib/cgi-bin/
    <Directory "/usr/lib/cgi-bin">
        AllowOverride None
        Options +ExecCGI -MultiViews +SymLinksIfOwnerMatch
        Require all granted
    </Directory>
</IfModule>

<IfModule mime_module>
    TypesConfig /etc/mime.types
    AddType application/x-compress .Z
    AddType application/x-gzip .gz .tgz
    AddType text/html .shtml
    AddOutputFilter INCLUDES .shtml
</IfModule>

IncludeOptional sites-enabled/*.conf
```

4.  **Application Files**

    -   **Filename**: files/index.html (or equivalent application files)

    -   **Content**: Static or basic dynamic content served by the web
        application.

```
<!DOCTYPE html>
<html>
<head>
    <title>My Web Application</title>
</head>
<body>
    <h1>Project 2 Web App</h1>
    <h2>Neel Patel</h2>
    <p>Day 17 Task 2</p>
</body>
</html>

```

![](.//media/image13.png)

![](.//media/image14.png)
