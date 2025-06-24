*** Settings ***
Documentation    Keywords da Página de Login
Resource         ./common/common.resource      

*** Keywords ***
Criar login valido 
   ${user}    Create Dictionary
    ...    name=teste
    ...    email=teste@teste.com
    ...    password=senha123 
    RETURN    ${user}

Enviar formulário de login
   [Arguments]    ${user}

   Fill Text    css=input[placeholder$="Digite seu email"]     ${user}[email]
   Fill Text    css=input[placeholder="Digite sua senha"]    ${user}[password]

   Click        css=button >> text=Entrar

O usuário deve estar logado
   [Arguments]    ${name} 

   @{nome_inicial}    Split String    ${name}
   ${element}    Set Variable    css=h1  
   
   Sleep    5

   Wait For Elements State    ${element}   
   ...    visible     5

   Get Text    ${element}    equal    Bem Vindo ${nome_inicial}[0]