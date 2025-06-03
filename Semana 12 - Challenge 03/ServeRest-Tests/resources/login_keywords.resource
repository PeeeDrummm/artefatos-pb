*** Settings ***
Documentation    Keywords e Variáveis para Ações do Endpoint /login
Library          FakerLibrary
Resource         ../resources/common.resource

*** Variables ***
${email_para_login}        fulano@qa.com
${password_para_login}     teste
${auth_token}              None

*** Keywords ***
POST Endpoint /login
    &{payload}=    Create Dictionary
    ...            email=${email_para_login}
    ...            password=${password_para_login}
    ${response}=   POST On Session    ServeRest    /login    json=${payload}    expected_status=ANY
    Log To Console    Response: ${response.content}
    Set Global Variable    ${response}

Validar Ter Logado
    Should Be Equal       ${response.json()["message"]}      Login realizado com sucesso
    Should Not Be Empty   ${response.json()["authorization"]}

Armazenar Token de Autenticação
    ${token}=    Set Variable    ${response.json()["authorization"]}
    Set Suite Variable    ${auth_token}    ${token}
    Log    Token armazenado: ${auth_token}

POST Endpoint /login com Senha Incorreta
    &{payload}=    Create Dictionary
    ...            email=${email_para_login}
    ...            password=senhaErrada123
    ${response}=   POST On Session    ServeRest    /login    json=${payload}    expected_status=ANY
    Log To Console    Response: ${response.content}
    Set Global Variable    ${response}

Validar Mensagem de Erro Login
    [Arguments]    ${mensagem_esperada}
    Should Be Equal    ${response.json()["message"]}    ${mensagem_esperada}

POST Endpoint /login com Usuario Inexistente
    ${email_invalido}=    FakerLibrary.Email
    &{payload}=    Create Dictionary
    ...            email=${email_invalido}
    ...            password=senhaQualquer123
    ${response}=   POST On Session    ServeRest    /login    json=${payload}    expected_status=ANY
    Log To Console    Email usado: ${email_invalido}
    Log To Console    Response: ${response.content}
    Set Global Variable    ${response}

Realizar Login Com Usuário Dinâmico
    &{payload}=  Create Dictionary
    ...         email=${email}
    ...         password=${senha}
    ${response}=  POST On Session    ServeRest    /login    data=${payload}
    Set Global Variable    ${auth_token}    ${response.json()["authorization"]}