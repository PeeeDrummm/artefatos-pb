*** Settings ***
Library    RequestsLibrary
Library    String
Library    Collections

*** Keywords ***
Criar Sessão na ServeRest
    ${headers}    Create Dictionary    accept=application/json    Content-Type=application/json
    Create Session    alias=ServeRest    url=https://serverest.dev    headers=${headers}

Criar um usuário novo
    ${palavra_aleatoria}    Generate Random String    length=8    chars=[LOWER]
    Set Test Variable    ${email_teste}    ${palavra_aleatoria}@qa.com.br
    Log    ${email_teste}

Cadastrar o usuário na ServeRest
    [Arguments]    ${email}    ${status_code_desejado}
    Criar Sessão na ServeRest

    ${body}    Create Dictionary
    ...        nome=Pedro QA
    ...        email=${email}
    ...        password=0123456789
    ...        administrador=true
    Log        ${body}

    ${resposta}    POST On Session
    ...            alias=ServeRest
    ...            url=/usuarios
    ...            json=${body}
    ...            expected_status=${status_code_desejado}
    Log            ${resposta.json()}
    IF    ${status_code_desejado} == 201
    Set Test Variable    ${id_usuario}    ${resposta.json()}[_id]
    END
    Set Test Variable    ${resposta}      ${resposta.json()}

Conferir se o usuário foi cadastrado corretamente
    Dictionary Should Contain Item    ${resposta}    message    Cadastro realizado com sucesso
    Dictionary Should Contain Key     ${resposta}    _id

Vou repetir o cadastro do usuário
    Cadastrar o usuário na ServeRest    email=${email_teste}    status_code_desejado=400

Verificar se a API permitiu o cadastro repetido
    Dictionary Should Contain Item    ${resposta}    message    Este email já está sendo usado
    
Consultar os dados do novo usuário
    ${resposta_consulta}    GET On Session    alias=ServeRest    url=/usuarios/${id_usuario}    expected_status=200
    Log    ${resposta_consulta.status_code}
    Log    ${resposta_consulta.reason}
    Log    ${resposta_consulta.headers}
    Log    ${resposta_consulta.elapsed}
    Log    ${resposta_consulta.text}
    Log    ${resposta_consulta.json()}

    Set Test Variable    ${resp_consulta}    ${resposta_consulta.json()}

Conferir os dados retornados
    Log    ${resp_consulta}
    Dictionary Should Contain Item    ${resp_consulta}    nome              Pedro QA
    Dictionary Should Contain Item    ${resp_consulta}    email             ${email_teste}
    Dictionary Should Contain Item    ${resp_consulta}    password          0123456789
    Dictionary Should Contain Item    ${resp_consulta}    administrador     true
    Dictionary Should Contain Item    ${resp_consulta}    _id               ${id_usuario}

Realizar Login com o usuário
    ${body_login}        Create Dictionary
    ...                  email=${email_teste}
    ...                  password=0123456789

    ${resposta_login}    POST On Session
    ...                  alias=ServeRest
    ...                  url=/login
    ...                  json=${body_login}
    ...                  expected_status=200

    Log    ${resposta_login.json()}
    Set Test Variable    ${login_resposta}    ${resposta_login.json()}

Conferir se o Login ocorreu com sucesso
    Dictionary Should Contain Item    ${login_resposta}    message         Login realizado com sucesso
    Dictionary Should Contain Key     ${login_resposta}    authorization