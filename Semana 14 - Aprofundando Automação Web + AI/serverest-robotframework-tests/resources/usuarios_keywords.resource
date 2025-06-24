*** Settings ***
Documentation    Keywords das Páginas de Cadastro
Resource         ./common/common.resource  

*** Keywords ***
Criar usuario como administrador 
    ${user}        Create Dictionary
    ...    name=teste
    ...    email=teste@teste.com
    ...    password=senha123
    ...    administrador=true
    RETURN    ${user}

Ir para a página de inscrição
    Go To    ${BASE_URL}/cadastrarusuarios

    #checkpoint
    Wait For Elements State    css=.font-robot    visible    5      
    Get Text                   css=.font-robot    equal      Cadastro

Enviar formulário de inscrição 
   [Arguments]    ${user}

    Fill Text    css=input[name=nome]     ${user}[name]    
    Fill Text    css=input[name=email]      ${user}[email]
    Fill Text    css=input[name=password]   ${user}[password]

    Click    css=input[name=administrador] 
    Click    css=button[type=submit] >> text=Cadastrar 

    Sleep    5