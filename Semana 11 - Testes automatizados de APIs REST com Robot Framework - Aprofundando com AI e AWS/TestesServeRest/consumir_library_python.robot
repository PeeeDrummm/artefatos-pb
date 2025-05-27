*** Settings ***
Documentation    Arquivo de Testes para Library Python
Library          library_teste.py

*** Test Cases ***
Teste Library 1
    ${json}           Get Endpoint Usuario Tantas Vezes    ${5}
    Log To Console    ${json}

Teste Library 2
    ${users}           Pegar Quantidade De Usuarios Cadastrados
    Log To Console    ${users}