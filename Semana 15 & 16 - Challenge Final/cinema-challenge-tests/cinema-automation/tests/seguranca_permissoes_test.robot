*** Settings ***
Documentation    Testes para o Endpoint de Segurança e Permissões  

Resource       ../resources/base.resource

Suite Setup    Criar Sessão API

*** Test Cases ***
Acessar Rota Admin com Usuário
    [Tags]    API    CT032
    Remover Usuário do Banco de Dados     pedro.teste@qa.com
    Inserir Usuário no Banco de Dados     Pedro Afonso    pedro.teste@qa.com    senha123
    Realizar Login
    Salvar Token de Autenticação
    
    Obter Primeiro Teatro Disponível
    Criar Nova Sessão de Filme            68605db5d993bb1557cc8fd7

    Validar Código de Status              403
    Validar Mensagem Response             User role user is not authorized to access this route