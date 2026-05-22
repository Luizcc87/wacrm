# Guia de Implantação e Redes - Wacrm

Este diretório contém a infraestrutura necessária para realizar o deploy do Wacrm usando Docker Swarm. 
O sistema foi projetado para ser agnóstico em relação ao banco de dados, oferecendo duas "stacks" (arquiteturas) principais.

## 1. Escolhendo a Stack (Arquitetura)

### Opção A: Stack com Banco Local (Postgres 18)
Utiliza o arquivo `docker-compose.postgres.yml`. Ideal para quem não quer depender de serviços externos. O banco de dados roda na própria VPS junto com a aplicação.
- **Variáveis essenciais no `.env`**:
  ```env
  POSTGRES_PASSWORD=sua_senha_super_secreta
  DATABASE_URL=postgres://postgres:sua_senha_super_secreta@db:5432/postgres
  ```

### Opção B: Stack com Supabase Cloud
Utiliza o arquivo `docker-compose.supabase.yml`. Ideal para produção em larga escala. O serviço do banco de dados foi removido do Docker, e a aplicação Wacrm conecta diretamente na nuvem do Supabase.
- **Variáveis essenciais no `.env`**:
  ```env
  DATABASE_URL=postgres://postgres.[projeto]:[senha]@aws-0-[regiao].pooler.supabase.com:6543/postgres
  ```

## 2. Como Fazer o Deploy

O script `deploy.sh` foi atualizado para aceitar o arquivo da stack como parâmetro.
Para realizar a implantação, rode:

```bash
# Para fazer deploy com o banco local:
./deploy.sh docker-compose.postgres.yml

# Ou, para fazer deploy usando Supabase Cloud:
./deploy.sh docker-compose.supabase.yml
```

---

## 3. Configurando Rota pelo Cloudflare Tunnel (Painel)

Para expor o Wacrm para a internet de forma segura (com SSL/HTTPS automático) sem precisar abrir portas no roteador/VPS, o **Cloudflare Tunnel** é a melhor solução.

Como o nosso serviço Web está conectado na rede `network_swarm_public`, você pode apontar o seu túnel diretamente para o nome do serviço.

### Passo a Passo no Painel do Cloudflare (Zero Trust)
1. Acesse o **Cloudflare Zero Trust** (https://one.dash.cloudflare.com/).
2. No menu lateral, vá em **Networks** -> **Tunnels**.
3. Clique em **Create a tunnel**, escolha **Cloudflared** e dê um nome (ex: `wacrm-tunnel`).
4. **Instale o conector:** Siga as instruções do painel para rodar o comando de instalação do túnel na sua VPS (um simples comando `docker run` ou instalação direta no Ubuntu usando o pacote `.deb`).
5. **Configurando a Rota (Public Hostname):**
   - Na aba "Public Hostname", clique em **Add a public hostname**.
   - **Subdomain**: Ex: `app` ou `crm` (como vai ficar na URL).
   - **Domain**: Escolha o seu domínio que já está no Cloudflare (ex: `seudominio.com.br`).
   - **Service**: 
     - *Type*: `HTTP`
     - *URL*: `wacrm_web:3000` (Atenção: como estamos usando Docker Swarm, o DNS interno do Docker junta o nome da stack com o serviço: `<stack>_<servico>`. Como nossa stack chama `wacrm` e o serviço `web`, a URL correta é `wacrm_web:3000`. O Node.js roda internamente na porta **3000**).
6. Salve o Hostname. Em questão de segundos, a sua aplicação Wacrm já estará disponível em `https://app.seudominio.com.br` com proteção anti-DDoS e certificado SSL válidos!
