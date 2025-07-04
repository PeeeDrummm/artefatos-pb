<p align="center">
  <h1 align="center">🎬 Cinema Challenge | Automação de Testes</h1>
  <h3 align="center">🔍 Testes funcionais robustos com Robot Framework + GitHub Actions</h3>
</p>

<p align="center">
  <a href="https://github.com/PeeeDrummm/cinema-challenge-tests/actions/workflows/ci-cd-pipeline.yml">
    <img src="https://img.shields.io/github/actions/workflow/status/PeeeDrummm/cinema-challenge-tests/ci-cd-pipeline.yml?branch=develop&style=for-the-badge&logo=github-actions&logoColor=white&label=CI/CD%20Pipeline" alt="CI/CD Status" />
  </a>
  <img src="https://img.shields.io/badge/Robot%20Framework-333333?style=for-the-badge&logo=robotframework&logoColor=white" />
  <img src="https://img.shields.io/badge/Playwright-45ba4b?style=for-the-badge&logo=playwright&logoColor=white" />
  <img src="https://img.shields.io/badge/python-3.11-3776AB?style=for-the-badge&logo=python&logoColor=white" />
</p>
<p align="center">
  <img src="https://media1.tenor.com/m/9gyW2QldGvkAAAAd/me-atrapaste-es-cine.gif" width="670" />
</p>

---

## 📽️ Sobre o Projeto

Este repositório reúne os **testes automatizados** para o [Cinema Challenge Front](https://github.com/juniorschmitz/cinema-challenge-front) e [Cinema Challenge Back](https://github.com/juniorschmitz/cinema-challenge-back), utilizando **Robot Framework** com **Playwright** e integração contínua com **GitHub Actions**.

A automação cobre fluxos críticos e funcionalidades da aplicação, com validações para o backend (API REST) e frontend (UI).

---

## 📊 Status & Relatórios

| Recurso | Link |
|---------|------|
| 🔥 **Status da Pipeline** | [![Status](https://img.shields.io/github/actions/workflow/status/PeeeDrummm/cinema-challenge-tests/ci-cd-pipeline.yml?branch=develop&logo=github)](https://github.com/PeeeDrummm/cinema-challenge-tests/actions/workflows/ci-cd-pipeline.yml) |
| 📑 **Relatório Completo** | [📊 report.html](https://peeedrummm.github.io/cinema-challenge-tests/report.html) |
| 📝 **Log Detalhado** | [📄 log.html](https://peeedrummm.github.io/cinema-challenge-tests/log.html) |

---

## 🛠️ Tecnologias Utilizadas

  - 🐍 **Python 3.11**
  - 🤖 **Robot Framework**
  - 🌍 **Robot Framework Browser (Playwright)**
  - 🚀 **GitHub Actions (CI/CD)**
  - 📊 **GitHub Pages**
  - 📦 **MongoDB**
  - 🔑 **JWT Authentication**

---

## ⚙️ Como Executar Localmente

```bash
# Clonar repositório
git clone https://github.com/PeeeDrummm/cinema-challenge-tests.git
cd cinema-automation

# Criar ambiente virtual
python -m venv .venv
source .venv/bin/activate  # Linux/Mac
.venv\Scripts\activate   # Windows

# Instalar dependências
pip install -r requirements.txt
rfbrowser init

# Rodar os testes
robot --outputdir logs tests/
```

---

## 🧱 Estrutura do Projeto

```
📁 cinema-challenge-tests/
├── .github/workflows/         # Pipelines de CI/CD e deploy
├── cinema-automation/         # Código de testes automatizados
│   ├── logs/                  # Relatórios e evidências. Gerado pelo Actions. Não Commitados.
│   ├── resources/             # Keywords e mapeamentos (Pages, Services, Fixtures)
│   ├── tests/                 # Casos de teste organizados
│   ├── utils/                 # Helpers e bibliotecas customizadas
│   └── requirements.txt       # Requisitos para rodar a suíte de testes
├── Mapa Mental.xmind          # Mapa Mental da API
├── Matriz de Risco.xlsx       # Análise de risco
├── Execução de Testes.xlsx    # Evidências, Planejamento e Resultado de execuções
├── Plano de Testes.pdf        # Plano de Testes
├── Exploração Postman.json    # Collection do Postman dos Endpoints da API
├── Sessão de Teste.docx       # Evidências exploratórias
└── README.md
```

---

## 🚀 GitHub Actions e Deploy

- 🚀 Push na `develop` executa a pipeline automaticamente
- ✅ Testes bem-sucedidos geram PR automática para `main`
- 🌐 Relatórios são publicados automaticamente no GitHub Pages

---

## 🔐 Segredos Necessários (GitHub)

| Variável | Descrição |
|----------|-----------|
| `MONGO_URI` | Conexão com banco MongoDB |
| `JWT_SECRET` | Chave JWT para autenticação |
| `PAT` | Token de acesso ao GitHub (Personal Access Token) |
| `GEMINI_API_KEY` | Chave API Google Gemini LLM |

---

## 💡 Inovações Aplicadas

- 💬 Validação com IA usando Gemini
- 🔄 CI/CD automatizado com merge inteligente
- 📚 Organização modular com Page e Service Objects
- 🤖 Geração e reaproveitamento de dados dinâmicos

---

## 📄 Licença

Distribuído sob licença MIT. Veja [`LICENSE`](https://github.com/PeeeDrummm/cinema-challenge-tests/blob/main/LICENSE "`LICENSE`") para detalhes.

---

<p align="center">
  <img src="https://media4.giphy.com/media/v1.Y2lkPTc5MGI3NjExeDE5b2xhOHo4Znc1d3BtOW54dm0xajYxamdqZmVlb3l5bGp1aG1nNiZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/gG6OcTSRWaSis/giphy.gif" width="670" />
</p>

<p align="center">
  <img src="https://media.giphy.com/media/ZVik7pBtu9dNS/giphy.gif" width="60"/><br>
  Feito com ❤️ por <a href="https://github.com/PeeeDrummm">Pedro Afonso</a>
</p>
