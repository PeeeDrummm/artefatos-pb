*** Settings ***
Documentation    Documentation    Page Object – listagem e validação das reservas do usuário.

Resource         ../base.resource

*** Keywords ***
Ir Para Página de Minhas Reservas
    [Documentation]    Abre tela /reservations e aguarda lista.
    Get Text                   css=header a[href="/reservations"]    ==    Minhas Reservas
    Click                      css=header a[href="/reservations"]
    Wait For Elements State    css=.reservations-page                visible
    Wait For Elements State    css=.reservations-list                visible

Validar Reservas
    [Documentation]    Percorre cards, loga campos e garante que há reservas.
    Wait For Elements State    css=.reservations-list    visible
    ${total}=                  Get Element Count         css=.reservation-card
    Should Be True             ${total} > 0              msg=Usuário não possui nenhuma reserva!

    Log To Console    \n🔎 Total de reservas: ${total}
    FOR    ${i}    IN RANGE    1    ${total + 1}
        ${reserva_id}=         Get Text    css=div.reservation-card:nth-child(${i}) h3
        ${status}=             Get Text    css=div.reservation-card:nth-child(${i}) .status-badge
        ${filme}=              Get Text    css=div.reservation-card:nth-child(${i}) .reservation-details h4
        ${data}=               Get Text    xpath=(//div[@class="reservation-card"][${i}]//div[contains(@class,"detail-item")])[1]/span
        ${hora}=               Get Text    xpath=(//div[@class="reservation-card"][${i}]//div[contains(@class,"detail-item")])[2]/span
        ${sala}=               Get Text    xpath=(//div[@class="reservation-card"][${i}]//div[contains(@class,"detail-item")])[3]/span
        ${assentos}=           Get Text    xpath=(//div[@class="reservation-card"][${i}]//div[contains(@class,"detail-item")])[4]/span
        ${preco}=              Get Text    css=div.reservation-card:nth-child(${i}) .price-info .price
        ${pagamento}=          Get Text    css=div.reservation-card:nth-child(${i}) .payment-info span:nth-child(2)

        Log To Console    \n🔹 Reserva ${i}
        Log To Console    ID: ${reserva_id}
        Log To Console    Status: ${status}
        Log To Console    Filme: ${filme}
        Log To Console    Data: ${data}
        Log To Console    Horário: ${hora}
        Log To Console    Sala: ${sala}
        Log To Console    Assentos: ${assentos}
        Log To Console    Preço: ${preco}
        Log To Console    Pagamento: ${pagamento}
    END