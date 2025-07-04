*** Settings ***
Documentation    Service Object – endpoint **/theaters** (salas de cinema).

Resource         ../base.resource

*** Keywords ***
Obter Primeiro Teatro Disponível
    [Documentation]    GET /theaters; salva o primeiro _id em ${THEATER_ID}.
    ${headers}=           Create Dictionary        Authorization=Bearer ${TOKEN}
    ${response}=          GET                      ${BASE_API_URL}/theaters    headers=${headers}
    Status Should Be      200                      ${response}

    ${json}=              Convert To Dictionary    ${response.json()}
    ${theater_id}=        Get From Dictionary      ${json["data"][0]}    _id
    Set Suite Variable    ${THEATER_ID}            ${theater_id}

Criar Sala
    [Documentation]    POST /theaters – cria sala; grava ${SALA_ID} e ${ULTIMA_RESPOSTA}.
    [Arguments]    ${nome}              ${capacidade}                    ${tipo}
    ${headers}=    Create Dictionary    Authorization=Bearer ${TOKEN}    Content-Type=application/json; charset=UTF-8

    ${body}=       Create Dictionary
    ...            name=${nome}
    ...            capacity=${capacidade}
    ...            type=${tipo}
    ${body_str}=   Evaluate    json.dumps(${body}, ensure_ascii=False)    json

    ${response}=   POST    ${BASE_API_URL}/theaters
    ...            headers=${headers}
    ...            data=${body_str}
    ...            expected_status=any

    Evaluate              setattr($response, 'encoding', 'utf-8')
    ${json}=              Set Variable          ${response.json()}
    Set Suite Variable    ${SALA_ID}            ${json["data"]["_id"]}
    Set Suite Variable    ${ULTIMA_RESPOSTA}    ${response}

Listar Todas as Salas
    [Documentation]    GET /theaters – lista salas e, se índice dado, seta ${SALA_ID}.
    [Arguments]         ${index}=None
    ${response}=        GET    ${BASE_API_URL}/theaters
    Status Should Be    200    ${response}

    Evaluate            setattr($response, 'encoding', 'utf-8')
    ${json}=            Set Variable        ${response.json()}

    Log To Console    \nSalas disponíveis:
    FOR    ${sala}    IN    @{json["data"]}
        Log To Console    - ${sala["name"]} (${sala["type"]}) - Capacidade: ${sala["capacity"]}
    END

    # Só sobrescreve SALA_ID se for explicitamente solicitado com o argumento
    Run Keyword If    '${index}' != '' and '${index}' != 'None'
    ...    Set Suite Variable    ${SALA_ID}    ${json["data"][${index}]["_id"]}

    Set Suite Variable    ${ULTIMA_RESPOSTA}    ${response}

Atualizar Sala
    [Documentation]    PUT /theaters/{id} – altera nome / capacidade / tipo; grava ${ULTIMA_RESPOSTA}.
    [Arguments]    ${nome}              ${capacidade}        ${tipo}     ${id_sala}=
    ${headers}=    Create Dictionary    Authorization=Bearer ${TOKEN}    Content-Type=application/json; charset=UTF-8

    ${body}=       Create Dictionary
    ...            name=${nome}
    ...            capacity=${capacidade}
    ...            type=${tipo}
    ${body_str}=   Evaluate    json.dumps(${body}, ensure_ascii=False)    json

    Run Keyword If    '${id_sala}' == ''    Set Test Variable    ${id_sala}    ${SALA_ID}
    Log To Console    Atualizando sala: ${body["name"]}

    ${url}=        Set Variable    ${BASE_API_URL}/theaters/${id_sala}
    ${response}=   PUT             ${url}    headers=${headers}    data=${body_str}    expected_status=any

    Evaluate    setattr($response, 'encoding', 'utf-8')
    Set Suite Variable    ${ULTIMA_RESPOSTA}    ${response}

Deletar Sala
    [Documentation]    DELETE /theaters/{id}; grava ${ULTIMA_RESPOSTA}.
    [Arguments]       ${id_sala}=
    ${id_sala}=    Set Variable If    '${id_sala}' == '' or '${id_sala}' == 'None'    ${SALA_ID}    ${id_sala}
    Set Suite Variable    ${SALA_ID}    ${id_sala}
    ${headers}=       Create Dictionary    Authorization=Bearer ${TOKEN}

    ${url}=           Set Variable    ${BASE_API_URL}/theaters/${id_sala}
    ${response}=      DELETE          ${url}    headers=${headers}    expected_status=any

    Evaluate              setattr($response, 'encoding', 'utf-8')
    Set Suite Variable    ${ULTIMA_RESPOSTA}        ${response}