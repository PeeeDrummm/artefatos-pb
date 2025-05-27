*** Settings ***
Documentation     Health check for the Restful-booker API
Library           RequestsLibrary
Resource          ../resources/healthcheck.resource
Resource          ../resources/variables.resource

Suite Setup       Create Session    health_session    ${BASE_URL}

*** Test Cases ***
Check API Health Endpoint
    [Documentation]    Checks the /ping endpoint for service availability
    ${response}=    GET On Session    health_session    ${PING_ENDPOINT}
    Status Should Be    201    ${response}