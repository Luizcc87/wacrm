# Fluxo de Atualização com Git Rebase

Este documento descreve como manter o seu repositório fork (`Luizcc87/wacrm`) atualizado com o repositório oficial (`ArnasDon/wacrm`) utilizando a estratégia de **Git Rebase**.

Temos duas versões destas instruções: uma para quem já tem familiaridade técnica com Git e outra simplificada para quem está começando.

---

## Versão Técnica (Para Desenvolvedores)

O fluxo com `rebase` permite manter um histórico linear e limpo, reaplicando os commits do seu fork no topo das atualizações do repositório original (upstream).

### 1. Configurar o Remote Upstream (Apenas a primeira vez)
Adicione o repositório oficial como uma origem secundária (upstream):
```bash
git remote add upstream https://github.com/ArnasDon/wacrm.git
git remote -v
```

### 2. Atualizar a branch principal (No dia a dia)
Sempre que o repositório upstream receber atualizações, execute os seguintes passos na sua branch principal (`main`):

```bash
# 1. Baixar as atualizações do upstream
git fetch upstream

# 2. Reaplicar os seus commits no topo do upstream/main
git rebase upstream/main

# 3. Resolver conflitos (se houver)
# Edite os arquivos conflitantes, depois:
# git add <arquivos_resolvidos>
# git rebase --continue

# 4. Enviar as alterações para o seu fork (forçando o envio)
git push origin main --force
```
> **Nota:** Como o rebase reescreve o histórico dos seus commits locais, é obrigatório o uso do `--force` (ou `-f`) no push para o seu origin.

---

## Versão Simplificada (Para Iniciantes / Leigos)

Imagine que o projeto original do mantenedor (Arnas) é um livro que ele está escrevendo. Você pegou uma cópia desse livro (o seu "fork") e começou a escrever os seus próprios capítulos no final.
Se o Arnas lançar um novo capítulo oficial, como você o adiciona ao seu livro sem bagunçar a ordem?

A ferramenta de **Rebase** pega os capítulos que *você* escreveu, separa eles por um momento, adiciona os capítulos novos do Arnas, e depois coloca os seus capítulos *no final* novamente. Assim, a história continua fazendo sentido e fica bem organizada.

### Passo a Passo:

**Passo 1: Ensinar ao seu projeto onde fica o projeto original**
No seu terminal (tela preta de comandos), você precisa avisar ao seu computador de onde ele deve baixar as atualizações oficiais. Você só precisa fazer isso **uma vez**:
```bash
git remote add upstream https://github.com/ArnasDon/wacrm.git
```

**Passo 2: Baixar e aplicar as novidades**
Sempre que souber que tem uma versão nova, faça isso no terminal:

1. Diga ao computador para "dar uma olhada" nas atualizações:
   ```bash
   git fetch upstream
   ```
2. Mande ele organizar as atualizações antes das suas alterações:
   ```bash
   git rebase upstream/main
   ```
3. *(Opcional)* Se você e o mantenedor alteraram a exata mesma linha de código, o programa vai pausar e avisar que houve um **conflito**. Você precisará abrir o arquivo no editor de código, escolher a versão que prefere (a sua ou a dele) e salvar. Depois, avise que resolveu:
   ```bash
   git add .
   git rebase --continue
   ```
4. Por fim, envie tudo de volta para o seu GitHub. Como mudamos a "ordem", você precisa usar um comando "forçado":
   ```bash
   git push origin main --force
   ```
E pronto! Seu projeto tem todas as novidades oficiais, mais as suas customizações.
