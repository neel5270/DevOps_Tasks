#### **Project 01**

#### **Problem Statement**

You are tasked with deploying a three-tier web application (frontend,
backend, and database) using Ansible roles. The frontend is an Nginx web
server, the backend is a Node.js application, and the database is a
MySQL server. Your solution should use Ansible Galaxy roles where
applicable and define appropriate role dependencies. The deployment
should be automated to ensure that all components are configured
correctly and can communicate with each other.

#### **Steps and Deliverables**

1.  **Define Project Structure**

    -   Create a new Ansible project with a suitable directory structure
        to organize roles, playbooks, and inventory files.
```tree
├── ansible.cfg
├── Day 18.docx
├── group_vars
│   └── database.yml
├── inventory.ini
├── media
│   └── image1.png
├── output.md
├── playbooks
│   └── deploy.yml
└── roles
    ├── appserver
    │   ├── defaults
    │   │   └── main.yml
    │   ├── files
    │   ├── handlers
    │   │   └── main.yml
    │   ├── meta
    │   │   └── main.yml
    │   ├── README.md
    │   ├── tasks
    │   │   └── main.yml
    │   ├── templates
    │   ├── tests
    │   │   ├── inventory
    │   │   └── test.yml
    │   └── vars
    │       └── main.yml
    ├── database
    │   ├── defaults
    │   │   └── main.yml
    │   ├── files
    │   ├── handlers
    │   │   └── main.yml
    │   ├── meta
    │   │   └── main.yml
    │   ├── README.md
    │   ├── tasks
    │   │   └── main.yml
    │   ├── templates
    │   ├── tests
    │   │   ├── inventory
    │   │   └── test.yml
    │   └── vars
    │       └── main.yml
    └── webserver
        ├── defaults
        │   └── main.yml
        ├── files
        ├── handlers
        │   └── main.yml
        ├── meta
        │   └── main.yml
        ├── README.md
        ├── tasks
        │   └── main.yml
        ├── templates
        ├── tests
        │   ├── inventory
        │   └── test.yml
        └── vars
            └── main.yml


```
2.  **Role Selection and Creation**

    -   Select appropriate roles from Ansible Galaxy for each tier of
        the application:

        -   Nginx for the frontend.

            ansible-galaxy init role/nginx

        -   Node.js for the backend.

            ansible-galaxy init role/nodejs

        -   MySQL for the database.

            ansible-galaxy init role/mysql

![](.//media/image1.png)

3.  **Dependencies Management**

    -   Define dependencies for each role in the meta/main.yml file.
```yml
dependencies: 
  - role: mysql
    when: ansible_os_family == "Debian"
  # List your role dependencies here, one per line. Be sure to remove the '[]' above,
  # if you add dependencies to this list.
```
 

-   Ensure that the roles have appropriate dependencies, such as
    ensuring the database is set up before deploying the backend.

4.  **Inventory Configuration**

    -   Create an inventory file that defines the groups of hosts for
         each tier (frontend, backend, database).

    -   Ensure proper group definitions and host variables as needed.

```ini
[frontend]
web_host ansible_host=18.117***** ansible_user=ubuntu ansible_ssh_private_key_file=/home/einfochips/.ssh/ansible-worker.pem

[backend]
app_host ansible_host=18.117****** ansible_user=ubuntu ansible_ssh_private_key_file=/home/einfochips/.ssh/ansible-worker.pem

[database]
db_host ansible_host=18.11******* ansible_user=ubuntu ansible_ssh_private_key_file=/home/einfochips/.ssh/ansible-worker.pem
```

5.  **Playbook Creation**

    -   Create a playbook (deploy.yml) that includes and orchestrates
        the roles for deploying the application.

    -   Ensure the playbook handles the deployment order and variable
        passing between roles

 
```yml
#/home/einfochips/DevOps\_Final/project-directory/playbooks.
---
- hosts: database
  become: yes
  roles:
    - database
- hosts: backend
  become: yes
  roles:
    - appserver
- hosts: frontend
  become: yes
  roles:
    - webserver
```

```yml
#/home/einfochips/DevOps_Final/project-directory/roles/appserver/tasks/main.yml
---
# tasks file for roles/appserver

- name: Install Node.js 
  apt:
    name: nodejs
    state: present
    update_cache: yes

- name: Ensure npm is installed 
  apt:
    name: npm
    state: present

```

```yml
#/home/einfochips/DevOps_Final/project-directory/roles/database/tasks/main.yml
---
# tasks file for roles/database
- name: Install MySQL server
  apt:
    update_cache: yes
    name: ['mysql-server','mysql-client','python3-mysqldb','libmysqlclient-dev']
    state: present
  become: yes

- name: Start MySQL service
  service:
    name: mysql
    state: started
    enabled: true
  become: yes

- name: Create a MySQL user
  mysql_user:
    name: "{{msql_user}}"
    password: "{{msql_password}}"
    priv: '*.*:ALL'
    host: '%'
    state: present

```

```yml
#/home/einfochips/DevOps_Final/project-directory/roles/webserver/tasks/main.yml
---
# tasks file for roles/webserver
- name: Install Nginx
  apt:
    name: nginx
    state: present
  become: yes

- name: Start Nginx service
  service:
    name: nginx
    state: started
    enabled: true
  become: yes

```

6.  **Role Customization and Variable Definition**

    -   Customize the roles by defining the necessary variables in
        group\_vars or host\_vars as needed for the environment.

    -   Ensure sensitive data like database credentials are managed
         securely.

```yml
#/home/einfochips/DevOps_Final/project-directory/group_vars/database.yml

msql_user: "myuser"
msql_password: "mypassword"
```

7.  **Testing and Validation**

 -   Create a separate playbook for testing the deployment (test.yml)
         that verifies each tier is functioning correctly and cancommunicate with the other tiers.
  - Use Ansible modules and tasks to check the status of services
         and applications.

![](.//media/image2.png)

![](.//media/image3.png)

![](.//media/image4.png)

#### 
