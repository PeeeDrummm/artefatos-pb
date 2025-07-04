*** Settings ***
Documentation    Testes para o Endpoint de Autenticação  

Resource       ../resources/base.resource

Suite Setup    Criar Sessão API

*** Test Cases ***
Criar um novo usuário com dados válidos e únicos
    [Tags]    API    CT001
    Remover Usuário do Banco de Dados     pedro.teste@qa.com
    Registrar um Novo Usuário             Pedro Afonso    pedro.teste@qa.com    senha123    valido
    Validar Código de Status              201    

Realizar Login com Credenciais Válidas
    [Tags]    API    CT005
    Remover Usuário do Banco de Dados     pedro.teste@qa.com
    Inserir Usuário no Banco de Dados     Pedro Afonso    pedro.teste@qa.com    senha123
    Realizar Login
    Validar Código de Status              200

Acessar Rota Protegida Após Logout
    [Tags]    API    CT009
    Remover Usuário do Banco de Dados     pedro.teste@qa.com
    Inserir Usuário no Banco de Dados     Pedro Afonso    pedro.teste@qa.com    senha123
    Realizar Login

    Validar Código de Status              200
    Salvar Token de Autenticação
    Simular Logout (Descarta o Token)
    Validar Código de Status              401