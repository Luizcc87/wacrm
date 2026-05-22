# Research: Docker Swarm on ARM64

- **Decision**: Use standard Docker installation via the official installation script (`get.docker.com`).
- **Rationale**: The official script automatically detects the host architecture (aarch64) and installs the appropriate ARM64 Docker binaries. Docker Swarm mode is built into the Docker engine, so no additional orchestrator tools are needed.
- **Alternatives considered**: Using `apt-get install docker.io` from Ubuntu repositories, but the official Docker repo provides more recent and stable versions suitable for Swarm.

- **Decision**: Ensure Wacrm images are built for both `linux/amd64` and `linux/arm64` using `docker buildx`.
- **Rationale**: ARM64 hosts cannot natively run `linux/amd64` images without emulation, but we want the system to remain portable to standard AMD64 servers. Using `docker buildx` allows creating a single manifest that supports both architectures seamlessly.
