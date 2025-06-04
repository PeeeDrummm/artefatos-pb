*** Settings ***
Documentation    Keywords e Variáveis para Ações do Endpoint /login
Library          FakerLibrary
Resource         ../resources/common.resource
Resource         ../variables/env_variables.robot

*** Keywords ***
POST Endpoint /login
    [Arguments]    ${email}=${EMAIL_ADMIN}    ${senha}=${SENHA_ADMIN}
    &{payload}=    Create Dictionary
    ...            email=${email}
    ...            password=${senha}
    ${response}=   POST On Session    ServeRest    /login    json=${payload}    expected_status=ANY
    Log To Console    Response: ${response.content}
    Set Global Variable    ${response}
    ${token}=    Set Variable    ${response.json()["authorization"]}
    Armazenar Token    ${token}

Validar Ter Logado
    Should Be Equal       ${response.json()["message"]}      Login realizado com sucesso
    Should Not Be Empty   ${response.json()["authorization"]}

POST Endpoint /login com Senha Incorreta
    &{payload}=    Create Dictionary
    ...            email=${EMAIL_ADMIN}
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
    [Arguments]    ${email}    ${senha}
    &{payload}=  Create Dictionary
    ...         email=${email}
    ...         password=${senha}
    ${response}=  POST On Session    ServeRest    /login    data=${payload}
    Set Global Variable    ${response}
    ${token}=    Set Variable    ${response.json()["authorization"]}
    Armazenar Token    ${token}
