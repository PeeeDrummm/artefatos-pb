*** Settings ***
Library    RequestsLibrary
Library    Collections
Library    JSONSchemaLibrary
Library    JSONLibrary
Library    FakerLibrary
Resource   variables.resource
Resource   auth.resource

*** Keywords ***
Generate Booking Data
    ${first_name}=    First Name
    ${last_name}=     Last Name
    ${price}=         Random Int    min=100    max=1000
    ${checkin}=       Future Date
    ${checkout}=      Future Date    ${checkin}
    ${needs}=         Random Element    values=@{['Breakfast', 'Lunch', 'Dinner']}

    ${booking_data}=    Create Dictionary
    ...    firstname=${first_name}
    ...    lastname=${last_name}
    ...    totalprice=${price}
    ...    depositpaid=${TRUE}
    ...    bookingdates=&{checkin=${checkin}, checkout=${checkout}}
    ...    additionalneeds=${needs}

    RETURN    ${booking_data}

Create Booking
    [Arguments]    ${booking_data}
    ${response}=    POST On Session
    ...    auth_session
    ...    ${BOOKING_ENDPOINT}
    ...    json=${booking_data}
    ...    headers=${HEADERS}

    Handle API Error    ${response}
    Status Should Be    200    ${response}
    Validate Booking Response Schema    ${response.json()}
    RETURN    ${response.json()}

Get Booking
    [Arguments]    ${booking_id}
    ${response}=    GET On Session
    ...    auth_session
    ...    ${BOOKING_ENDPOINT}/${booking_id}
    ...    headers=${HEADERS}

    Handle API Error    ${response}
    Status Should Be    200    ${response}
    Validate Booking Response Schema    ${response.json()}
    RETURN    ${response.json()}

Update Booking
    [Arguments]    ${booking_id}    ${booking_data}    ${token}
    &{auth_header}=    Create Dictionary    &{HEADERS}    Cookie=token=${token}

    ${response}=    PUT On Session
    ...    auth_session
    ...    ${BOOKING_ENDPOINT}/${booking_id}
    ...    json=${booking_data}
    ...    headers=${auth_header}

    Handle API Error    ${response}
    Status Should Be    200    ${response}
    Validate Booking Response Schema    ${response.json()}
    RETURN    ${response.json()}

Patch Booking
    [Arguments]    ${booking_id}    ${booking_data}    ${token}
    &{auth_header}=    Create Dictionary    &{HEADERS}    Cookie=token=${token}

    ${response}=    PATCH On Session
    ...    auth_session
    ...    ${BOOKING_ENDPOINT}/${booking_id}
    ...    json=${booking_data}
    ...    headers=${auth_header}

    Handle API Error    ${response}
    Status Should Be    200    ${response}
    RETURN    ${response.json()}

Delete Booking
    [Arguments]    ${booking_id}    ${token}
    &{auth_header}=    Create Dictionary    &{HEADERS}    Cookie=token=${token}

    ${response}=    DELETE On Session
    ...    auth_session
    ...    ${BOOKING_ENDPOINT}/${booking_id}
    ...    headers=${auth_header}

    Handle API Error    ${response}
    Status Should Be    201    ${response}

Validate Booking Response Schema
    [Arguments]    ${response_json}
    ${schema}=    Load JSON From File    ${BOOKING_SCHEMA}
    Validate JSON    ${schema}    ${response_json}

Create New Booking And Validate Response Schema
    [Arguments]    ${booking_payload}
    ${response}=    Post Request    Booking    /booking    json=${booking_payload}
    Should Be Equal As Integers    ${response.status_code}    200
    ${response_json}=    Load JSON From String    ${response.text}
    Validate Booking Response Schema    ${response_json}