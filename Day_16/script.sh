#!/bin/bash

ansible green -i inventory.ini -m shell -a "df -h"
ansible green -i inventory.ini -m apt -a "name=nginx state=present" --become
ansible green -i inventory.ini -m apt -a "upgrade=dist" --become
