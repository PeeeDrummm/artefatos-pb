*** Settings ***
Documentation    Cenários de testes do cadastro de usuários
Resource         ../resources/base_keywords.resource
# Suite Setup      Log    Executado uma uníca vez antes de toda suite
# Suite Teardown   Log    Executado uma única vez depois de toda suite
Test Setup       Start Session      #Executado antes de cada teste
Test Teardown    Take Screenshot    #Executado depois de cada teste

*** Test Cases ***
Deve poder cadastrar um novo usuário
    
    ${user}        Create Dictionary    
    ...            name=Pedro Afonso    
    ...            email=pedro.afonso@qa.com.br    
    ...            password=testando123

    Remove user from database    ${user}[email]

    Go To          http://localhost:3000/signup

    # Checkpoint                #//h1[text()="Faça seu cadastro"]
    # Wait For Elements State    xpath=//h1    visible    5
    # Get Text                   xpath=//h1    equal      Faça seu cadastro

    Wait For Elements State    css=h1           visible    5
    Get Text                   css=h1           equal      Faça seu cadastro

    # Fill Text                css=#name
    # Fill Text                xpath=//input[@id="name"]
    Fill Text                  id=name        ${user}[name]
    Fill Text                  id=email       ${user}[email]
    Fill Text                  id=password    ${user}[password]

    # Click                    button[type=submit] ou //button[text()="Cadastrar"]
    Click                      id=buttonSignup

    Wait For Elements State    css=.notice p    visible    5
    Get Text                   css=.notice p    equal      Boas vindas ao Mark85, o seu gerenciador de tarefas.

Não deve permitir o cadastro com email duplicado
    [Tags]    dup

    ${user}        Create Dictionary    
    ...            name=Afonso Pedro    
    ...            email=afonso.pedro@aq.com.br    
    ...            password=testando123

    Remove user from database    ${user}[email]
    Insert user from database    ${user}

    Go To          http://localhost:3000/signup
    # Checkpoint  
    Wait For Elements State    css=h1           visible    5
    Get Text                   css=h1           equal      Faça seu cadastro

    Fill Text                  id=name        ${user}[name]
    Fill Text                  id=email       ${user}[email]
    Fill Text                  id=password    ${user}[password]

    Click                      id=buttonSignup

    Wait For Elements State    css=.notice p    visible    5
    Get Text                   css=.notice p    equal      Oops! Já existe uma conta com o e-mail informado.