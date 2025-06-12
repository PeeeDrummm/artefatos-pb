*** Settings ***
Documentation    Cenário de autenticação do usuário
Resource         ../resources/base_keywords.resource
Library          Collections
Test Setup       Start Session
Test Teardown    Take Screenshot

*** Test Cases ***
Deve poder logar um usuário pré-cadastrado
    ${user}    Create Dictionary    
    ...    name=Pedro Login
    ...    email=pedro.login@gmail.com
    ...    password=testando123

    Remove user from database    ${user}[email]
    Insert user from database    ${user}

    Submit login form               ${user}
    User should be logged in        ${user}[name]

Não deve logar com senha inválida
    ${user}    Create Dictionary    
    ...    name=Caneca de Porcelana
    ...    email=amocanecas@porcelana.com
    ...    password=123456789

    Remove user from database    ${user}[email]
    Insert user from database    ${user}

    Set To Dictionary    ${user}    password=abc123

    Submit login form    ${user}
    Notice should be     Ocorreu um erro ao fazer login, verifique suas credenciais.