#!/bin/bash

mkdir -p /var/backup

tar cvf /var/backup/home.tar /home/*

mv /var/backup/home.tar /var/backup/home.07162021.tar

ls -lah /var/backup > file_report.txt

free -h > /var/backup/disk_report.txt free -h
