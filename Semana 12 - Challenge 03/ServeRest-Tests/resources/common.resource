*** Settings ***
Documentation    Recursos e utilidades comuns
Library          RequestsLibrary
Library          Collections
Library          String
Resource         ../variables/env_variables.robot

*** Keywords ***
Criar Sessão
    Create Session    ServeRest    ${base_url}
    Log    Sessão criada com sucesso: ${base_url}

Validar Status Code
    [Arguments]    ${status_esperado}
    Should Be Equal As Integers    ${response.status_code}    ${status_esperado}

Gerar ID Inexistente
    ${id_inexistente}=    Generate Random String    16    [LETTERS]
    Set Suite Variable    ${id_inexistente}

Desativar Avisos SSL
        Evaluate    __import__('urllib3').disable_warnings()

Setup Geral da Suite
    Desativar Avisos SSL
    Criar Sessão