*** Settings ***
Library    libs/database.py
Library    Browser

*** Keywords ***
Start Session
    New Browser    browser=firefox    headless=False
    New Page       http://localhost:3000