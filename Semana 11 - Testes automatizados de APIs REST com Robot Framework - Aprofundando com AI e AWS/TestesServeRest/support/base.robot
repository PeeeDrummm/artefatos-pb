*** Settings ***
Documentation    Arquivo Simples para Requisições HTTP em APIs REST
Library          RequestsLibrary
Library          Collections
Library          OperatingSystem
Resource         ./common/common.robot
Resource         ./Fixtures/dynamics.robot
Resource         ./variables/serverest_variables.robot

*** Keywords ***
Criar Sessão
    Create Session    ServeRest    ${BASE_URI}