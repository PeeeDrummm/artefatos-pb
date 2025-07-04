*** Settings ***
Documentation    Page Object: página “/register”. - Contém navegação até a tela de cadastro e preenchimento do formulário.

Resource         ../base.resource

*** Keywords ***
Ir para Página de Registro
    [Documentation]    Clica no link “Cadastrar” no header e aguarda a tela de registro ficar visível.
    Get Text                   css=header a[href="/register"]    ==    Cadastrar
    Click                      css=header a[href="/register"]
    Wait For Elements State    css=.register-container                 visible

Efetuar Registro
    [Documentation]    Preenche nome, e-mail, senha/confirmar senha e clica em “Cadastrar”.
    [Arguments]    ${NOME_REGISTRO}        ${EMAIL_REGISTRO}    ${SENHA_REGISTRO}
    Fill Text      id=name                 ${NOME_REGISTRO}
    Fill Text      id=email                ${EMAIL_REGISTRO}
    Fill Text      id=password             ${SENHA_REGISTRO}
    Fill Text      id=confirmPassword      ${SENHA_REGISTRO}

    Get Text       css=button.btn    ==    Cadastrar
    Click          css=button.btn