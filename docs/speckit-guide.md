# Guia Prático de Desenvolvimento com Spec Kit

O **Spec Kit** é uma metodologia e um conjunto de ferramentas (comandos) desenhados para estruturar o desenvolvimento com Inteligência Artificial. Ele divide a engenharia de software em etapas lógicas: Especificação, Planejamento, Divisão de Tarefas e Implementação.

Este guia serve como um "cheat sheet" (resumo) de como utilizar o Spec Kit no dia a dia do Wacrm.

---

## 🏗️ 1. O Fluxo Padrão: Criando Novas Funcionalidades

Sempre que você for criar uma nova funcionalidade (feature) do zero, siga exatamente esta ordem de comandos interagindo com o Agente de IA:

### Passo 1: Criar a Branch e a Pasta da Feature
```text
/speckit-git-feature integracao-pagamento
```
**O que faz:** Cria uma nova branch Git (ex: `003-integracao-pagamento`) e cria a pasta `specs/003-integracao-pagamento` para guardar a documentação dessa feature.

### Passo 2: Especificar o que será feito (Requisitos)
```text
/speckit-specify Adicionar integração com a API do Mercado Pago para cobrar mensalidades dos usuários. Deve ter webhook para atualizar o status.
```
**O que faz:** O Agente vai gerar o arquivo `spec.md` listando os requisitos não-técnicos, histórias de usuário e critérios de aceite.

### Passo 3: Planejamento Arquitetural (Design)
```text
/speckit-plan
```
**O que faz:** O Agente lerá as especificações e decidirá a arquitetura técnica, gerando os arquivos `plan.md` (o que mudar no código), `data-model.md` (mudanças no banco de dados) e `research.md` (decisões técnicas).

### Passo 4: Gerar o Checklist de Tarefas
```text
/speckit-tasks
```
**O que faz:** Transforma o plano arquitetural em um arquivo `tasks.md` contendo checkboxes rigorosos e sequenciais (ex: `[ ] T001 Criar tabela no banco`, `[ ] T002 Criar endpoint`).

### Passo 5: Executar o Código (Mão na Massa)
```text
/speckit-implement
```
**O que faz:** O Agente de IA começa a programar ativamente. Ele vai ler o arquivo `tasks.md`, escrever os códigos, modificar arquivos e marcar um `[x]` nas tarefas conforme avança.

---

## 🐛 2. Fluxo para Corrigir Bugs (Bugfix)

Corrigir bugs segue o mesmo princípio de uma feature nova, mas com um escopo menor e mais direto.

1. **Inicie a correção:**
   ```text
   /speckit-git-feature fix-login-error
   ```
2. **Especifique o bug:**
   ```text
   /speckit-specify O sistema está dando erro 500 ao tentar fazer login com e-mails que possuem letras maiúsculas. O sistema deve ignorar o case (case-insensitive).
   ```
3. **Planeje e gere tarefas:**
   ```text
   /speckit-plan
   /speckit-tasks
   ```
4. **Corrija:**
   ```text
   /speckit-implement
   ```

---

## 💾 3. Salvando o Progresso (Commits)

Após cada grande fase (por exemplo, após planejar, ou após implementar), é recomendado salvar as alterações no Git. O Spec Kit possui um comando para automatizar isso:

```text
/speckit-git-commit
```
**Quando usar:** 
- Depois de gerar as especificações e tarefas.
- Depois do agente concluir uma etapa de implementação (`/speckit-implement`).
**Dica:** A maioria dos fluxos perguntará se você quer rodar esse hook automaticamente.

---

## 🔄 4. Atualizando a Partir do Repositório Oficial (Mantenedor)

Se o autor original do Wacrm (`ArnasDon/wacrm`) lançar uma atualização e você quiser trazer essas novidades para o seu código sem perder suas customizações, siga o **Git Workflow** baseado em Rebase.

### Passo a passo no Terminal (Git Bash / PowerShell)

1. **Certifique-se de que o repositório original está mapeado (Upstream):**
   *(Só precisa fazer isso uma vez)*
   ```bash
   git remote add upstream https://github.com/ArnasDon/wacrm.git
   ```

2. **Baixe as novidades do autor:**
   ```bash
   git fetch upstream
   ```

3. **Vá para a sua branch principal (main):**
   ```bash
   git checkout main
   ```

4. **Aplique as atualizações via Rebase:**
   Isso fará com que os commits do autor original fiquem na base, e as SUAS alterações sejam aplicadas por cima, mantendo o histórico limpo.
   ```bash
   git rebase upstream/main
   ```

5. **Resolva conflitos (se houverem):**
   Se você modificou um arquivo que o autor original também modificou, o Git pausará e pedirá para você resolver. Você pode usar sua IDE (VS Code) para aceitar as mudanças corretas, rodar `git add .` e depois continuar com `git rebase --continue`.

6. **Envie para o seu GitHub:**
   Como você reescreveu o histórico empurrando seus commits para cima, precisará forçar o push:
   ```bash
   git push origin main --force
   ```

---

## 🛠️ 5. Comandos Adicionais Úteis

- **/speckit-analyze**: Audita a qualidade do trabalho atual. Útil se você achar que as tarefas geradas estão confusas ou que faltam informações na especificação.
- **/speckit-clarify**: Se a especificação inicial for muito vaga, o agente fará perguntas direcionadas para preencher as lacunas antes de codificar.
- **/speckit-git-validate**: Confere se o nome da branch atual segue as convenções e regras do projeto.

---

## 💡 Dicas de Ouro ao Trabalhar com Spec Kit

1. **Nunca pule o Planejamento:** Mesmo que pareça uma alteração besta, rodar `/speckit-plan` evita que a IA quebre outras partes do sistema ao tentar adivinhar a arquitetura de banco de dados ou de pastas.
2. **O Agente obedece o Checklist:** Durante a fase `/speckit-implement`, o Agente **só vai fazer** o que estiver listado em `tasks.md`. Se você notar que faltou algo, adicione manualmente no arquivo `tasks.md` antes de rodar o comando implement.
3. **Revisões Humanas:** O Spec Kit é projetado para fazer pausas entre o Planejamento e a Implementação. Use esse tempo para ler os arquivos `.md` gerados na pasta da sua feature e certifique-se de que as decisões estão corretas. Se não estiverem, basta pedir: *"Ajuste o arquivo spec.md para usar a biblioteca X em vez da Y"* e então gere as tarefas novamente.
