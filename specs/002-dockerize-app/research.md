# Research: Dockerize Wacrm App

- **Decision**: Use Next.js Standalone output mode (`output: 'standalone'` in `next.config.ts`).
- **Rationale**: The Next.js standalone mode automatically traces required files and creates a minimal server that only includes production dependencies. This significantly reduces the final Docker image size.
- **Alternatives considered**: Standard `npm start` approach, which requires all dependencies (including `node_modules`) to be present in the final image, leading to a much larger container size.

- **Decision**: Implement a Multi-stage Dockerfile.
- **Rationale**: A multi-stage build separates the dependency installation and build process from the final runtime image. This ensures that development tools and intermediate build files are excluded from the production image.
- **Alternatives considered**: Single-stage build, which would leave unnecessary build artifacts and development dependencies in the production image, increasing size and potential security surface.

- **Decision**: Use `node:18-alpine` (or current LTS alpine) as the base image.
- **Rationale**: Alpine Linux provides a very small base image, which aligns with the requirement to minimize the final container footprint.

- **Decision**: Support cross-architecture builds (AMD64 and ARM64).
- **Rationale**: Since the user previously researched Docker Swarm on ARM64, the Dockerfile should avoid architecture-specific hardcodes and rely on standard cross-platform Node.js base images.
