*** Settings ***
Resource    ../resources/healthcheck.resource
Resource    ../resources/variables.resource

*** Test Cases ***
Ping - Health Check
    # Verifica se a API está funcionando/online, caso contrário, os testes não serão realizados
    Health Check