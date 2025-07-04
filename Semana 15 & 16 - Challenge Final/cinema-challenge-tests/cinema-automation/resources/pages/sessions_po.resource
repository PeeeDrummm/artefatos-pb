*** Settings ***
Documentation    Page Object – escolha de sessões de um filme.

Resource         ../base.resource

*** Keywords ***
Selecionar Sessão
    [Documentation]    Abre tela de assentos para a sessão indicada.
    [Arguments]                ${indice}
    ${seletor}=                Set Variable        css=div.session-date-group:nth-child(1) > div:nth-child(2) > div:nth-child(${indice}) > a:nth-child(2)
    Wait For Elements State    ${seletor}          visible
    Get Text                   ${seletor}    ==    Selecionar Assentos
    Click                      ${seletor}
    Wait For Elements State    css=.seat-selection-container    visible

    # Valida se tem assentos disponíveis
    ${assentos_disponiveis}=   Get Element Count              css=button:not(.occupied)
    Should Be True             ${assentos_disponiveis} > 0    Nenhum assento disponível nesta sessão!