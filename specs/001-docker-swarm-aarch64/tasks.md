# Tasks: Docker Swarm Deployment on Ubuntu aarch64

**Input**: Design documents from `/specs/001-docker-swarm-aarch64/`

## Phase 1: Setup (Shared Infrastructure)

**Purpose**: Project initialization and basic structure

- [x] T001 Create `deploy/` directory at the project root
- [x] T002 [P] Create `deploy/.env.example` based on the deployment contract

---

## Phase 2: Foundational (Blocking Prerequisites)

**Purpose**: Core infrastructure that MUST be complete before ANY user story can be implemented

- [x] T003 Create Docker Swarm installation script in `deploy/setup-swarm.sh`

**Checkpoint**: Foundation ready - user story implementation can now begin

---

## Phase 3: User Story 1 - Deploy Wacrm using Docker Swarm (Priority: P1) 🎯 MVP

**Goal**: Implantação da stack do Wacrm usando Docker Swarm em arquitetura ARM64.

**Independent Test**: Run the deployment scripts on an aarch64 machine and verify Swarm services are active.

### Implementation for User Story 1

- [x] T004 [P] [US1] Develop `deploy/docker-compose.yml` defining the services, networks, and volumes (ensuring multi-arch image compatibility)
- [x] T005 [US1] Develop `deploy/deploy.sh` script to deploy the stack to Swarm
- [x] T006 [US1] Develop `deploy/build.sh` script to compile multi-arch images using `docker buildx`
- [x] T007 [US1] Configure scripts to be executable and add basic echo/log outputs to track progress

**Checkpoint**: At this point, User Story 1 should be fully functional and testable independently

---

## Phase 4: Polish & Cross-Cutting Concerns

**Purpose**: Improvements that affect multiple user stories

- [x] T008 [P] Review `deploy/docker-compose.yml` for security best practices (e.g., resource limits)
- [x] T009 Update main `README.md` to reference the new Swarm deployment guide

---

## Dependencies & Execution Order

### Phase Dependencies

- **Setup (Phase 1)**: No dependencies - can start immediately
- **Foundational (Phase 2)**: Depends on Setup completion - BLOCKS all user stories
- **User Stories (Phase 3+)**: All depend on Foundational phase completion
- **Polish (Final Phase)**: Depends on all desired user stories being complete

### Parallel Opportunities

- T002 can run in parallel with T001 once the directory context is known.
- T004 can run in parallel with T003, as the compose file is separate from the setup script.
