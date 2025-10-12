#!/bin/bash
echo 'run before-install.sh: ' >> /home/ubuntu/repos/mcp_grinder_server/deploy.log

echo 'systemctl stop mcp_grinder_server' >> /home/ubuntu/repos/mcp_grinder_server/deploy.log
systemctl stop mcp_grinder_server >> /home/ubuntu/repos/mcp_grinder_server/deploy.log
