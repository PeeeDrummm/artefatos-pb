*** Settings ***
Documentation    Testes para o Endpoint de Admin  

Resource       ../resources/base.resource

Suite Setup    Criar Sessão API

*** Test Cases ***
Filme CRUD
    [Tags]    API    CT024    AI
    Realizar Login Admin
    Salvar Token de Autenticação

    Criar Filme    resources/fixtures/filme_criacao.json
    Listar Todos os Filmes    1
    
    # --- ATUALIZADA/DELETA O FILME CRIADO EM "Criar Filme" ---
    Atualizar Filme    resources/fixtures/filme_atualizacao.json
    Deletar Filme
    Analisar e Validar Resposta com IA    200    Movie removed

    # --- ATUALIZA/DELETA UM FILME PELO SEU ID ---
    # Atualizar Filme    resources/fixtures/filme_atualizacao.json    686594e782947cf44ba1268b
    # Deletar Filme    686594e782947cf44ba1268b

Salas CRUD
    [Tags]    API    CT025    AI
    Realizar Login Admin
    Salvar Token de Autenticação

    Criar Sala    Teatro Compass PB    180    VIP
    Listar Todas as Salas    #Passar o Index 1, 2, 3... Se precisar.

    # --- ATUALIZADA/DELETA A SALA CRIADA EM "Criar SALA" ---
    Atualizar Sala    Teatro VIP Atualizado    360    IMAX
    Deletar Sala      ${SALA_ID}
    Analisar e Validar Resposta com IA    200    Theater removed

    # --- ATUALIZADA/DELETA UM SALA PELO SEU ID" ---
    # Atualizar Sala    Teatro VIP Atualizado    360    IMAX    ID_CUSTOMIZADO
    # Deletar Sala      6865b1f382947cf44ba12abc

Sessões de Filme CRUD
    [Tags]    API    CT026    AI
    Realizar Login Admin
    Salvar Token de Autenticação

    Criar Filme        resources/fixtures/filme_criacao.json
    Listar Todas Sessões de Filmes    1
    Criar Sala         Teatro Compass PB    180    VIP

    Criar Sessão de Filme        2025-07-03T00:34:20.707Z    40.00    20.00

    Atualizar Sessão de Filme    2025-08-03T00:34:20.707Z    60.00    30.00

    Deletar Sessão de Filme
    Analisar e Validar Resposta com IA    200    Session removed
    
    Deletar Sala
    Deletar Filme