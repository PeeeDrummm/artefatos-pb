*** Settings ***
Library     Browser
Library     JSONLibrary
Library     libs/database.py
Resource    env.resource
Resource    services.resource
Resource    pages/SignupPage.resource
Resource    pages/LoginPage.resource
Resource    pages/components/Notice.resource
Resource    pages/components/Header.resource
Resource    pages/components/Alert.resource
Resource    pages/TaskCreatePage.resource
Resource    pages/TaskPage.resource

*** Keywords ***
Start Session
    New Browser    browser=firefox    headless=False
    New Page       ${BASE_URL}

# Helpers
Get fixture
    [Arguments]    ${file_name}    ${scenario}

    ${data}    Load Json From File    
    ...        ${EXECDIR}/resources/fixtures/${file_name}.json
    ...        encoding=utf-8

    RETURN     ${data}[${scenario}]