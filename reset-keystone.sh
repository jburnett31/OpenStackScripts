#!/bin/bash

mysql -u root -pabc123 -e "drop database keystone;"
mysql -u root -pabc123 -e "create database keystone;"
mysql -u root -pabc123 -e "grant all on keystone.* to 'keystone'@'localhost' identified by 'password';"
keystone-manage db_sync
