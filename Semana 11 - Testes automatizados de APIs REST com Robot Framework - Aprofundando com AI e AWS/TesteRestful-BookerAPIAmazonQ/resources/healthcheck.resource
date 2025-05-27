*** Settings ***
Library    RequestsLibrary
Library    BuiltIn
Resource   variables.resource

*** Keywords ***
Check API Health
    Create Session    health_session    ${BASE_URL}
    ${response}=    GET On Session    health_session    ${PING_ENDPOINT}
    Status Should Be    201    ${response}