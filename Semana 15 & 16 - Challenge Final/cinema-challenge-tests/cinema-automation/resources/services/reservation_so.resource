*** Settings ***
Documentation    Service Object – endpoint **/reservations**.

Resource         ../base.resource

*** Keywords ***
Efetuar Nova Reserva
    [Documentation]    POST /reservations para ${SESSION_ID}; assentos recebidos via argumentos.
    [Arguments]    ${row}    ${number}

    # Converte o número para inteiro
    ${number_int}=    Convert To Integer       ${number}

    # Criar o dicionário do assento e DEPOIS o adicionamos à lista
    ${seat}=          Create Dictionary        row=${row}    number=${number_int}    type=full
    ${seats_list}=    Create List              ${seat}

    ${body}=          Create Dictionary        session=${SESSION_ID}    seats=${seats_list}
    
    ${headers}=       Create Dictionary        Authorization=Bearer ${TOKEN}
    ${response}=      POST    ${BASE_API_URL}/reservations    json=${body}    headers=${headers}    expected_status=any

    Set Test Variable    ${ULTIMA_RESPOSTA}    ${response}

Deletar Reserva
    [Documentation]    DELETE /reservations/{id} – remove reserva (${RESERVA_ID}); grava ${ULTIMA_RESPOSTA}.
    ${headers}=    Create Dictionary
    ...            Authorization=Bearer ${TOKEN}
    ...            Content-Type=application/json

    ${response}=                   DELETE                     ${BASE_API_URL}/reservations/${RESERVA_ID}    headers=${headers}
    Should Be Equal As Integers    ${response.status_code}    200