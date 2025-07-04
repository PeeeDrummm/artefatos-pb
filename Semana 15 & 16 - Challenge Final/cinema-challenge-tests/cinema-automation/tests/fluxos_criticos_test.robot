*** Settings ***
Documentation    Testes de Fluxos Críticos (Caminho Feliz).

Resource         ../resources/base.resource

Suite Setup       Iniciar Navegador
Suite Teardown    Fechar Navegador

*** Test Cases ***
Fluxo Reserva
    [Tags]    FRONT    FLUXO_1
    Iniciar Página Limpa
    Ir para Página de Login

    Efetuar Login    user@example.com    senha123
    Validar Alerta Contendo Mensagem    Login realizado com sucesso!

    Ir para Página de Filmes em Cartaz
    Selecionar Filme      3

    Selecionar Sessão     3

    Selecionar Assento    D 5    F 9

    Selecionar Método de Pagamento e Finalizar    Cartão de Crédito

    Realizar Login Admin
    Salvar Token de Autenticação
    Deletar Reserva

Fluxo Histórico
    [Tags]    FRONT    FLUXO_2
    Iniciar Página Limpa
    Ir para Página de Login

    Efetuar Login    user@example.com    senha123
    Validar Alerta Contendo Mensagem    Login realizado com sucesso!

    Ir para Página de Filmes em Cartaz
    Selecionar Filme      3

    Selecionar Sessão     3

    Selecionar Assento    G 4    B 7

    Selecionar Método de Pagamento e Finalizar    PIX

    Ir Para Página de Minhas Reservas
    Validar Reservas

    Realizar Login Admin
    Salvar Token de Autenticação
    Deletar Reserva

Fluxo Busca Filmes
    [Tags]    FRONT    FLUXO_3
    Realizar Login Admin
    Salvar Token de Autenticação
    Criar Filme    resources/fixtures/filme_criacao.json

    Ir para Página de Filmes em Cartaz
    Buscar Filmes e Validar    Borat: O Segundo Melhor Repórter do Glorioso País Cazaquistão Viaja à América

    Deletar Filme