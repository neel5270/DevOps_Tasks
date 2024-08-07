#### **Project Overview**

In this capstone project, you will create a comprehensive automated
deployment pipeline for a web application on an AWS EC2 instance running
Ubuntu using Ansible. You will follow best practices for playbooks and
roles, implement version control, document and maintain your code, break
down tasks into roles, write reusable and maintainable code, and use
dynamic inventory scripts. This project will culminate in a fully
functional deployment, demonstrating your mastery of Ansible for
infrastructure automation.

#### **Project Objectives**

-   Set up an AWS EC2 instance as a worker node.

-   Implement Ansible playbooks and roles following best practices.

-   Use version control to manage Ansible codebase.

-   Document Ansible roles and playbooks.

-   Break down deployment tasks into reusable roles.

-   Write reusable and maintainable Ansible code.

-   Use dynamic inventory scripts to manage AWS EC2 instances.

-   Deploy a web application on the EC2 instance.

#### **Project Components and Milestones**

### **Milestone 1: Environment Setup**

**Objective**: Configure your development environment and AWS
infrastructure.

**Tasks**:

-   Launch an AWS EC2 instance running Ubuntu.

-   Install Ansible and Git on your local machine or control node.

**Deliverables**:

-   AWS EC2 instance running Ubuntu.

-   Local or remote control node with Ansible and Git installed.

```
sudo apt update
sudo apt install ansible
sudo apt install git
```

### **Milestone 2: Create Ansible Role Structure**

**Objective**: Organize your Ansible project using best practices for
playbooks and roles.

**Tasks**:

-   Use Ansible Galaxy to create roles for web server, database, and
     application deployment.

-   Define the directory structure and initialize each role.sudo apt update
sudo apt install ansible
sudo apt install git
 

**Deliverables**:

-   Ansible role directories for webserver, database, and application.

```
ansible-galaxy init nodejs
ansible-galaxy init database
ansible-galaxy init webserver
```

### **Milestone 3: Version Control with Git**

**Objective**: Implement version control for your Ansible project.

**Tasks**:

-   Initialize a Git repository in your project directory.

-   Create a .gitignore file to exclude unnecessary files.

-   Commit and push initial codebase to a remote repository.

**Deliverables**:

-   Git repository with initial Ansible codebase.

-   Remote repository link (e.g., GitHub).

### **Milestone 4: Develop Ansible Roles**

**Objective**: Write Ansible roles for web server, database, and
application deployment.

**Tasks**:

-   Define tasks, handlers, files, templates, and variables within each
     role.

-   Ensure each role is modular and reusable.

**Deliverables**:

-   Completed Ansible roles for webserver, database, and application.

```yml
#/home/einfochips/DevOps_Final/Day_19/application/handlers/main.yml
---
- name: Restart application service
  systemd:
    name: app
    state: restarted
    enabled: yes
  become: yes
```
```yml
#/home/einfochips/DevOps_Final/Day_19/application/tasks/main.yml
---
- name: Install Node.js
  apt:
    name: nodejs
    state: present
  become: yes

- name: Install npm
  apt:
    name: npm
    state: present
  become: yes


- name: Ensure myapp directory exists
  file:
    path: "{{ app_path }}"
    state: directory
    owner: ubuntu
    group: ubuntu
    mode: '0755'
  become: yes

- name: Copy entire directory to the target location
  synchronize:
    src: app/
    dest: "{{ app_path }}"
    recursive: yes
  become: yes

- name: Install application dependencies
  npm:
    path: "{{ app_path }}"
    state: present
  become: yes


- name: Configure application service
  template:
    src: app.service.j2
    dest: /etc/systemd/system/app.service
  become: yes

- name: Start and enable application service
  systemd:
    name: app
    state: started
    enabled: yes
  become: yes

```

```js
#/home/einfochips/DevOps_Final/Day_19/application/files/app/index.js
const express = require('express');
const app = express();
const port = 3000;

app.get('/', (req, res) => {
    res.send('Hello, ansible!');
});

app.listen(port, () => {
    console.log(`App running at http://localhost:${port}`);
});

```

```j2
#/home/einfochips/DevOps_Final/Day_19/application/templates/app.service.j2
[Unit]
Description=Node.js Application

[Service]
ExecStart=/usr/bin/node {{app_path}}
Restart=always
User=nobody
Group=nobody
Environment=PATH=/usr/bin:/usr/local/bin
Environment=NODE_ENV=production
WorkingDirectory={{app_path}}

[Install]
WantedBy=multi-user.target

```

```yml
#/home/einfochips/DevOps_Final/Day_19/application/vars/main.yml
---
app_path: /home/ubuntu/myapp/

```
#
- Database

```yml
#/home/einfochips/DevOps_Final/Day_19/database/tasks/main.yml
- name: Install MySQL
  apt:
    name: mysql-server
    state: present
  notify: restart mysql

- name: Configure MySQL
  template:
    src: my.cnf.j2
    dest: /etc/mysql/my.cnf
  notify: restart mysql

- name: Ensure MySQL is running
  service:
    name: mysql
    state: started
    enabled: yes


```

```yml
#/home/einfochips/DevOps_Final/Day_19/database/handlers/main.yml
- name: restart mysql
  service:
    name: mysql
    state: restarted

```

```j2
#/home/einfochips/DevOps_Final/Day_19/database/templates/my.cnf.j2
[mysqld]
bind-address = {{ mysql_bind_address }}
max_connections = {{ mysql_max_connections }}

```

```yml
#/home/einfochips/DevOps_Final/Day_19/database/vars/main.yml
mysql_user: mysql
mysql_group: mysql

```

#
- webserver

```yml
#/home/einfochips/DevOps_Final/Day_19/webserver/tasks/main.yml
- name: Install Nginx
  apt:
    name: nginx
    state: present
  notify: restart nginx

- name: Configure Nginx
  template:
    src: nginx.conf.j2
    dest: /etc/nginx/conf.d/my_site.conf
  notify: restart nginx

- name: Ensure Nginx is running
  service:
    name: nginx
    state: started
    enabled: yes
```
```yml
#/home/einfochips/DevOps_Final/Day_19/webserver/handlers/main.yml
- name: restart nginx
  service:
    name: nginx
    state: restarted
```

```yml
#/home/einfochips/DevOps_Final/Day_19/webserver/templates/nginx.conf.j2
server {
    listen {{ webserver_port }};
    server_name {{ webserver_name }};
    root {{ webserver_root }};
}

```

```yml
#/home/einfochips/DevOps_Final/Day_19/webserver/vars/main.yml
webserver_user: nginx
webserver_group: nginx

```
### **Milestone 5: Documentation and Maintenance**

**Objective**: Document your Ansible roles and playbooks for future
maintenance.

**Tasks**:

-   Create README.md files for each role explaining purpose, variables,
    tasks, and handlers.

-   Add comments within your playbooks and roles to explain complex
    logic.

**Deliverables**:

-   README.md files for webserver, database, and application roles.

-   Well-documented playbooks and roles.
```yml
#/home/einfochips/DevOps_Final/Day_19/README.md
```
### **Milestone 6: Dynamic Inventory Script**

**Objective**: Use dynamic inventory scripts to manage AWS EC2
instances.

**Tasks**:

-   Write a Python script that queries AWS to get the list of EC2
 instances.

-   Format the output as an Ansible inventory.

**Deliverables**:

-   Dynamic inventory script to fetch EC2 instance details.

```py
#/home/einfochips/DevOps_Final/Day_19/script.py
#!/usr/bin/env python3

import json
import boto3

def get_inventory():
    ec2 = boto3.client('ec2', region_name='us-east-2')  # Specify your region
    response = ec2.describe_instances(Filters=[{'Name': 'tag:Name', 'Values': ['Neel']}])
    
    inventory = {
        'all': {
            'hosts': [],
            'vars': {}
        },
        '_meta': {
            'hostvars': {}
        }
    }
    
    ssh_key_file = '/home/einfochips/.ssh/ansible-worker.pem'  # Path to your SSH private key file
    ssh_user = 'ubuntu'  # SSH username
    
    for reservation in response['Reservations']:
        for instance in reservation['Instances']:
            public_dns = instance.get('PublicDnsName', instance['InstanceId'])
            inventory['all']['hosts'].append(public_dns)
            inventory['_meta']['hostvars'][public_dns] = {
                'ansible_host': instance.get('PublicIpAddress', instance['InstanceId']),
                'ansible_ssh_private_key_file': ssh_key_file,
                'ansible_user': ssh_user
            }

    return inventory

if __name__ == '__main__':
    print(json.dumps(get_inventory()))
```
### **Milestone 7: Playbook Development and Deployment**

**Objective**: Create and execute an Ansible playbook to deploy the web
application.

**Tasks**:

-   Develop a master playbook that includes all roles.

-   Define inventory and variable files for different environments.

-   Execute the playbook to deploy the web application on the EC2
     instance.

**Deliverables**:

-   Ansible playbook for web application deployment.

-   Successfully deployed web application on the EC2 instance.



![](.//media/image2.png)

![](.//media/image3.png)

![](.//media/image4.png)