#!/bin/bash
echo 'run after_install.sh: ' >> /home/ubuntu/repos/mcp_grinder_server/deploy.log

echo 'cd /home/ubuntu/repos/mcp_grinder_server' >> /home/ubuntu/repos/mcp_grinder_server/deploy.log
cd /home/ubuntu/repos/mcp_grinder_server >> /home/ubuntu/repos/mcp_grinder_server/deploy.log

echo 'uv sync' >> /home/ubuntu/repos/mcp_grinder_server/deploy.log
/home/ubuntu/.local/bin/uv sync >> /home/ubuntu/repos/mcp_grinder_server/deploy.log
