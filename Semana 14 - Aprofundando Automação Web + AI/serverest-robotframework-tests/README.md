# 🤖 Automação de Testes Web com Robot Framework na ServeRest

## 📌 Sobre o Projeto

Este projeto consiste na automação de testes E2E (End-to-End) para a aplicação web **ServeRest Frontend**, desenvolvida como parte da dinâmica de Squad do curso **Robot eXpress**.

O objetivo principal foi aplicar os conhecimentos de automação web, utilizando o Robot Framework, e consolidar práticas de trabalho em equipe com versionamento de código, seguindo o fluxo Gitflow.

**Aplicação Alvo:** [ServeRest Frontend](https://compassuolfront.serverest.dev/)

---

## 🎯 Objetivos Principais

- **Desenvolver scripts de teste** robustos e reutilizáveis com Robot Framework.
- **Implementar o padrão Page Object Model (POM)** para desacoplar a lógica dos testes da estrutura das páginas.
- **Garantir a cobertura** dos principais fluxos da aplicação, com cada membro da squad contribuindo com pelo menos dois cenários de teste distintos.
- **Praticar o fluxo de trabalho com Gitflow**, incluindo a criação de branches por tarefa, code review e aprovação de Pull Requests para garantir a qualidade do código.
- **Consolidar boas práticas** de escrita de cenários, organização de `resources` e reuso de código.

---

## 🛠️ Ferramentas e Tecnologias

| Ferramenta          | Uso Principal                                  |
| ------------------- | ---------------------------------------------- |
| **Robot Framework** | Estruturação e execução dos testes automatizados. |
| **VS Code** | Ambiente de desenvolvimento (IDE).             |
| **Git & GitHub** | Versionamento de código e colaboração (Gitflow). |
| **Python** | Linguagem base para o Robot Framework.         |

---

## 📂 Estrutura do Projeto

O repositório foi organizado para garantir escalabilidade e manutenibilidade, separando responsabilidades:

```
.
├── 📁 logs/
│   └── (Gerados após a execução, contêm os relatórios e logs)
│
├── 📁 resources/
│   ├── 📁 common/
│   │   └── common.resource       # Keywords globais (ex: abrir navegador, fechar)
│   ├── 📁 fixtures/
│   │   └── api.json              # Massa de dados para os testes
│   ├── login_keywords.resource   # Keywords da página de Login
│   └── ...                       # Outros resources por página/funcionalidade
│
├── 📁 tests/
│   ├── login_tests.robot         # Cenários de teste para a funcionalidade de Login
│   └── ...                       # Outros arquivos de teste por funcionalidade
│
└── 📄 README.md
```

---

## 🚀 Como Executar os Testes

### Pré-requisitos

Antes de começar, garanta que você tenha o ambiente configurado:

1.  **Python** instalado (versão 3.8 ou superior).
2.  **Git** instalado para clonar o repositório.
3.  **Dependências do projeto** instaladas. Clone o repositório e execute:
    ```bash
    pip install -r requirements.txt
    ```

### Execução

Para executar todos os testes, utilize o comando abaixo na raiz do projeto:

```bash
robot -d ./logs tests/
```

-   `-d ./logs`: Define o diretório `logs` para salvar os relatórios de execução (`log.html` e `report.html`).
-   `tests/`: Aponta para a pasta que contém todos os cenários de teste a serem executados.

---

## ✅ Escopo dos Testes

Foram automatizados os seguintes cenários para cobrir os fluxos críticos da aplicação:

- **Login:**
    - Realizar login com credenciais de administrador válidas.
- **Usuários:**
    - Cadastrar um novo usuário do tipo "Administrador" com dados válidos.
    - Alterar dados de um usuário existente.
    - Listar e validar usuários cadastrados.
- **Produtos:**
    - Cadastrar um novo produto com dados válidos.
    - Listar e validar produtos cadastrados.
    - Alterar dados de um produto existente.
    - Excluir um produto.

---

## 📈 Aprendizados Coletivos

- Aplicação prática do **Gitflow**, resultando em um fluxo de desenvolvimento mais organizado e seguro.
- Aprimoramento na **escrita de testes legíveis, reutilizáveis e de fácil manutenção** através do padrão Page Objects.
- Fortalecimento da cultura de **qualidade de código** por meio de Pull Requests e revisões em pares.

---

## 🤝 Contribuintes

- Thais Nogueira Baldino
- Maria Eduarda Martins Rodrigues
- Brenda Meira
- Pedro Afonso de Alencar Silva