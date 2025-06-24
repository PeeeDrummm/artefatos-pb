*** Settings ***
Documentation    Testes de Cadastro de Usuário 
Resource         ../resources/common/common.resource

Test Setup       Criar Sessao
Test Teardown    Take Screenshot
Suite Setup      Silenciar InsecureRequestWarning

*** Test Cases ***
Cenario: Criar um novo usuário com administrador valido
    
    ${user}=    Criar usuario como administrador

    Ir para a página de inscrição

    Excluir usuário - API    ${user['email']}

    Enviar formulário de inscrição    ${user}