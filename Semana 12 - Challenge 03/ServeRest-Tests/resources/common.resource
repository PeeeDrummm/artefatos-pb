*** Settings ***
Documentation    Recursos e utilidades comuns
Library          RequestsLibrary
Library          Collections

*** Keywords ***
Criar Sessão
    Create Session    ServeRest    https://serverest.dev/
    Log    Sessão criada com sucesso.

Validar Status Code
    [Arguments]    ${status_esperado}
    Should Be Equal As Integers    ${response.status_code}    ${status_esperado}

Gerar ID Inexistente
    ${id_inexistente}=    Generate Random String    16    [LETTERS]
    Set Suite Variable    ${id_inexistente}