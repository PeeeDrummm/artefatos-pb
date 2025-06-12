*** Settings ***
Documentation    Cenários de testes do cadastro de usuários
Resource         ../resources/base_keywords.resource
# Suite Setup      Log    Executado uma uníca vez antes de toda suite
# Suite Teardown   Log    Executado uma única vez depois de toda suite
Test Setup       Start Session      #Executado antes de cada teste
Test Teardown    Take Screenshot    #Executado depois de cada teste

*** Test Cases ***
Deve poder cadastrar um novo usuário
    
    ${user}        Create Dictionary    
    ...            name=Pedro Afonso    
    ...            email=pedro.afonso@qa.com.br    
    ...            password=testando123

    Remove user from database    ${user}[email]

    Go to signup page
    Submit signup form    ${user}
    Notice should be      Boas vindas ao Mark85, o seu gerenciador de tarefas.

Não deve permitir o cadastro com email duplicado
    [Tags]    dup

    ${user}        Create Dictionary    
    ...            name=Afonso Pedro    
    ...            email=afonso.pedro@aq.com.br    
    ...            password=testando123

    Remove user from database    ${user}[email]
    Insert user from database    ${user}

    Go to signup page
    Submit signup form    ${user}
    Notice should be      Oops! Já existe uma conta com o e-mail informado.

Campos Obrigatórios
    [Tags]     Required
    ${user}    Create Dictionary    
    ...    name=${EMPTY}
    ...    email=${EMPTY}
    ...    password=${EMPTY}

    Go to signup page
    Submit signup form    ${user}

    Alert should be    Informe seu nome completo
    Alert should be    Informe seu e-email
    Alert should be    Informe uma senha com pelo menos 6 digitos

Não deve cadastrar com email incorreto
    [Tags]    EmailInvalido

    ${user}    Create Dictionary    
    ...        name=Charles Xavier
    ...        email=xavier.com.br
    ...        password=testando123

    Go to signup page
    Submit signup form    ${user}
    Alert should be       Digite um e-mail válido

Não deve cadastrar senha muito curta
    [Tags]    temp
    @{password_list}    Create List    1    12    123    1234    12345
    FOR    ${password}    IN    @{password_list}
        ${user}    Create Dictionary    
        ...    name=Pedro Afonso
        ...    email=pedro.afonso@qa.gov.br
        ...    password=${password}

        Go to signup page
        Submit signup form    ${user}

        Alert should be    Informe uma senha com pelo menos 6 digitos
    END