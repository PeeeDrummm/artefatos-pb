*** Settings ***
Library    RequestsLibrary
Library    Collections
Library    OperatingSystem
Library    String
Resource   variables.resource

*** Keywords ***
    # Cria uma nova reserva com dados aleatórios e armazena todos os campos retornados como Suite Variables
Create New Booking
    # Gera dados aleatórios para evitar duplicidade nos testes
    ${firstname}       Generate Random String    8    [LETTERS]
    ${lastname}        Generate Random String    4    [LETTERS]
    ${total_price}     Evaluate    random.randint(100, 1000)    modules=random

    # Cria cabeçalhos HTTP
    ${headers}         Create Dictionary    Content-Type=application/json    Accept=application/json

    # Cria dicionário para datas
    ${booking_dates}   Create Dictionary    checkin=2025-05-22    checkout=2026-05-26

    # Cria corpo da requisição de reserva com dados aleatórios
    ${request_body}    Create Dictionary
    ...    firstname=${firstname}
    ...    lastname=${lastname}
    ...    totalprice=${total_price}
    ...    depositpaid=${True}
    ...    bookingdates=${booking_dates}
    ...    additionalneeds=Double bed

    # Cria a sessão (conexão com a API) — pode ser chamada várias vezes sem erro
    Create Session     Booker    ${base_url}
    # Envia requisição POST para criar reserva
    ${response}        POST On Session    Booker    /booking    json=${request_body}    headers=${headers}    expected_status=200

    # Salva todos os dados retornados como Suite Variable para uso em outros testes/keywords
    Set Suite Variable    ${booking_id}              ${response.json()}[bookingid]
    Set Suite Variable    ${firstname_returned}      ${response.json()}[booking][firstname]
    Set Suite Variable    ${lastname_returned}       ${response.json()}[booking][lastname]
    Set Suite Variable    ${totalprice_returned}     ${response.json()}[booking][totalprice]
    Set Suite Variable    ${depositpaid_returned}    ${response.json()}[booking][depositpaid]
    Set Suite Variable    ${checkin_returned}        ${response.json()}[booking][bookingdates][checkin]
    Set Suite Variable    ${checkout_returned}       ${response.json()}[booking][bookingdates][checkout]
    Set Suite Variable    ${needs_returned}          ${response.json()}[booking][additionalneeds]
    # Também salva os nomes e preços enviados, caso precise comparar depois
    Set Suite Variable    ${firstname_sent}          ${firstname}
    Set Suite Variable    ${lastname_sent}           ${lastname}
    Set Suite Variable    ${totalprice_sent}         ${total_price}

    # Retorna todos os IDs de reservas e valida que não está vazio
Get All Booking IDs
    Create Session     Booker    ${base_url}
    ${response}        GET On Session    Booker    /booking    expected_status=200
    # Valida que há pelo menos uma reserva retornada
    Should Not Be Empty    ${response.json()}

    # Busca reservas filtrando por nome, sobrenome e datas
Filter Booking By Name And Dates
    # Usa os valores retornados da última criação de reserva
    ${params}    Create Dictionary
    ...    firstname=${firstname_returned}
    ...    lastname=${lastname_returned}
    ...    checkin=${checkin_returned}
    ...    checkout=${checkout_returned}
    Create Session    Booker    ${base_url}
    ${response}       GET On Session    Booker    /booking    params=${params}    expected_status=200

    # Busca reserva específica pelo ID e valida os campos
Get Booking By ID And Validate
    Create Session    Booker    ${base_url}
    ${headers}        Create Dictionary    Accept=application/json
    ${response}       GET On Session       Booker    /booking/${booking_id}    headers=${headers}    expected_status=200
    ${json}           Set Variable         ${response.json()}
    # Valida que os dados retornados batem com o que foi enviado
    Should Be Equal               ${json['firstname']}                   ${firstname_sent}
    Should Be Equal               ${json['lastname']}                    ${lastname_sent}
    Should Be Equal As Numbers    ${json['totalprice']}                  ${totalprice_sent}
    Should Be Equal               ${json['bookingdates']['checkin']}     ${checkin_returned}
    Should Be Equal               ${json['bookingdates']['checkout']}    ${checkout_returned}
    Should Be Equal               ${json['additionalneeds']}             ${needs_returned}
    
    # Atualiza informações de uma Reserva criada anteriormente
Update Booking By ID And Validade
    # Cria nova sessão com a API
    Create Session    Booker    ${base_url}

    # Cria headers com autenticação por token via cookie
    ${headers}    Create Dictionary    
    ...    Content-Type=application/json    
    ...    Accept=application/json  
    ...    Cookie=token=${auth_token}

    # Gera novas datas para atualização
    ${booking_dates}   Create Dictionary    checkin=2025-05-28    checkout=2026-05-30

    # Gera novos dados aleatórios para atualização
    ${firstname}       Generate Random String    8    [LETTERS]
    ${lastname}        Generate Random String    4    [LETTERS]
    ${total_price}     Evaluate    random.randint(100, 1000)    modules=random

    # Cria novo corpo da reserva
    ${request_body}    Create Dictionary
    ...    firstname=${firstname}
    ...    lastname=${lastname}
    ...    totalprice=${total_price}
    ...    depositpaid=${True}
    ...    bookingdates=${booking_dates}
    ...    additionalneeds=Triple bed

    # Envia requisição PUT para atualizar a reserva existente
    ${response}    PUT On Session    Booker    /booking/${booking_id}    json=${request_body}    headers=${headers}    expected_status=200

    # Converte resposta para JSON
    ${updated_json}    Set Variable    ${response.json()}

    # Valida se os dados retornados correspondem ao que foi enviado
    Should Be Equal               ${updated_json['firstname']}                   ${firstname}
    Should Be Equal               ${updated_json['lastname']}                    ${lastname}
    Should Be Equal As Numbers    ${updated_json['totalprice']}                  ${total_price}
    Should Be Equal               ${updated_json['bookingdates']['checkin']}     ${booking_dates['checkin']}
    Should Be Equal               ${updated_json['bookingdates']['checkout']}    ${booking_dates['checkout']}
    Should Be Equal               ${updated_json['additionalneeds']}             Triple bed
    
    # Atualiza apenas algumas informações de uma Reserva criada anteriormente
Partial Update Booking By ID
    Create Session    Booker    ${base_url}

    ${headers}    Create Dictionary
    ...    Content-Type=application/json
    ...    Accept=application/json
    ...    Cookie=token=${auth_token}

    # Gera novos dados parciais
    ${updated_firstname}      Generate Random String    6    [LETTERS]
    ${updated_needs}          Set Variable    Breakfast only

    # Cria corpo com apenas os campos a serem atualizados
    ${partial_body}    Create Dictionary
    ...    firstname=${updated_firstname}
    ...    additionalneeds=${updated_needs}

    # Realiza PATCH na reserva existente
    ${response}    PATCH On Session    Booker    /booking/${booking_id}    json=${partial_body}    headers=${headers}    expected_status=200

    # Converte resposta e valida se os campos foram atualizados corretamente
    ${json}    Set Variable    ${response.json()}
    Should Be Equal    ${json['firstname']}         ${updated_firstname}
    Should Be Equal    ${json['additionalneeds']}   ${updated_needs}

Delete Booking By ID
    Create Session    Booker    ${base_url}

    ${headers}    Create Dictionary
    ...    Content-Type=application/json
    ...    Accept=application/json
    ...    Cookie=token=${auth_token}

    # Realiza DELETE na reserva existente
    ${response}    DELETE On Session    Booker    /booking/${booking_id}    headers=${headers}    expected_status=201

    # Valida o conteúdo textual da resposta
    Should Be Equal    ${response.content.decode()}    Created