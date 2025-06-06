*** Settings ***
Documentation    Keywords e Variáveis para Ações do Endpoint /usuarios
Resource         ../resources/common.resource
Resource         ../data/dynamic/usuario_valido.robot
Resource         ../data/static/emails_invalidos.robot
Resource         ../data/static/emails_proibidos.robot
Resource         ../data/static/senhas_invalidas.robot
Library          FakerLibrary

*** Keywords ***
Carregar Dados de Usuário Válido
    ${nome}=     FakerLibrary.Name
    ${email}=    FakerLibrary.Email
    Set Suite Variable    ${usuario_nome}    ${nome}
    Set Suite Variable    ${usuario_email}   ${email}
    Log    Nome gerado: ${usuario_nome}
    Log    Email gerado: ${usuario_email}

POST Endpoint /usuarios
    &{payload}=    Create Dictionary
    ...            nome=${usuario_nome}
    ...            email=${usuario_email}
    ...            password=${usuario_senha}
    ...            administrador=${usuario_administrador}
    ${response}=   POST On Session    ServeRest    /usuarios    json=${payload}    expected_status=ANY
    Log To Console    Response: ${response.content}
    Set Global Variable    ${response}

Validar Mensagem de Sucesso
    [Arguments]    ${mensagem_esperada}
    Should Be Equal    ${response.json()["message"]}    ${mensagem_esperada}

Validar Mensagem de Erro
    [Arguments]    ${mensagem_esperada}
    Should Be Equal    ${response.json()["message"]}    ${mensagem_esperada}

Carregar Nome Fixo Para Teste
    ${nome}=     FakerLibrary.Name
    Set Suite Variable    ${usuario_nome}    ${nome}
    Set Suite Variable    ${usuario_senha}   123456
    Set Suite Variable    ${usuario_administrador}    true

Criar Usuário Com Email Inválido
    [Arguments]    ${dominio}
    ${prefixo}=    FakerLibrary.User Name
    ${email}=      Set Variable    ${prefixo}@${dominio}
    Set Suite Variable    ${usuario_email}    ${email}
    POST Endpoint /usuarios
    Validar Status Code    400

Criar Usuário Com Senha Inválida
    [Arguments]    ${chave}
    ${nome}=    FakerLibrary.Name
    ${email}=   FakerLibrary.Email
    ${senha}=   Set Variable    ${senhas_invalidas[${chave}]}
    Set Suite Variable    ${usuario_nome}    ${nome}
    Set Suite Variable    ${usuario_email}   ${email}
    Set Suite Variable    ${usuario_senha}   ${senha}
    Set Suite Variable    ${usuario_administrador}   true
    POST Endpoint /usuarios
    Validar Status Code    400

Salvar ID do Usuário Criado
    ${id}=    Set Variable    ${response.json()["_id"]}
    Set Suite Variable    ${usuario_id}    ${id}

Gerar Novos Dados de Edição
    ${novo_nome}=    FakerLibrary.Name
    ${novo_email}=   FakerLibrary.Email
    Set Suite Variable    ${usuario_nome}    ${novo_nome}
    Set Suite Variable    ${usuario_email}   ${novo_email}

PUT Endpoint /usuarios/${id}
    &{payload}=    Create Dictionary
    ...            nome=${usuario_nome}
    ...            email=${usuario_email}
    ...            password=${usuario_senha}
    ...            administrador=${usuario_administrador}
    ${response}=   PUT On Session    ServeRest    /usuarios/${id}    json=${payload}    expected_status=ANY
    Log To Console    Response: ${response.content}
    Set Global Variable    ${response}

Editar Usuário Com Email Existente
    [Arguments]    ${email_usado}
    ${novo_nome}=    FakerLibrary.Name
    Set Suite Variable    ${usuario_nome}    ${novo_nome}
    Set Suite Variable    ${usuario_email}   ${email_usado}
    PUT Endpoint /usuarios/${usuario_id}

Criar Usuário Dinâmico
    ${nome}=      FakerLibrary.Name
    ${email}=     FakerLibrary.Email
    ${senha}=     FakerLibrary.Password
    Set Suite Variable    ${email}
    Set Suite Variable    ${senha}
    &{payload}=  Create Dictionary
    ...         nome=${nome}
    ...         email=${email}
    ...         password=${senha}
    ...         administrador=true
    ${response}=  POST On Session    ServeRest    /usuarios    data=${payload}