#!/bin/bash

echo "My First Bash Script....."
echo "========================="

echo "Todays Date is > " $(date);

echo "Username is > " $(uname -a);

echo "Hostname is > " $(hostname);

echo "IP Address is > " && hostname -I | awk -F " " '{print $1}';

echo "Currently logged in user > " && whoami;

echo "Memory > " $(free -m);


echo "Disk usage > " && df - h /;

echo "DNS Info > " && grep "nameserver" /etc/resolv.conf
