*** Settings ***
Documentation     Booking tests for Restful-booker API
Library           RequestsLibrary
Library           JSONLibrary
Library           Collections
Library           OperatingSystem
Library           BuiltIn
Library           JSONSchemaLibrary
Resource          ../resources/booking.resource
Resource          ../resources/variables.resource

Suite Setup       Run Keywords    Create Auth Session    AND    Set Suite Variables
Test Setup        Generate New Booking Data
Test Teardown     Run Keyword If Test Failed    Handle Test Failure

*** Variables ***
${BOOKING_ID}     ${EMPTY}
${AUTH_TOKEN}     ${EMPTY}

*** Keywords ***
Set Suite Variables
    ${token}=    Generate Auth Token
    Set Suite Variable    ${AUTH_TOKEN}    ${token}

Generate New Booking Data
    ${booking_data}=    Generate Booking Data
    Set Test Variable    ${BOOKING_DATA}    ${booking_data}

Handle Test Failure
    Run Keyword If    '${BOOKING_ID}' != '${EMPTY}'
    ...    Delete Booking    ${BOOKING_ID}    ${AUTH_TOKEN}

*** Test Cases ***
Create New Booking
    [Documentation]    Creates a new booking and validates the response
    ${response}=    Create Booking    ${BOOKING_DATA}
    Set Suite Variable    ${BOOKING_ID}    ${response}[bookingid]
    Dictionary Should Contain Key    ${response}    bookingid
    Dictionary Should Contain Key    ${response}    booking

Get Existing Booking
    [Documentation]    Retrieves and validates an existing booking
    ${response}=    Create Booking    ${BOOKING_DATA}
    ${booking_id}=    Set Variable    ${response}[bookingid]
    ${get_response}=    Get Booking    ${booking_id}
    Dictionaries Should Be Equal    ${get_response}    ${BOOKING_DATA}

Update Existing Booking
    [Documentation]    Updates an existing booking and validates changes
    ${response}=    Create Booking    ${BOOKING_DATA}
    ${booking_id}=    Set Variable    ${response}[bookingid]
    ${new_data}=      Generate Booking Data
    ${update_response}=    Update Booking    ${booking_id}    ${new_data}    ${AUTH_TOKEN}
    Dictionaries Should Be Equal    ${update_response}    ${new_data}

Partially Update Booking
    [Documentation]    Tests partial update of a booking
    ${response}=    Create Booking    ${BOOKING_DATA}
    ${booking_id}=    Set Variable    ${response}[bookingid]
    ${patch_data}=    Create Dictionary    firstname=UpdatedName
    ${patch_response}=    Patch Booking    ${booking_id}    ${patch_data}    ${AUTH_TOKEN}
    Should Be Equal    ${patch_response}[firstname]    UpdatedName

Delete Existing Booking
    [Documentation]    Deletes a booking and verifies deletion
    ${response}=    Create Booking    ${BOOKING_DATA}
    ${booking_id}=    Set Variable    ${response}[bookingid]
    Delete Booking    ${booking_id}    ${AUTH_TOKEN}
    Run Keyword And Expect Error    *404*    Get Booking    ${booking_id}

Validate API Error Handling
    [Documentation]    Tests API error handling for invalid requests
    ${invalid_id}=    Set Variable    999999
    Run Keyword And Expect Error    *404*    Get Booking    ${invalid_id}

    ${invalid_data}=    Create Dictionary    invalid=data
    Run Keyword And Expect Error    *400*    Create Booking    ${invalid_data}