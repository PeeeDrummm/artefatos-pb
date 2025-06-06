*** Settings ***
Documentation    Recursos e utilidades comuns
Resource         ../variables/env_variables.robot
Library          RequestsLibrary
Library          Collections
Library          String

*** Keywords ***
Criar Sessão
    Create Session    ServeRest    ${base_url}
    Log               Sessão criada com sucesso: ${base_url}

Validar Status Code
    [Arguments]                    ${status_esperado}
    Should Be Equal As Integers    ${response.status_code}    ${status_esperado}

Gerar ID Inexistente
    ${id_inexistente}=    Generate Random String    16    [LETTERS]
    Set Suite Variable    ${id_inexistente}

Desativar Avisos SSL
        Evaluate    __import__('urllib3').disable_warnings()

Setup Geral da Suite
    Desativar Avisos SSL
    Criar Sessão

Sanitizar Senha
    [Arguments]                 ${senha_original}
    ${s}=     Set Variable      ${senha_original}
    ${s}=     Replace String    ${s}    \${    _
    ${s}=     Replace String    ${s}    }      _
    ${s}=     Replace String    ${s}    &      _
    ${s}=     Replace String    ${s}    =      _
    ${s}=     Replace String    ${s}    *      _
    ${s}=     Replace String    ${s}    "      _
    ${s}=     Replace String    ${s}    '      _
    RETURN    ${s}