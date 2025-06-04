*** Settings ***
Documentation    Recursos e utilidades comuns
Library          RequestsLibrary
Library          Collections
Library          OperatingSystem
Resource         ../variables/env_variables.robot

*** Keywords ***
Criar Sessão
    ${url}=    Get Environment Variable    BASE_URL    ${BASE_URL}
    Create Session    ServeRest    ${url}
    Log    Sessao criada com sucesso para ${url}.

Validar Status Code
    [Arguments]    ${status_esperado}
    Should Be Equal As Integers    ${response.status_code}    ${status_esperado}

Gerar ID Inexistente
    ${id_inexistente}=    Generate Random String    16    [LETTERS]
    Set Suite Variable    ${id_inexistente}

Armazenar Token
    [Arguments]    ${token}
    Set Suite Variable    ${auth_token}    ${token}
    Log    Token armazenado: ${auth_token}

Aguardar Delay Global
    Sleep    ${global_delay}
