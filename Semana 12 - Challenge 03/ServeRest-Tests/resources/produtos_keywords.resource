*** Settings ***
Documentation    Keywords e Variáveis para Ações do Endpoint /produtos
Resource         ../resources/common.resource
Library          FakerLibrary
Library          String

*** Keywords ***
Realizar Login Como Admin
    &{payload}=    Create Dictionary
    ...           email=fulano@qa.com
    ...           password=teste
    ${response}=  POST On Session    ServeRest    /login    data=${payload}
    Set Global Variable    ${auth_token}    ${response.json()["authorization"]}

Esperar Expiração do Token
    Sleep    660s

POST Criar Produto com Token
    ${nome_produto}=         FakerLibrary.Word
    ${preco_produto}=        Set Variable    777
    ${descricao_produto}=    Set Variable    Produto de teste
    ${quantidade_produto}=   Set Variable    5

    &{headers}=    Create Dictionary    Authorization=${auth_token}
    &{payload}=    Create Dictionary
    ...           nome=${nome_produto}
    ...           preco=${preco_produto}
    ...           descricao=${descricao_produto}
    ...           quantidade=${quantidade_produto}

    ${response}=  POST On Session    ServeRest    /produtos    headers=${headers}    data=${payload}    expected_status=ANY
    Log To Console    Response: ${response.content}
    Set Global Variable    ${response}

POST Criar Produto Sem Token
    ${nome_produto}=         FakerLibrary.Word
    ${preco_produto}=        Set Variable    777
    ${descricao_produto}=    Set Variable    Produto sem token
    ${quantidade_produto}=   Set Variable    5

    &{payload}=    Create Dictionary
    ...           nome=${nome_produto}
    ...           preco=${preco_produto}
    ...           descricao=${descricao_produto}
    ...           quantidade=${quantidade_produto}

    ${response}=  POST On Session    ServeRest    /produtos    data=${payload}    expected_status=ANY
    Log To Console    Response: ${response.content}
    Set Global Variable    ${response}

Gerar Dados de Produto
    ${nome_produto}=         FakerLibrary.Word
    Set Suite Variable       ${nome_produto}

POST Criar Produto com Nome Gerado
    ${preco_produto}=        Set Variable    777
    ${descricao_produto}=    Set Variable    Produto para duplicação
    ${quantidade_produto}=   Set Variable    10

    &{headers}=    Create Dictionary    Authorization=${auth_token}
    &{payload}=    Create Dictionary
    ...           nome=${nome_produto}
    ...           preco=${preco_produto}
    ...           descricao=${descricao_produto}
    ...           quantidade=${quantidade_produto}
    ${response}=  POST On Session    ServeRest    /produtos    headers=${headers}    data=${payload}    expected_status=ANY
    Log To Console    Produto criado: ${response.content}
    Set Suite Variable    ${response}

POST Criar Produto com Mesmo Nome
    ${preco_produto}=        Set Variable    777
    ${descricao_produto}=    Set Variable    Tentativa duplicada
    ${quantidade_produto}=   Set Variable    3

    &{headers}=    Create Dictionary    Authorization=${auth_token}
    &{payload}=    Create Dictionary
    ...           nome=${nome_produto}
    ...           preco=${preco_produto}
    ...           descricao=${descricao_produto}
    ...           quantidade=${quantidade_produto}
    ${response}=  POST On Session    ServeRest    /produtos    headers=${headers}    data=${payload}    expected_status=ANY
    Log To Console    Requisição duplicada: ${response.content}
    Set Global Variable    ${response}

# Gerar ID Inexistente
#     ${id_inexistente}=    Generate Random String    16    [LETTERS]
#     Set Suite Variable    ${id_inexistente}

PUT Criar Produto Com ID Inexistente
    ${nome_produto}=         FakerLibrary.Word
    ${preco_produto}=        Set Variable    777
    ${descricao_produto}=    Set Variable    Criado via PUT com ID desconhecido
    ${quantidade_produto}=   Set Variable    12

    &{headers}=    Create Dictionary    Authorization=${auth_token}
    &{payload}=    Create Dictionary
    ...           nome=${nome_produto}
    ...           preco=${preco_produto}
    ...           descricao=${descricao_produto}
    ...           quantidade=${quantidade_produto}

    ${response}=  PUT On Session    ServeRest    /produtos/${id_inexistente}    headers=${headers}    data=${payload}    expected_status=ANY
    Log To Console    PUT com ID inexistente: ${response.content}
    Set Global Variable    ${response}

Criar Produto A
    ${nome_produto_a}=     FakerLibrary.Word
    Set Suite Variable     ${nome_produto_a}
    ${preco}=              Set Variable    100
    ${descricao}=          Set Variable    Produto A
    ${quantidade}=         Set Variable    5
    &{headers}=            Create Dictionary    Authorization=${auth_token}
    &{payload}=            Create Dictionary
    ...                   nome=${nome_produto_a}
    ...                   preco=${preco}
    ...                   descricao=${descricao}
    ...                   quantidade=${quantidade}
    ${response}=           POST On Session    ServeRest    /produtos    headers=${headers}    data=${payload}
    ${id_produto_a}=       Set Variable    ${response.json()["_id"]}
    Set Suite Variable     ${id_produto_a}

Criar Produto B
    ${nome_produto_b}=     FakerLibrary.Word
    Set Suite Variable     ${nome_produto_b}
    ${preco}=              Set Variable    150
    ${descricao}=          Set Variable    Produto B
    ${quantidade}=         Set Variable    8
    &{headers}=            Create Dictionary    Authorization=${auth_token}
    &{payload}=            Create Dictionary
    ...                   nome=${nome_produto_b}
    ...                   preco=${preco}
    ...                   descricao=${descricao}
    ...                   quantidade=${quantidade}
    ${response}=           POST On Session    ServeRest    /produtos    headers=${headers}    data=${payload}
    ${id_produto_b}=       Set Variable    ${response.json()["_id"]}
    Set Suite Variable     ${id_produto_b}

Tentar Renomear Produto B Com Nome de Produto A
    ${preco}=              Set Variable    200
    ${descricao}=          Set Variable    Atualizando para nome existente
    ${quantidade}=         Set Variable    10
    &{headers}=            Create Dictionary    Authorization=${auth_token}
    &{payload}=            Create Dictionary
    ...                   nome=${nome_produto_a}         # usando nome do produto A
    ...                   preco=${preco}
    ...                   descricao=${descricao}
    ...                   quantidade=${quantidade}
    ${response}=           PUT On Session    ServeRest    /produtos/${id_produto_b}    headers=${headers}    data=${payload}    expected_status=ANY
    Log To Console         Conflito de nome: ${response.content}
    Set Global Variable    ${response}

Criar Produto Para Carrinho
    ${palavra}=         FakerLibrary.Word
    ${sufixo}=          Generate Random String    5    [NUMBERS]
    ${nome_produto}=    Set Variable    ${palavra}-${sufixo}
    ${preco}=           Set Variable    777
    ${descricao}=       Set Variable    Produto do Carrinho
    ${quantidade}=      Set Variable    5
    &{headers}=         Create Dictionary    Authorization=${auth_token}
    &{payload}=         Create Dictionary
    ...                 nome=${nome_produto}
    ...                 preco=${preco}
    ...                 descricao=${descricao}
    ...                 quantidade=${quantidade}
    ${response}=        POST On Session    ServeRest    /produtos    headers=${headers}    data=${payload}
    ${id_produto}=      Set Variable    ${response.json()["_id"]}
    Set Suite Variable  ${id_produto}

DELETE Produto Vinculado Ao Carrinho
    &{headers}=              Create Dictionary    Authorization=${auth_token}
    ${response}=             DELETE On Session    ServeRest    /produtos/${id_produto}    headers=${headers}    expected_status=ANY
    Log To Console           Tentativa de exclusão: ${response.content}
    Set Global Variable      ${response}