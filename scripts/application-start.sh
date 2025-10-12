#!/bin/bash
echo 'run application-start.sh: ' >> /home/ubuntu/repos/mcp_grinder_server/deploy.log

echo 'systemctl start mcp_grinder_server' >> /home/ubuntu/repos/mcp_grinder_server/deploy.log
systemctl start mcp_grinder_server >> /home/ubuntu/repos/mcp_grinder_server/deploy.log

