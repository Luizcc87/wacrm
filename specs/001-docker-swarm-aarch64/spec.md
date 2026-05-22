# Feature Specification: Docker Swarm Deployment on Ubuntu aarch64

**Feature Branch**: `001-docker-swarm-aarch64`

**Created**: 2026-05-22

**Status**: Draft

**Input**: User description: "Criar infraestrutura de deployment do wacrm usando Docker Swarm para um VPS rodando Ubuntu na arquitetura aarch64 (ARM64). Deve incluir os arquivos do docker-compose e scripts de configuração necessários."

## User Scenarios & Testing *(mandatory)*

### User Story 1 - Deploy Wacrm using Docker Swarm (Priority: P1)

Como um administrador de sistemas, eu quero implantar o Wacrm usando o Docker Swarm em uma VPS Ubuntu aarch64 (ARM64), para que a aplicação tenha alta disponibilidade e seja fácil de escalar e gerenciar no meu servidor ARM.

**Why this priority**: É o requisito principal para permitir que o sistema rode na arquitetura exigida de forma orquestrada.

**Independent Test**: Pode ser totalmente testado rodando o script de deploy numa máquina ARM64 e validando se os serviços do Docker Swarm ficam ativos.

**Acceptance Scenarios**:

1. **Given** uma VPS Ubuntu aarch64 limpa, **When** os scripts de configuração inicial são executados, **Then** o Docker e o Docker Swarm são instalados e inicializados com sucesso.
2. **Given** um Docker Swarm inicializado, **When** a stack (`docker-compose`) do Wacrm é implantada, **Then** todos os containers iniciam corretamente na arquitetura ARM64.

### Edge Cases

- O que acontece se a VPS não possuir as dependências básicas instaladas?
- Como o sistema lida com falhas durante o download das imagens Docker (timeout, sem internet)?
- O que acontece se a porta 80/443 já estiver em uso na VPS?

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: O sistema DEVE fornecer um arquivo `docker-compose.yml` (ou `docker-stack.yml`) compatível com Docker Swarm.
- **FR-002**: O sistema DEVE incluir scripts de configuração automatizados (shell scripts) para instalar e inicializar o Docker Swarm no Ubuntu aarch64.
- **FR-003**: O sistema DEVE garantir que todas as imagens Docker referenciadas possuam suporte nativo ou sejam construídas usando multi-architecture builds (`linux/amd64` e `linux/arm64`).
- **FR-004**: O sistema DEVE fornecer um script simplificado para realizar o deploy da stack no cluster Swarm (`deploy.sh`).

### Key Entities *(include if feature involves data)*

- **Docker Swarm Cluster**: O ambiente de orquestração rodando na VPS.
- **Wacrm Service Stack**: O conjunto de serviços (web, banco de dados, etc.) definidos no arquivo de configuração do compose.

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: Os scripts de configuração e deploy executam com sucesso sem intervenção manual após a parametrização inicial.
- **SC-002**: Todos os serviços do Wacrm iniciam com sucesso em um host ARM64 num período máximo de 10 minutos após o início do deploy.
- **SC-003**: A aplicação fica acessível via rede externa (HTTP/HTTPS) logo após o deploy ser concluído.

## Assumptions

- A VPS tem uma instalação fresca (limpa) do Ubuntu Server.
- O administrador tem acesso SSH com privilégios de `sudo` na VPS.
- As portas de rede necessárias pelo Wacrm (ex: 80, 443) estão liberadas no firewall da VPS.
- As imagens base utilizadas nos Dockerfiles atuais do Wacrm oferecem suporte à arquitetura ARM64 (caso contrário, precisarão ser adaptadas na fase de implementação).
