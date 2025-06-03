*** Settings ***
Documentation    Arquivo de Testes para o Endpoint /usuarios
Resource         ../resources/usuarios_keywords.resource
Suite Setup      Criar Sessão

*** Test Cases ***
Cenário: POST Criar Usuário com Dados Válidos - 201
    [Tags]    POSTUSUARIO    CT001
    Carregar Dados de Usuário Válido
    POST Endpoint /usuarios
    Validar Status Code    201
    Validar Mensagem de Sucesso    Cadastro realizado com sucesso

Cenário: POST Criar Usuário com E-mail Já Existente - 400
    [Tags]    POSTUSUARIO    CT002
    Carregar Dados de Usuário Válido
    POST Endpoint /usuarios
    Validar Status Code    201
    POST Endpoint /usuarios    # Mesmo payload
    Validar Status Code    400
    Validar Mensagem de Erro    Este email já está sendo usado

Cenário: POST Criar Usuário com E-mails Inválidos - 400
    [Tags]    POSTUSUARIO    CT003
    Carregar Nome Fixo Para Teste
    FOR    ${email}    IN    @{emails_invalidos}
        Criar Usuário Com Email Inválido    ${email}
    END
############### BUG JÁ CONHECIDO ###############
Cenário: POST Criar Usuário com Domínio Proibido - 400
    [Tags]    POSTUSUARIO    CT004
    Carregar Nome Fixo Para Teste
    FOR    ${dominio}    IN    gmail.com    hotmail.com
        Criar Usuário Com Email Inválido    ${dominio}
    END
############### BUG JÁ CONHECIDO ###############
Cenário: POST Criar Usuário com Senha de 4 Caracteres - 400
    [Tags]    POSTUSUARIO    CT005
    Criar Usuário Com Senha Inválida    "quatro"
############### BUG JÁ CONHECIDO ###############
Cenário: POST Criar Usuário com Senha de 11 Caracteres - 400
    [Tags]    POSTUSUARIO    CT006
    Criar Usuário Com Senha Inválida    "onze"

Cenário: PUT Editar Usuário Existente com Dados Válidos - 200
    [Tags]    PUTUSUARIO    CT007
    Carregar Dados de Usuário Válido
    POST Endpoint /usuarios
    Validar Status Code    201
    Salvar ID do Usuário Criado

    Gerar Novos Dados de Edição
    PUT Endpoint /usuarios/${usuario_id}
    Validar Status Code    200
    Validar Mensagem de Sucesso    Registro alterado com sucesso

Cenário: PUT Editar Usuário Usando E-mail Já Existente - 400
    [Tags]    PUTUSUARIO    CT008
    Carregar Dados de Usuário Válido
    POST Endpoint /usuarios
    Validar Status Code    201
    ${email_existente}=    Set Variable    ${usuario_email}

    Carregar Dados de Usuário Válido
    POST Endpoint /usuarios
    Validar Status Code    201
    Salvar ID do Usuário Criado

    Editar Usuário Com Email Existente    ${email_existente}
    Validar Status Code    400
    Validar Mensagem de Erro    Este email já está sendo usado