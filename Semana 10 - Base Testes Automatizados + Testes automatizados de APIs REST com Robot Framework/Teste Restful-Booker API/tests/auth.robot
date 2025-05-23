*** Settings ***
Suite Setup    Health Check
Resource       ../resources/healthcheck.resource
Resource       ../resources/auth.resource
Resource       ../resources/variables.resource

*** Test Cases ***
Generate Token and Validate
    # Gera um token e armazena para uso posterior
    Generate Auth Token
    # Loga o token para visualização
    Log To Console    Auth token generated: ${auth_token}
    # Valida que o token não está vazio
    Should Not Be Empty    ${auth_token}