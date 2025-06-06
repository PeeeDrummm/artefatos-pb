# 📦 ServeRest-Tests

Repositório de testes automatizados da API **ServeRest**, desenvolvidos com **Robot Framework**, organizados por endpoint e seguindo boas práticas de testes automatizados.

---

## 📁 Estrutura do Projeto

```
ServeRest-Tests/
├── tests/
│   ├── login_tests.robot
│   ├── usuarios_tests.robot
│   ├── produtos_tests.robot
│   └── carrinhos_tests.robot
│
├── resources/
│   ├── login_keywords.resource
│   ├── usuarios_keywords.resource
│   ├── produtos_keywords.resource
│   ├── carrinhos_keywords.resource
│   └── common.resource
│
├── variables/
│   └── env_variables.robot
│
├── data/
│   ├── static/
│   │   ├── emails_invalidos.robot
│   │   ├── emails_proibidos.robot
│   │   └── senhas_invalidas.robot
│   └── dynamic/
│       └── usuario_valido.robot
│
├── reports/
│   ├── log.html
│   ├── output.xml
│   └── report.html
│
└── README.md
```

---

## 🧪 Execução dos Testes

Antes de executar, ative o ambiente virtual e vá até a raiz do projeto.

### ✅ Executar todos os testes
```bash
robot -d reports tests/
```

### ▶️ Executar por suite de testes
```bash
robot -d reports tests/login_tests.robot
robot -d reports tests/usuarios_tests.robot
robot -d reports tests/produtos_tests.robot
robot -d reports tests/carrinhos_tests.robot
```

### 🔖 Executar por TAG primária (por tipo de requisição)
```bash
robot -d reports -i POSTLOGIN tests/
robot -d reports -i POSTUSUARIO tests/
robot -d reports -i PUTUSUARIO tests/
robot -d reports -i POSTPRODUTO tests/
robot -d reports -i PUTPRODUTO tests/
robot -d reports -i DELETEPRODUTO tests/
robot -d reports -i POSTCARRINHO tests/
robot -d reports -i DELETECARRINHO tests/
```

### 🧪 Executar por caso de teste (TAG secundária - CTxxx)
```bash
robot -d reports -i CT003 tests/
robot -d reports -i CT012 tests/
robot -d reports -i CT024 tests/
```

---

## 🐞 Bugs Conhecidos (Erro esperado)

Esses testes irão **falhar propositalmente** por inconsistência conhecida na API ServeRest.

| Caso   | Descrição                                        |
|--------|--------------------------------------------------|
| CT004  | Cadastro com domínio de e-mail proibido          |
| CT005  | Cadastro com senha de 4 caracteres               |
| CT006  | Cadastro com senha de 11 caracteres              |

> ⚠️ **Importante**: o caso **CT012** exige aguardar **10 minutos** para que o token expire. Por isso, o teste **ficará parado no terminal durante esse tempo** antes de seguir com a validação. Isso é esperado e faz parte da lógica do cenário.

---

## ⏱️ Delay Global

Todos os testes possuem `Test Teardown` com `Sleep` de **0 segundos**, variável `${global_delay}` definido no arquivo:
```
variables/env_variables.robot
```

O valor padrão é `0s`, mas recomenda-se ajustar para `2s` ao executar localmente a API, para evitar sobrecarga e falhas por concorrência.

---

## 👷‍♂️ Manutenção

- Projeto construído para rodar de forma **modular e isolada**
- Uso da **FakeLibrary** para dados dinâmicos
- Carrinhos são **cancelados automaticamente** ao final dos testes (teardown específico)