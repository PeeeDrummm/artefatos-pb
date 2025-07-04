*** Settings ***
Documentation    Documentation    Service Object – endpoint **/auth** (login, registro, token helpers).

Resource         ../base.resource

*** Keywords ***
Registrar um Novo Usuário
    [Documentation]    POST /auth/register – cria usuário.
    ...                Args: nome, email, senha, status_esperado (sucesso/erro).
    [Arguments]     ${nome}    ${email}    ${senha}    ${status_esperado}
    ${body}=        Create Dictionary
    ...             name=${nome}
    ...             email=${email}
    ...             password=${senha}

    # Argumento recebido = valido: 200 e 201 / invalido: >= 400
    ${response}=    Run Keyword If                   '${status_esperado}' == 'sucesso'
    ...    POST     ${BASE_API_URL}/auth/register    json=${body}
    ...    ELSE
    ...    POST     ${BASE_API_URL}/auth/register    json=${body}    expected_status=any

    Set Suite Variable    ${ULTIMA_RESPOSTA}    ${response}
    RETURN                ${response}

Realizar Login
    [Documentation]    POST /auth/login usando ${TEST_USER_EMAIL}/${TEST_USER_PASSWORD}.
    ${body}=    Create Dictionary
    ...         email=${TEST_USER_EMAIL}
    ...         password=${TEST_USER_PASSWORD}
    
    ${response}=    POST           ${BASE_API_URL}/auth/login    json=${body}
    Set Suite Variable             ${ULTIMA_RESPOSTA}            ${response}
    RETURN                         ${response}

Realizar Login Admin
    [Documentation]    POST /auth/login fixo (admin@example.com / senha123).
    ${body}=    Create Dictionary
    ...         email=admin@example.com
    ...         password=senha123
    
    ${response}=    POST           ${BASE_API_URL}/auth/login    json=${body}
    Set Suite Variable             ${ULTIMA_RESPOSTA}            ${response}
    RETURN                         ${response}

Salvar Token De Autenticação
    [Documentation]    Extrai "data.token" da última resposta e salva em ${TOKEN}.
    ${json}=              Convert To Dictionary    ${ULTIMA_RESPOSTA.json()}
    Set Suite Variable    ${TOKEN}                 ${json["data"]["token"]}

Simular Logout (Descarta o Token)
    [Documentation]    Acessa rota protegida sem token para validar logout (espera 401/403).
    ${response}=          GET                   ${BASE_API_URL}/reservations/me    expected_status=any
    Set Suite Variable    ${ULTIMA_RESPOSTA}    ${response}

Realizar Login Com Senha Incorreta
    [Documentation]    POST /auth/login com senha inválida; grava ${ULTIMA_RESPOSTA} (espera 4xx).
    ${body}=    Create Dictionary
    ...         email=${TEST_USER_EMAIL}
    ...         password=pwd123456
    
    ${response}=                   POST                          ${BASE_API_URL}/auth/login    json=${body}    expected_status=ANY
    Set Suite Variable             ${ULTIMA_RESPOSTA}            ${response}
    RETURN                         ${response}