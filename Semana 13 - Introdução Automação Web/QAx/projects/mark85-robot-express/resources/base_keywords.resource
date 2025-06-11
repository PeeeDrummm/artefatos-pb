*** Settings ***
Library     Browser
Library     libs/database.py
Resource    env.resource
Resource    pages/SignupPage.resource
Resource    pages/Loginpage.resource
Resource    pages/components/Notice.resource
Resource    pages/components/Header.resource
Resource    pages/components/Alert.resource

*** Keywords ***
Start Session
    New Browser    browser=firefox    headless=False
    New Page       ${BASE_URL}