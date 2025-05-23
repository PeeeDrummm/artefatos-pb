*** Settings ***
Library    RequestsLibrary
Resource   variables.resource

*** Keywords ***
# Caso não seja possível o ping na API, os testes não vão prosseguir
Health Check
    Create Session    Booker    ${base_url}
    ${response}    GET On Session    Booker    /ping    expected_status=201