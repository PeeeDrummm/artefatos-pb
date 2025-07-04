*** Settings ***
Documentation    Service Object – endpoint **/movies** (criar, listar, atualizar, deletar).

Resource         ../base.resource

*** Keywords ***
Criar Filme
    [Documentation]    POST /movies usando fixture; grava ${FILME_ID} e ${ULTIMA_RESPOSTA}.
    [Arguments]    ${caminho_dados_filme}
    ${headers}=    Create Dictionary    Authorization=Bearer ${TOKEN}    Content-Type=application/json; charset=UTF-8

    # Força Codificação UTF-8
    ${body}=       Evaluate    json.load(open(r'''${caminho_dados_filme}''', encoding='utf-8'))    json
    ${body_str}=   Evaluate    json.dumps(${body}, ensure_ascii=False)    json

    ${response}=   POST    ${BASE_API_URL}/movies
    ...            headers=${headers}
    ...            data=${body_str}
    ...            expected_status=any

    Evaluate       setattr($response, 'encoding', 'utf-8')
    ${json}=       Set Variable        ${response.json()}

    Set Suite Variable    ${FILME_ID}           ${json["data"]["_id"]}
    Set Suite Variable    ${ULTIMA_RESPOSTA}    ${response}

Listar Todos os Filmes
    [Documentation]    GET /movies (listagem); opcionalmente salva filme por índice.
    [Arguments]         ${index}=None
    ${headers}=         Create Dictionary    Authorization=Bearer ${TOKEN}
    ${response}=        GET                  ${BASE_API_URL}/movies    headers=${headers}
    Status Should Be    200                  ${response}

    # Força Codificação UTF-8
    Evaluate          setattr($response, 'encoding', 'utf-8')
    ${json}=          Set Variable    ${response.json()}

    Log To Console     \nFilmes disponíveis:
    FOR    ${filme}    IN    @{json["data"]}
        Log To Console    - ${filme["title"]}
    END

    # Guarda o número do filme recebido como argumento.
    Run Keyword If    '${index}' != 'None'
    ...    Set Suite Variable    ${FILME_SELECIONADO}    ${json["data"][${index}]}

Atualizar Filme
    [Documentation]    PUT /movies/{id} – aplica fixture de atualização; grava ${ULTIMA_RESPOSTA}.
    [Arguments]    ${caminho_dados_filme}    ${id_filme}=
    ${headers}=    Create Dictionary    Authorization=Bearer ${TOKEN}    Content-Type=application/json; charset=UTF-8

    # Força Codificação UTF-8
    ${body}=       Evaluate    json.load(open(r'''${caminho_dados_filme}''', encoding='utf-8'))    json
    ${body_str}=   Evaluate    json.dumps(${body}, ensure_ascii=False)    json

    Run Keyword If    '${id_filme}' == ''    Set Test Variable    ${id_filme}    ${FILME_ID}
    Log To Console    Atualizando filme: ${body["title"]}

    ${url}=        Set Variable     ${BASE_API_URL}/movies/${id_filme}
    ${response}=   PUT    ${url}    headers=${headers}    data=${body_str}    expected_status=any

    Evaluate              setattr($response, 'encoding', 'utf-8')
    Set Suite Variable    ${ULTIMA_RESPOSTA}    ${response}

Deletar Filme
    [Documentation]    DELETE /movies/{id}; grava ${ULTIMA_RESPOSTA}.
    [Arguments]       ${id_filme}=
    ${headers}=       Create Dictionary    Authorization=Bearer ${TOKEN}

    Run Keyword If    '${id_filme}' == ''    Set Test Variable    ${id_filme}    ${FILME_ID}

    ${url}=           Set Variable    ${BASE_API_URL}/movies/${id_filme}
    ${response}=      DELETE          ${url}    headers=${headers}    expected_status=any

    Evaluate          setattr($response, 'encoding', 'utf-8')

    Set Suite Variable    ${ULTIMA_RESPOSTA}    ${response}