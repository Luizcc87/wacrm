# Deployment Contracts

## Environment Variables
The deployment expects the following environment variables to be present in a `.env` file at the root of the deployment context:

- `POSTGRES_PASSWORD`: The database password.
- `WEB_PORT`: The external port to expose the web service (default 80/443).
- `APP_URL`: The public URL of the application.
