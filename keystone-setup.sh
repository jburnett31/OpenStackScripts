#!/bin/bash
# Modify these variables as needed
ADMIN_PASSWORD=${ADMIN_PASSWORD:-password}
SERVICE_PASSWORD=${SERVICE_PASSWORD:-$ADMIN_PASSWORD}
DEMO_PASSWORD=${DEMO_PASSWORD:-$ADMIN_PASSWORD}
export OS_SERVICE_TOKEN="password"
export OS_SERVICE_ENDPOINT="http://localhost:35357/v2.0"
SERVICE_TENANT_NAME=${SERVICE_TENANT_NAME:-service}
#
MYSQL_USER=keystone
MYSQL_DATABASE=keystone
MYSQL_HOST=localhost
MYSQL_PASSWORD=password
#
KEYSTONE_REGION=RegionOne
KEYSTONE_HOST=10.10.10.10
# Shortcut function to get a newly generated ID
function get_field() {
 while read data; do
 if [ "$1" -lt 0 ]; then
 field="(\$(NF$1))"
 else
 field="\$$(($1 + 1))"
 fi
 echo "$data" | awk -F'[ \t]*\\|[ \t]*' "{print $field}"
 done
}
# Tenants
ADMIN_TENANT=$(keystone tenant-create --name=admin | grep " id " | get_field
 2)
DEMO_TENANT=$(keystone tenant-create --name=demo | grep " id " | get_field
 2)
SERVICE_TENANT=$(keystone tenant-create --name=$SERVICE_TENANT_NAME | grep "
 id " | get_field 2)
# Users
ADMIN_USER=$(keystone user-create --name=admin --pass="$ADMIN_PASSWORD" --
email=admin@domain.com | grep " id " | get_field 2)
DEMO_USER=$(keystone user-create --name=demo --pass="$DEMO_PASSWORD" --
email=demo@domain.com --tenant-id=$DEMO_TENANT | grep " id " | get_field 2)