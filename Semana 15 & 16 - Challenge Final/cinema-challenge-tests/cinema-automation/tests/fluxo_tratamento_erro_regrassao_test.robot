*** Settings ***
Documentation    Testes de Fluxo de Tratamento de Erro e Regressão.

Resource       ../resources/base.resource

Suite Setup       Iniciar Navegador
Suite Teardown    Fechar Navegador

*** Test Cases ***
Fluxo de Feedback de Erro - Usuário Duplicado
    [Tags]    FRONT    FLUXO_4
    Remover Usuário do Banco de Dados     pedro.teste@qa.com
    Inserir Usuário no Banco de Dados     Pedro Afonso    pedro.teste@qa.com    senha123

    Iniciar Página Limpa
    Ir para Página de Registro
    Efetuar Registro                      Pedro Afonso    pedro.teste@qa.com    senha123
    Validar Alerta Contendo Mensagem      User already exists

Fluxo de Feedback de Erro - Senha < 6
    [Tags]    FRONT    FLUXO_5
    Remover Usuário do Banco de Dados     pedro.teste@qa.com

    Iniciar Página Limpa
    Ir para Página de Registro
    Efetuar Registro                      Pedro Afonso    pedro.teste@qa.com    12345
    Validar Alerta Contendo Mensagem      Validation failed

Fluxo de Feedback de Erro - Filme Inexistente
    [Tags]    FRONT    FLUXO_6
    Realizar Login Admin
    Salvar Token de Autenticação
    Criar Filme    resources/fixtures/filme_criacao.json

    Ir para Página de Filmes em Cartaz
    Buscar Filmes e Validar             Borat: O Segundo Melhor Repórter do Glorioso País Cazaquistão Viaja à América

    Deletar Filme

    Go To                               ${BASE_FRONT_URL}movies/${FILME_ID}
    Validar Alerta Contendo Mensagem    Erro ao carregar informações. Tente novamente mais tarde.

Fluxo de Feedback de Erro - Sessão Inexistente
    [Tags]    FRONT    FLUXO_7
    Realizar Login Admin
    Salvar Token de Autenticação

    Criar Filme                           resources/fixtures/filme_criacao.json
    Listar Todas Sessões de Filmes        1
    Criar Sala                            Teatro Compass PB    180    VIP

    Criar Sessão de Filme                 2025-07-03T00:34:20.707Z    40.00    20.00
    Atualizar Sessão de Filme             2025-08-03T00:34:20.707Z    60.00    30.00

    Deletar Sessão de Filme
    Analisar e Validar Resposta com IA    200    Session removed
    
    Deletar Sala
    Deletar Filme

    Go To                                  ${BASE_FRONT_URL}sessions/${SESSAO_ID}
    Validar Alerta Contendo Mensagem       Erro ao carregar informações. Tente novamente mais tarde.