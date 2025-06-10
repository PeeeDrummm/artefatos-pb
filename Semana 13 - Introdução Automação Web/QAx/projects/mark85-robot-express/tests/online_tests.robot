*** Settings ***
Documentation    Online
Resource         ../resources/base_keywords.resource

*** Test Cases ***
Webapp deve estar online
    Start Session
    Get Title      equal    Mark85 by QAx