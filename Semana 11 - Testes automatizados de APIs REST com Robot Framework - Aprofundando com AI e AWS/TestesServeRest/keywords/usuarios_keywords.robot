*** Settings ***
Documentation    Keywords e Variáveis para Ações do Endpoint /usuario
Resource         ../support/base.robot

*** Keywords ***
GET Endpoint /usuarios
    ${response}            GET On Session    ServeRest    /usuarios
    Set Global Variable    ${response}

POST Endpoint /usuarios
    ${response}            POST On Session    ServeRest    /usuarios    json=&{payload}
    ${json}                Set Variable       ${response.json()}
    Log To Console         Response: ${response.content}
    Set Global Variable    ${response}

PUT Endpoint /usuarios
    ${response}            PUT On Session    ServeRest    /usuarios/${response.json()["_id"]}    json=&{payload}
    Log To Console         Response: ${response.content}
    Set Global Variable    ${response}

DELETE Endpoint /usuarios
    ${response}            DELETE On Session    ServeRest    /usuarios/${response.json()["_id"]}
    Log To Console         Response: ${response.content}
    Set Global Variable    ${response}

Validar Quantidade "${quantidade}"
    Should Be Equal    ${response.json()["quantidade"]}    ${quantidade}

Pegar Dados do Usuário Estático Válido
    ${json}                    Import JSON Estático    json_usuario_ex.json
    ${payload}                 Set Variable            ${json["user_valido"]}
    Set Global Variable        ${payload}