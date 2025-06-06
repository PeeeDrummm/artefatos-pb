*** Settings ***
Documentation    Keywords e Variáveis para Ações do Endpoint /carrinhos
Resource         ../resources/common.resource
Library          FakerLibrary
Library          json

*** Keywords ***
Criar Carrinho Com Produto
    [Arguments]            ${id}
    &{headers}=            Create Dictionary    Authorization=${auth_token}
    ${produto}=            Evaluate    {"idProduto": "${id}", "quantidade": 1}    json
    @{produtos}=           Create List    ${produto}
    &{payload}=            Create Dictionary    produtos=${produtos}
    ${response}=           POST On Session    ServeRest    /carrinhos    headers=${headers}    json=${payload}    expected_status=ANY
    Log To Console         Carrinho criado: ${response.content}
    Set Global Variable    ${response}

Criar Carrinho Com Produto Inexistente
    &{headers}=            Create Dictionary    Authorization=${auth_token}
    ${produto}=            Evaluate    {"idProduto": "${id_inexistente}", "quantidade": 1}    json
    @{produtos}=           Create List    ${produto}
    &{payload}=            Create Dictionary    produtos=${produtos}
    ${response}=           POST On Session    ServeRest    /carrinhos    headers=${headers}    json=${payload}    expected_status=ANY
    Log To Console         Carrinho criado com produto inválido: ${response.content}
    Set Global Variable    ${response}

Criar Carrinho Com Produto Duplicado
    Should Not Be Empty    ${id_produto}
    Log To Console         ID do produto duplicado: ${id_produto}

    &{headers}=            Create Dictionary
    ...                    Authorization=${auth_token}
    ...                    Content-Type=application/json
    &{produto1}=           Create Dictionary    idProduto=${id_produto}    quantidade=1
    &{produto2}=           Create Dictionary    idProduto=${id_produto}    quantidade=2
    @{lista_produtos}=     Create List    ${produto1}    ${produto2}
    &{payload}=            Create Dictionary    produtos=${lista_produtos}

    ${json_payload}=       Evaluate    json.dumps(${payload})    json
    ${response}=           POST On Session    ServeRest    /carrinhos    headers=${headers}    data=${json_payload}    expected_status=ANY

    Log To Console         Resposta com produto duplicado: ${response.content}
    Set Global Variable    ${response}

Tentar Criar Segundo Carrinho
    &{headers}=            Create Dictionary
    ...                    Authorization=${auth_token}
    ...                    Content-Type=application/json

    &{produto}=            Create Dictionary    idProduto=${id_produto}    quantidade=1
    @{lista_produtos}=     Create List    ${produto}
    &{payload}=            Create Dictionary    produtos=${lista_produtos}

    ${json_payload}=       Evaluate    json.dumps(${payload})    json
    ${response}=           POST On Session    ServeRest    /carrinhos    headers=${headers}    data=${json_payload}    expected_status=ANY
    Log To Console         Segunda tentativa: ${response.content}
    Set Global Variable    ${response}

Cancelar Carrinho
    &{headers}=            Create Dictionary    Authorization=${auth_token}
    ${response}=           DELETE On Session    ServeRest    /carrinhos/cancelar-compra    headers=${headers}    expected_status=ANY
    Log To Console         Carrinho cancelado: ${response.content}
    Set Global Variable    ${response}

Concluir Compra
    &{headers}=            Create Dictionary    Authorization=${auth_token}
    ${response}=           DELETE On Session    ServeRest    /carrinhos/concluir-compra    headers=${headers}    expected_status=ANY
    Log To Console         Compra concluída: ${response.content}
    Set Global Variable    ${response}