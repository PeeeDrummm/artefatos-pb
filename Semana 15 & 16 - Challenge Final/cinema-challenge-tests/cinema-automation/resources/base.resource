*** Settings ***
Documentation    Resource base: variáveis globais, sessão HTTP e helpers genéricos.

Library          RequestsLibrary
Library          OperatingSystem
Library          Collections
Library          JSONLibrary
Library          Browser
Library          ../utils/db_keywords.py
Library          ../utils/GeminiValidationLibrary.py    WITH NAME    base

Resource         ../resources/pages/browser_po.resource
Resource         ../resources/pages/login_po.resource
Resource         ../resources/pages/movies_po.resource
Resource         ../resources/pages/payment_po.resource
Resource         ../resources/pages/register_po.resource
Resource         ../resources/pages/reservation_po.resource
Resource         ../resources/pages/seat_po.resource
Resource         ../resources/pages/sessions_po.resource

Resource         ../resources/services/auth_so.resource
Resource         ../resources/services/movies_so.resource
Resource         ../resources/services/reservation_so.resource
Resource         ../resources/services/session_so.resource
Resource         ../resources/services/theater_so.resource

*** Variables ***
${BASE_API_URL}      https://cinema-challenge-back-xelh.onrender.com/api/v1
${BASE_FRONT_URL}    https://cinema-challenge-front.onrender.com/
${BROWSER}           chromium

*** Keywords ***
Criar Sessão API
    [Documentation]    `Create Session   CinemaAPP   ${BASE_API_URL}` – inicia sessão Requests.
    Create Session    CinemaAPP    ${BASE_API_URL}

Validar Código de Status
    [Documentation]    Compara status da última resposta com valor esperado.
    [Arguments]                    ${status_esperado}
    Should Be Equal As Integers    ${ULTIMA_RESPOSTA.status_code}    ${status_esperado}

Validar Mensagem Response
    [Documentation]    Verifica se campo 'message' da última resposta é igual ao esperado.
    [Arguments]        ${mensagem_esperada}
    ${mensagem}=       Set Variable            ${ULTIMA_RESPOSTA.json()['message']}
    Should Be Equal    ${mensagem}             ${mensagem_esperada}

Analisar e Validar Resposta com IA
    [Documentation]    Usa Gemini para comparar corpo + status da resposta com contexto esperado.
    [Arguments]    ${status_code_esperado}    ${contexto_esperado}
    
    ${analise}=    Validar Resposta Da Api Com Ia
    ...            ${ULTIMA_RESPOSTA.text}          # Argumento 1: resposta_real_api
    ...            ${ULTIMA_RESPOSTA.status_code}   # Argumento 2: status_code_real
    ...            ${status_code_esperado}          # Argumento 3: status_code_esperado
    ...            ${contexto_esperado}             # Argumento 4: contexto_esperado
    
    Log To Console    \nAnálise da IA: ${analise}