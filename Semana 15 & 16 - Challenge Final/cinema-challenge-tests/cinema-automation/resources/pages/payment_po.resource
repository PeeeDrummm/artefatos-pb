*** Settings ***
Documentation    Documentation    Page Object – escolha de método de pagamento e finalização da compra.

Resource         ../base.resource

*** Keywords ***
Selecionar Método de Pagamento e Finalizar
    [Documentation]    Escolhe método, finaliza compra e guarda ID.
    [Arguments]    ${metodo}

    ${mapa_metodos}=    Create Dictionary
    ...                 Cartão de Crédito=1
    ...                 Cartão de Débito=2
    ...                 PIX=3
    ...                 Transferência Bancária=4

    ${indice}=          Get From Dictionary    ${mapa_metodos}    ${metodo}
    ${seletor}=         Set Variable           css=.payment-section div.payment-method:nth-child(${indice})

    Wait For Elements State    ${seletor}    visible
    Click                      ${seletor}

    Get Text    css=.btn    ==    Finalizar Compra
    Click       css=.btn

    # Valida se a reserva foi confirmada com sucesso e armazena o código da reserva
    # O Código da reserva deve possuir 24 caracteres
    Wait For Elements State    css=.confirmation-header > h1:nth-child(2)    visible
    Get Text                   css=.confirmation-header > h1:nth-child(2)    ==    Reserva Confirmada!

    ${reserva_id}=             Get Text    css=.confirmation-info .info-item span.info-value >> nth=0
    Length Should Be           ${reserva_id}    24
    Log To Console             Código da reserva gerado: ${reserva_id}
    Set Suite Variable         ${RESERVA_ID}    ${reserva_id}