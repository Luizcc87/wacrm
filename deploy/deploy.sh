#!/bin/bash
set -e

echo "======================================"
echo " Deploying Wacrm to Docker Swarm      "
echo "======================================"

if [ ! -f .env ]; then
  echo "Error: .env file not found."
  echo "Please copy .env.example to .env and configure your variables."
  exit 1
fi

# Load env vars for stack deploy (docker stack deploy doesn't read .env natively in some setups)
set -a
source .env
set +a

echo "Deploying the stack 'wacrm'..."
docker stack deploy -c docker-compose.yml wacrm

echo "======================================"
echo " Deployment triggered successfully.   "
echo " Run 'docker service ls' to monitor.  "
echo "======================================"
