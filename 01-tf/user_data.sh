#!/bin/bash

cd ~
cat <<EOF > awscli.conf
 [general]
 state_file = /var/awslogs/state/agent-state
 
 [/var/log/syslog]
 file = /var/log/syslog
 log_group_name = /var/log/syslog
 log_stream_name = {instance_id}
 datetime_format = %b %d %H:%M:%S
EOF

curl https://s3.amazonaws.com/aws-cloudwatch/downloads/latest/awslogs-agent-setup.py -O
chmod +x ./awslogs-agent-setup.py
sudo python3 ./awslogs-agent-setup.py -n -r us-east-1 -c awscli.conf