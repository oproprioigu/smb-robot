*** Settings ***
Resource        setup.robot
Library         Collections
Library         OperatingSystem
Library         BrowserMobProxyLibrary
Library         ValidadorHar.py
Variables       ValidadorHar.py

*** Variables ***
${usuario}          qa.smbtest@gmail.com
${senha}            Banana09
${url}              https://smploja4.commercesuite.com.br/central-do-cliente
${product_url}      https://smploja4.commercesuite.com.br/bola/bola
${options}
${id}               comportamento
${request_url}      https://wonka.socialminer.com/ursa/enterprise/behaviors

*** Test Cases ***
Validar behaviour de cliente (Campanha Automatica)
    
    #Iniciando servidor local com configuração proxy
    Start Local Server              D:/Users/igor.mendes/Documents/browsermob-proxy-2.1.4/bin/browsermob-proxy
    &{port}                         Create Dictionary    port=8086
    ${BrowserMob_Proxy}=            Create Proxy    ${port}
    ${options}=                     Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    Call Method                     ${options}    add_argument       --proxy-server\=localhost:8086

    #Criando webdriver 
    Create WebDriver                Chrome    chrome_options=${options}
    Go To                           ${url}
    
    Espere e Clique no elemento     xpath://button[@class='botao-commerce botao-efetuar-login']
    Espere e Insira no elemento     id:input-email          ${usuario}
    Espere e Clique no elemento     id:tray-login-identify
    Espere e Insira no elemento     id:input-password       ${senha}
    Espere e Clique no elemento     id:password-submit
    Wait Until Element Is Visible   xpath://section[@class='app__customer-greetings app__header__greetings']    15
    
    
    #Inicia gravação para o arquivo har
    New Har                         comportamento
    Go To                           ${product_url}
    
    Sleep                           60
    #TODO Diminuir o tempo da espera do comportamento ser gerado pro arquivo har
    
    #Coletando tráfego e inserindo no arquivo .har
    ${har}=                         Get Har As Json
    Create File                     ${EXECDIR}${/}har/file.har     ${har}
    #Finaliza o servidor local
    Stop Local Server

    #Usando a função do ValidadorHar.py para buscar a URL de behaviour
    ${validador_har}=               Validar Har          ${id}          ${request_url} 
    Should Be Equal                 ${validador_har}     ${true}        Request URL de behaviour não encontrada no arquivo har

    #Apagando o arquivo .har
    #Deletar Har
    Close Browser