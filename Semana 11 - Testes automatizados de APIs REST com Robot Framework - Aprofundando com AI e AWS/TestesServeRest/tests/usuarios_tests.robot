*** Settings ***
Documentation    Arquivo de Testes para o Endpoint /usuarios
Resource         ../keywords/usuarios_keywords.robot
Suite Setup      Criar Sessão

*** Test Cases ***
Cenário: GET Todos os Usuários 200
    [Tags]    GET
    GET Endpoint /usuarios
    Validar Status Code "200"

Cenário: POST Cadastrar Usuário 201
    [Tags]    POST
    Criar Dados Usuário Válido
    POST Endpoint /usuarios
    Validar Status Code "201"
    Validar Se Mensagem Contém "sucesso"

Cenário: PUT Editar Usuário 200
    [Tags]    PUT
    Criar Dados Usuário Válido
    POST Endpoint /usuarios
    PUT Endpoint /usuarios
    Validar Status Code "200"

Cenário: DELETE Editar Usuário 200
    [Tags]    DELETE
    Criar Dados Usuário Válido
    POST Endpoint /usuarios
    DELETE Endpoint /usuarios
    Validar Status Code "200"

Cenário: POST Criar Usuário de Massa Estática 201
    [Tags]    POSTCRIARUSUARIOESTATICO
    Pegar Dados do Usuário Estático Válido
    POST Endpoint /usuarios
    Validar Status Code "201"