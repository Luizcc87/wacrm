# Quickstart: Wacrm Docker Container

This guide explains how to build and run the Wacrm application using Docker.

## Prerequisites
- Docker installed on your machine.

## Building the Image

To build the Docker image, run the following command from the root of the repository:

```bash
docker build -t wacrm:latest .
```

If you need to build for a specific architecture (e.g., for ARM64 deployment), you can use Docker Buildx:

```bash
docker buildx build --platform linux/arm64,linux/amd64 -t wacrm:latest .
```

## Running the Container

Once built, you can start the application by running the container. Ensure you pass the necessary environment variables required by the application (e.g., Supabase URLs).

```bash
docker run -p 3000:3000 \
  -e NEXT_PUBLIC_SUPABASE_URL=your_supabase_url \
  -e NEXT_PUBLIC_SUPABASE_ANON_KEY=your_supabase_anon_key \
  wacrm:latest
```

The application will be accessible at `http://localhost:3000`.
