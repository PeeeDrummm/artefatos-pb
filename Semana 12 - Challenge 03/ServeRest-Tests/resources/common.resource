*** Settings ***
Documentation    Recursos e utilidades comuns
Library          RequestsLibrary
Library          Collections

*** Keywords ***
Criar Sessão
    Create Session    ServeRest    http://localhost:3000
    Log    Sessão criada com sucesso.

Validar Status Code
    [Arguments]    ${status_esperado}
    Should Be Equal As Integers    ${response.status_code}    ${status_esperado}