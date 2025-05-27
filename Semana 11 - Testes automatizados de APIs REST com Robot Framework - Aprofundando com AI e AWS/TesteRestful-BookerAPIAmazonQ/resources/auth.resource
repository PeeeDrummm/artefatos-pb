*** Settings ***
Library    RequestsLibrary
Library    JSONLibrary
Library    JSONSchemaLibrary
Resource   variables.resource

*** Keywords ***
Create Auth Session
    Create Session    auth_session    ${BASE_URL}

Generate Auth Token
    [Documentation]    Cria um token de autenticação e valida o schema
    ${auth_payload}=    Create Dictionary    username=${USERNAME}    password=${PASSWORD}
    ${response}=    POST On Session
    ...    auth_session
    ...    ${AUTH_ENDPOINT}
    ...    json=${auth_payload}
    ...    headers=${HEADERS}

    Handle API Error    ${response}
    Status Should Be    200    ${response}
    
    ${json}=    Convert To JSON    ${response.text}
    Validate Auth Response Schema    ${json}
    RETURN    ${json.token}

Validate Auth Response Schema
    [Arguments]    ${response_json}
    # carrega o schema já como dict
    ${schema}=    Load JSON From File    ${AUTH_SCHEMA}
    # valida diretamente o dict de resposta contra o dict de schema
    Validate JSON    ${schema}    ${response_json}

Generate Token And Validate Response Schema
    [Arguments]    ${username}    ${password}
    ${payload}=    Create Dictionary    username=${username}    password=${password}
    ${response}=    Post Request    Auth    /auth    json=${payload}
    Should Be Equal As Integers    ${response.status_code}    200
    # parseia o texto para dict, sem serializar de volta
    ${response_json}=    Load JSON From String    ${response.text}
    Validate Auth Response Schema    ${response_json}

Handle API Error
    [Arguments]    ${response}
    Run Keyword If    '${response.status_code}' >= '400'
    ...    Fail    API Error: ${response.status_code} - ${response.text}

Validate Booking Response Schema
    [Arguments]    ${response_json}
    ${schema}=    Load JSON Schema From File    ${BOOKING_SCHEMA}
    ${parsed}=    Convert To JSON    ${response_json}
    Validate JSON    ${schema}    ${parsed}

