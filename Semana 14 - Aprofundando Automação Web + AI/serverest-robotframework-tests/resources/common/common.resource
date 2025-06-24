*** Settings ***
Documentation    Keywords e Imports Comuns para Todos os Testes

Library          Browser
Library          RequestsLibrary
Library          Collections
Library          String
Library          JSONLibrary

Resource         ../usuarios_keywords.resource
Resource         ../listar_usuarios_keyword.resource
Resource         ../alterar_usuario_keyword.resource
Resource         ../login_keywords.resource
Resource         ../produtos_keywords.resource
Resource         ../atualizar_produto.resource
Resource         ../excuir_produto.resource

*** Variables ***
${BASE_URL}       https://compassuolfront.serverest.dev
${API_URL}        https://compassuol.serverest.dev
${STATUS_REQ}     any
${BROWSER}        chromium

${NOME_ATUAL}     TesteBre
${EMAIL_ADMIN}    qabre@admin.com
${SENHA_ADMIN}    admin123
${NOVO_NOME}      Nome Editado
${NOVO_EMAIL}     novo@email.com
${NOVA_SENHA}     123456

*** Keywords ***
Abrir página
    New Browser    browser=${BROWSER}    headless=False
    New Page    ${BASE_URL}

Logar
    ${data}    Load Json From File
    ...    ${EXECDIR}/resources/fixtures/api.json
    ...    encoding=utf-8

    Enviar formulário de login    ${data}[usuario]
    O usuário deve estar logado   ${data}[usuario][nome]

Criar Sessao
    New Browser    browser=${BROWSER}    headless=False
    New Page       ${BASE_URL}
    Create Session    alias=restful-serverest    url=${API_URL}

Excluir usuário - API
   
    [Arguments]    ${email_usuario}
 
    ${response}=    GET On Session    restful-serverest    /usuarios    expected_status=${STATUS_REQ}
    ${usuarios}=    Get From Dictionary    ${response.json()}    usuarios
 
    ${id}=    Set Variable    None
    FOR    ${usuario}    IN    @{usuarios}
        IF    $usuario["email"] == $email_usuario
            ${id}=    Set Variable    ${usuario["_id"]}
        END
    END
 
    # RequestsLibrary.DELETE On Session    restful-serverest    /usuarios/${id}    expected_status=${STATUS_REQ}
    # Set Suite Variable    ${user_id}    ${id}  #armazenar o id

    DELETE On Session
    ...          alias=restful-serverest
    ...          url=/usuarios/${id}
    ...          expected_status=${STATUS_REQ}

    Set Suite Variable    ${user_id}    ${id}

Criar usuário - API
    Criar Sessao

    ${data}    Load Json From File
    ...    ${EXECDIR}/resources/fixtures/api.json
    ...    encoding=utf-8

    ${body}    Set Variable    ${data}[usuario]

    ${resposta}  POST On Session
        ...          alias=restful-serverest
        ...          url=/usuarios
        ...          json=${body}
        ...          expected_status=${STATUS_REQ}

    Set Test Variable    ${RESPOSTA}    ${resposta.json()}
    Log    ${RESPOSTA}
    Log to Console    ${RESPOSTA}

Login usuário - API
    Criar Sessao

    Criar usuário - API

    ${data}    Load Json From File
    ...    ${EXECDIR}/resources/fixtures/api.json
    ...    encoding=utf-8

    ${body}    Set Variable    ${data}[usuario-login]

    ${resposta}  POST On Session
        ...          alias=restful-serverest
        ...          url=/login
        ...          json=${body}
        ...          expected_status=${STATUS_REQ}

    Set Test Variable    ${RESPOSTA}    ${resposta.json()}

    ${token}=   Get From Dictionary    ${RESPOSTA}    authorization
    ${token_parte}    Split String    ${token}    ${SPACE}
    Set Test Variable    ${TOKEN}    ${token_parte}[1]

    Log    ${TOKEN}
    Log To Console    ${TOKEN}


Gerar token usuario - API
    [Arguments]    ${user}

    ${body}=    Create Dictionary
    ...         email=${user}[email]
    ...         password=${user}[password]

    ${headers}=    Create Dictionary    Content-Type=application/json

    ${response}=    POST On Session
    ...             restful-serverest
    ...             url=/login
    ...             json=${body}
    ...             headers=${headers}
    ...             expected_status=${STATUS_REQ}

     ${json}=    Set Variable    ${response.json()}
    ${token}=   Get From Dictionary    ${json}    authorization

    Set Suite Variable    ${token_login}    ${token}
    RETURN    ${token}


Excluir produto - API
    [Arguments]    ${nome-produto}

    Criar Sessao

    ${resposta}    GET On Session
        ...          alias=restful-serverest
        ...          url=/produtos
        ...          expected_status=${STATUS_REQ}

    Set Test Variable    ${RESPOSTA}    ${resposta.json()}

    ${produtos}=      Get From Dictionary    ${RESPOSTA}    produtos

    FOR    ${produto}    IN    @{produtos}
        ${nome}    Get From Dictionary    ${produto}    nome
        IF    '''${nome}''' == '''${nome-produto}'''
            ${id}    Set Variable    ${produto["_id"]}
        END
    END

    Login usuário - API

    ${headers}=    Create Dictionary    Authorization=Bearer ${TOKEN}

    DELETE On Session
    ...          alias=restful-serverest
    ...          url=/produtos/${id}
    ...          headers=${headers}
    ...          expected_status=${STATUS_REQ}

Criar produto - API

    Criar Sessao

    Login usuário - API

    ${headers}=    Create Dictionary    Authorization=Bearer ${TOKEN}

    ${data}    Load Json From File
    ...    ${EXECDIR}/resources/fixtures/api.json
    ...    encoding=utf-8

    ${body}    Set Variable    ${data}[produto]

    ${resposta}  POST On Session
        ...          alias=restful-serverest
        ...          url=/produtos
        ...          json=${body}
        ...          expected_status=${STATUS_REQ}
        ...          headers=${headers}

    Set Test Variable    ${data}

    Set Test Variable    ${RESPOSTA}    ${resposta.json()}
    Log    ${RESPOSTA}
    Log to Console    ${RESPOSTA}

Silenciar InsecureRequestWarning
    Evaluate    __import__('urllib3').disable_warnings(__import__('urllib3').exceptions.InsecureRequestWarning)