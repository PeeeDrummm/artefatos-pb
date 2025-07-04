*** Settings ***
Documentation    Page Object – tela de Login: navegação, login e alertas.

Resource         ../base.resource

*** Keywords ***
Ir para Página de Login
    [Documentation]    Navega do header até /login; espera container visível.
    Get Text                   css=header a[href="/login"]    ==    Login
    Click                      css=header a[href="/login"]
    Wait For Elements State    css=.login-container                 visible

Efetuar Login
    [Documentation]    Preenche campos e clica em “Entrar”.
    [Arguments]    ${EMAIL_LOGIN}    ${SENHA_LOGIN}
    Fill Text      id=email          ${EMAIL_LOGIN}
    Fill Text      id=password       ${SENHA_LOGIN}

    Get Text       css=.login-btn    ==    Entrar
    Click          css=.login-btn

Validar Alerta Contendo Mensagem
    [Documentation]    Confirma que alerta mostra a mensagem esperada.
    [Arguments]                ${mensagem_esperada}
    Wait For Elements State    css=div.alert-content          visible
    Get Text                   css=div.alert-content    ==    ${mensagem_esperada}