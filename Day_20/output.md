#### **Project 01**

1.  **Inventory Plugins**

    -   **Activity**: Configure a dynamic inventory plugin to manage a
         growing number of web servers dynamically. Integrate the
         plugin with Ansible to automatically detect and configure
         servers in various environments.

    -   **Deliverable**: Dynamic inventory configuration file or script,
         demonstrating the ability to automatically update the
         inventory based on real-time server data.
```
ansible-inventory -i ansible/inventory/aws_ec2.yml --list
```
```yml
#/home/einfochips/DevOps_Final/Day_20/ansible/inventory/aws_ec2.yml
plugin: aws_ec2
regions:
  - us-east-2
filters:
  instance-state-name: 
    - running
  tag:Name:
    - Neel 
hostnames:
  - dns-name
compose:
  ansible_host: public_dns_name
```
2.  **Performance Tuning**

    -   **Activity**: Tune Ansible performance by adjusting settings
         such as parallel execution (forks), optimizing playbook tasks,
         and reducing playbook run time.

    -   **Deliverable**: Optimized ansible.cfg configuration file,
         performance benchmarks, and documentation detailing changes
         made for performance improvement.

```
#/home/einfochips/DevOps_Final/Day_20/ansible.cfg

[defaults]
forks = 50
gathering = smart
fact_caching = jsonfile
fact_caching_connection = /tmp/ansible_cache
host_key_checking = False
remote_user=ubuntu

[ssh_connection]
ssh_args = -o ControlMaster=auto -o ControlPersist=60s
pipelining = True
```

```yml
#/home/einfochips/DevOps_Final/Day_20/deploy.yml

---
---
- name: Optimize Deployment
  hosts: all
  gather_facts: yes

  tasks:
    - name: Ensure nginx is installed
      apt:
        name: nginx
        state: present
      async: 300
      poll: 0

    - name: Wait for nginx to be installed
      async_status:
        jid: "{{ item.ansible_job_id }}"
      register: async_results
      until: async_results.finished
      retries: 30
      delay: 10
      with_items:
        - "{{ ansible_job_ids }}"
      when: async_results.ansible_job_id is defined

    - name: Check if my_var is defined
      debug:
        msg: "The value of my_var is {{ my_var }}"
      when: my_var is defined

    - name: Fail if my_var is not defined
      fail:
        msg: "my_var is not defined!"
      when: my_var is not defined
 

```

```py
#/home/einfochips/DevOps_Final/Day_20/script.py
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

3.  **Debugging and Troubleshooting Playbooks**

    -   **Activity**: Implement debugging strategies to identify and
         resolve issues in playbooks, including setting up verbose
         output and advanced error handling.

    -   **Deliverable**: Debugged playbooks with enhanced error handling
         and logging, including a troubleshooting guide with common
        issues and solutions.

```
ansible-playbook -i ansible/inventory/aws_ec2.yml deploy.yml -vvv
```
```
ansible-playbook -i script.py deploy.yml --check
```
4.  **Exploring Advanced Modules**

    -   **Activity**: Use advanced Ansible modules such as
         docker\_container to manage containerized applications and
        aws\_ec2 for AWS infrastructure management, demonstrating
         their integration and usage.

    -   **Deliverable**: Playbooks showcasing the deployment and
         management of Docker containers and AWS EC2 instances, along
        with documentation on the benefits and configurations of these
         advanced modules.

```yml

#/home/einfochips/DevOps_Final/Day_20/docker_container.yml
---
- name: Manage Docker Containers
  hosts: all
  become: yes
  tasks:
    - name: Ensure Docker is installed
      apt:
        name: docker.io
        state: present

    - name: Pull the nginx image
      docker_image:
        name: nginx
        source: pull

    - name: Run a Docker container
      docker_container:
        name: nginx_container
        image: nginx
        state: started
        ports:
          - "85:80"

    - name: Check Docker container status
      command: docker ps
      register: docker_status

    - name: Print Docker container status
      debug:
        var: docker_status.stdout_lines

```



![](.//media/image5.png)

![](.//media/image3.png)

![](.//media/image2.png)

![](.//media/image4.png)