*** Settings ***
Documentation     Authentication tests for Restful-booker API
Library           RequestsLibrary
Library           JSONLibrary
Library           JSONSchemaLibrary
Resource          ../resources/auth.resource
Resource          ../resources/variables.resource

Suite Setup       Create Auth Session

*** Test Cases ***
Generate Token And Validate Response Schema
    [Documentation]    Validates token generation and schema response
    ${token}=    Generate Auth Token
    Should Not Be Empty    ${token}

Validate Authentication With Invalid Credentials
    [Documentation]    Validates error when using wrong credentials
    ${invalid_payload}=    Create Dictionary    username=wronguser    password=wrongpass
    ${response}=    POST On Session
    ...    auth_session
    ...    ${AUTH_ENDPOINT}
    ...    json=${invalid_payload}
    ...    headers=${HEADERS}
    
    Status Should Be    401    ${response}
    Should Contain    ${response.text}    Bad credentials