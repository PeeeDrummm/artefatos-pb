*** Settings ***
Documentation    Service Object – endpoint **/sessions** (CRUD e utilitários de sessão).

Resource         ../base.resource

*** Keywords ***
Obter Primeira Sessão Disponível
    [Documentation]    GET /sessions; salva o primeiro _id em ${SESSION_ID}.
    ${headers}=                Create Dictionary    Authorization=Bearer ${TOKEN}
    ${response}=               GET                  ${BASE_API_URL}/sessions    headers=${headers}
    Status Should Be           200                  ${response}
    
    ${session_id}=             Set Variable         ${response.json()}[data][0][_id]
    Set Test Variable          ${SESSION_ID}        ${session_id}
    Log                                             Sessão de Teste Selecionada: ${SESSION_ID}

Resetar Assentos Da Sessão
    [Documentation]    PUT /sessions/${SESSION_ID}/reset-seats; deve retornar 200 e mensagem de sucesso.
    ${headers}=         Create Dictionary              Authorization=Bearer ${TOKEN}
    
    ${response}=        PUT                            ${BASE_API_URL}/sessions/${SESSION_ID}/reset-seats    headers=${headers}
    
    Status Should Be    200                            ${response}
    Should Contain      ${response.json()}[message]    All seats reset to available status

Criar Nova Sessão de Filme
    [Documentation]    POST /sessions criando sessão com ${MOVIE_ID} e ${THEATER_ID}; grava ${ULTIMA_RESPOSTA}.
    [Arguments]    ${movie_id}

    ${headers}=    Create Dictionary    Authorization=Bearer ${TOKEN}
    ${body}=       Create Dictionary
    ...            movie=${movie_id}
    ...            theater=${THEATER_ID}
    ...            datetime=2025-06-23T23:00:00.000Z
    ...            fullPrice=80.0
    ...            halfPrice=20.0

    ${response}=          POST                  ${BASE_API_URL}/sessions    headers=${headers}    json=${body}    expected_status=any
    Set Suite Variable    ${ULTIMA_RESPOSTA}    ${response}

Criar Sessão de Filme
    [Documentation]    POST /sessions – cria sessão com ${FILME_ID}/${SALA_ID}; salva ${SESSAO_ID}.
    [Arguments]    ${datetime}    ${fullPrice}    ${halfPrice}    ${filme_id}=${FILME_ID}    ${sala_id}=${SALA_ID}
    ${body}=    Create Dictionary
    ...    movie=${filme_id}
    ...    theater=${sala_id}
    ...    datetime=${datetime}
    ...    fullPrice=${fullPrice}
    ...    halfPrice=${halfPrice}

    ${headers}=                    Create Dictionary          Authorization=Bearer ${TOKEN}    Content-Type=application/json
    ${response}=                   POST                       ${BASE_API_URL}/sessions    json=${body}    headers=${headers}
    Should Be Equal As Integers    ${response.status_code}    201
    ${json}=    Set Variable       ${response.json()}
    Set Suite Variable             ${SESSAO_ID}               ${json["data"]["_id"]}
    Set Suite Variable             ${ULTIMA_RESPOSTA}         ${response}

Atualizar Sessão de Filme
    [Documentation]    PUT /sessions/{id} – atualiza datetime e preços; grava ${ULTIMA_RESPOSTA}.
    [Arguments]    ${datetime}    ${fullPrice}    ${halfPrice}    ${sessao_id}=${SESSAO_ID}
    ${body}=    Create Dictionary
    ...    datetime=${datetime}
    ...    fullPrice=${fullPrice}
    ...    halfPrice=${halfPrice}

    ${headers}=                    Create Dictionary         Authorization=Bearer ${TOKEN}    Content-Type=application/json
    ${response}=                   PUT    ${BASE_API_URL}/sessions/${sessao_id}    json=${body}    headers=${headers}
    Should Be Equal As Integers    ${response.status_code}    200
    ${json}=                       Set Variable               ${response.json()}
    Set Suite Variable             ${SESSAO_ID}               ${json["data"]["_id"]}
    Set Suite Variable             ${ULTIMA_RESPOSTA}         ${response}

Deletar Sessão de Filme
    [Documentation]    DELETE /sessions/{id}; grava ${ULTIMA_RESPOSTA}.
    ${headers}=                    Create Dictionary          Authorization=Bearer ${TOKEN}    Content-Type=application/json
    ${response}=                   DELETE                     ${BASE_API_URL}/sessions/${SESSAO_ID}    headers=${headers}
    Should Be Equal As Integers    ${response.status_code}    200
    Set Suite Variable             ${ULTIMA_RESPOSTA}         ${response}

Listar Todas Sessões de Filmes
    [Documentation]    GET /sessions – lista sessões e, se índice dado, define ${SESSAO_ID}.
    [Arguments]         ${index}=None
    ${headers}=         Create Dictionary    Authorization=Bearer ${TOKEN}
    ${response}=        GET                  ${BASE_API_URL}/sessions    headers=${headers}
    Status Should Be    200                  ${response}

    Evaluate        setattr($response, 'encoding', 'utf-8')
    ${json}=        Set Variable    ${response.json()}

    Log To Console    \n🎬 Sessões disponíveis:
    FOR    ${sessao}    IN    @{json["data"]}
        ${filme}=    Set Variable If    'title' in ${sessao["movie"]}     ${sessao["movie"]["title"]}     N/A
        ${sala}=     Set Variable If    'name' in ${sessao["theater"]}    ${sessao["theater"]["name"]}    N/A
        ${horario}=  Set Variable If    'datetime' in ${sessao}           ${sessao["datetime"]}           N/A
        Log To Console    - Filme: ${filme} | Sala: ${sala} | Horário: ${horario}
    END

    Run Keyword If    '${index}' != '' and '${index}' != 'None'
    ...    Set Suite Variable    ${SESSAO_ID}    ${json["data"][${index}]["_id"]}

    Set Suite Variable    ${ULTIMA_RESPOSTA}    ${response}