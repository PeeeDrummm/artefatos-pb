*** Settings ***
Suite Setup    Health Check
Resource       ../resources/healthcheck.resource
Resource       ../resources/booking.resource
Resource       ../resources/auth.resource
Resource       ../resources/variables.resource

*** Test Cases ***
Booking Scenario: Create, List, Filter, Update, Patch, Delete and Validate Booking
    # Garantir que ${auth_token} existe/foi criado
    Generate Auth Token
    # Cria uma reserva aleatória e armazena variáveis
    Create New Booking
    # Busca todos os IDs e valida que o sistema tem reservas
    Get All Booking IDs
    # Filtra a reserva usando nome, sobrenome e datas retornadas
    Filter Booking By Name And Dates
    # Busca a reserva recém-criada pelo ID e valida todos os campos
    Get Booking By ID And Validate
    # Atualiza informações de uma Reserva
    Update Booking By ID And Validade
    # Atualiza apenas algumas informações de uma Reserva
    Partial Update Booking By ID
    # Deletar uma Reserva
    Delete Booking By ID