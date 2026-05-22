# Quickstart: Deploying Wacrm on Swarm

1. SSH into your Ubuntu aarch64 VPS.
2. Clone the repository and navigate to the `deploy/` folder.
3. Run `chmod +x *.sh` to make the scripts executable.
4. Run `./setup-swarm.sh` to install Docker and initialize the Swarm cluster.
5. Create a `.env` file with your production environment variables.
6. Run `./deploy.sh` to start the Wacrm stack.
