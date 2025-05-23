# 📍 Projeto de Testes Automatizados de API REST - Restful Booker

Este repositório apresenta uma implementação completa de testes automatizados para a API [Restful Booker](https://restful-booker.herokuapp.com/) utilizando o **Robot Framework**.

## 📁 Estrutura do Projeto

```
Teste ReqRes API/
├── tests/
│   ├── auth.robot
│   └── booking.robot
├── resources/
│   ├── auth.resource
│   ├── booking.resource
│   ├── healthcheck.resource
│   └── variables.resource
├── logs/  (gerado após execução)
```

## ⚖️ Cobertura de Testes
- [x] Health Check (GET /ping)
- [x] Geração de Token (POST /auth)
- [x] Criação de Reserva (POST /booking)
- [x] Listagem de Reservas (GET /booking)
- [x] Filtro de Reserva por nome, sobrenome e datas
- [x] Consulta de Reserva por ID (GET /booking/{id})
- [x] Atualização Completa (PUT /booking/{id})
- [x] Atualização Parcial (PATCH /booking/{id})
- [x] Exclusão de Reserva (DELETE /booking/{id})

## ✅ Execução dos Testes

Abra o terminal na raiz do projeto e execute:

```bash
robot -d logs tests/
```

- Os relatórios serão salvos na pasta `logs/`:
  - `report.html`: resumo geral
  - `log.html`: detalhes passo a passo
  - `output.xml`: para uso com ferramentas de reprocessamento

## 📎 Anexo

A pasta [`attachment/`](attachment/) contém a documentação da API (Swagger / Apidoc) usada durante o desenvolvimento dos testes.

Você pode abrir o arquivo `restful-booker.html` no navegador para visualizar as rotas e exemplos da API.
