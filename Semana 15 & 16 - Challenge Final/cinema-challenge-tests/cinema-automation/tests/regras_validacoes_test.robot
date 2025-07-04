*** Settings ***
Documentation    Testes para o Endpoint de Regras de Negócio e Validações

Resource       ../resources/base.resource

Suite Setup    Criar Sessão API

*** Test Cases ***
Criar Usuário Com E-mail Existente
    [Tags]    API    CT002
    Remover Usuário do Banco de Dados     pedro.teste@qa.com
    Inserir Usuário no Banco de Dados     Pedro Afonso    pedro.teste@qa.com    senha123
    Registrar um Novo Usuário             Pedro Afonso    pedro.teste@qa.com    senha123    invalido
    Validar Código de Status              400
    Validar Mensagem Response             User already exists

Login Com Senha Incorreta
    [Tags]    API    CT006
    Remover Usuário do Banco de Dados     pedro.teste@qa.com
    Inserir Usuário no Banco de Dados     Pedro Afonso    pedro.teste@qa.com    senha123
    Realizar Login Com Senha Incorreta
    Validar Código de Status              401
    Validar Mensagem Response             Invalid email or password

Selecionar Assento Já Ocupado
    [Tags]    API    CT018    AI
    Realizar Login Admin
    Salvar Token de Autenticação
    Obter Primeira Sessão Disponível
    Resetar Assentos Da Sessão

    # --- AÇÃO 1: CRIAR A PRIMEIRA RESERVA (bem-sucedida) ---
    Efetuar Nova Reserva    A    1
    Analisar e Validar Resposta com IA    201    Presença de `paymentStatus: "completed"` e o campo `_id`

    # --- AÇÃO 2: TENTAR CRIAR A MESMA RESERVA NOVAMENTE (mal-sucedida) ---
    Efetuar Nova Reserva    A    1
    Analisar e Validar Resposta com IA    400    The following seats are not available: A1

Criar Sessão Com ID de Filme Inexistente
    [Tags]    API    CT031
    Realizar Login Admin
    Salvar Token de Autenticação

    Obter Primeiro Teatro Disponível
    Criar Nova Sessão de Filme    6859c41523af684f6db4e1f0

    Validar Código de Status      404
    Validar Mensagem Response     Movie not found