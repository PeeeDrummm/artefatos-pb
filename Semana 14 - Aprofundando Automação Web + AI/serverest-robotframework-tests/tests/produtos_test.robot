*** Settings ***
Documentation    Testes de Cadastro de Produto e Listagem 
Resource         ../resources/common/common.resource

Test Setup       Criar Sessao
Test Teardown    Take Screenshot
Suite Setup      Silenciar InsecureRequestWarning

*** Test Cases ***
Cenário: Cadastrar um produto valido
    [Tags]    CADPROD
    ${user}=    Criar usuario como administrador    #Thais
    Ir para a página de inscrição                   #Thais
    Excluir usuário - API    ${user['email']}       #Maria
    Enviar formulário de inscrição    ${user}       #Thais
    Cadastrar um produto valido                     #Pedro
    Excluir produto - API    ${nome_produto}        #Maria

Cenário: Listagem de produtos validos
    [Tags]    LISTUSU
    ${user}=    Criar usuario como administrador    #Thais
    Ir para a página de inscrição                   #Thais
    Excluir usuário - API    ${user['email']}       #Maria
    Enviar formulário de inscrição    ${user}       #Thais
    Cadastrar um produto valido                     #Pedro
    Listagem de produtos validos                    #Pedro
    Excluir produto - API    ${nome_produto}        #Maria