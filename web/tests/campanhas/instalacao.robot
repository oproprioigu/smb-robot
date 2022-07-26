*** Settings ***
Resource        setup.robot
Library         Collections
Library         OperatingSystem
Library         BrowserMobProxyLibrary
Library         ValidadorHar.py

Test Teardown   Encerra sessão

*** Variables ***
${loja}             954305
${usuario}          smploja4
${senha}            De211968?
${url}              https://loja-s.tray.com.br/adm/login.php 
${id}               instalacao
${request_url}      https://bifrost.socialminer.com/TrayApp/install

*** Test Cases ***
Deve efetuar uma instalação completa do app da Social Miner na loja Tray
    [tags]

    #Iniciando servidor local com configuração proxy
    Start Local Server              D:/Users/igor.mendes/Documents/browsermob-proxy-2.1.4/bin/browsermob-proxy
                                    #{ALTERAR PATH}
    &{port}                         Create Dictionary    port=8086
    ${BrowserMob_Proxy}=            Create Proxy    ${port}
    ${options}=                     Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    Call Method                     ${options}    add_argument       --proxy-server\=localhost:8086

    #Criando webdriver 
    Create WebDriver                Chrome    chrome_options=${options}
    Go To                           ${url}
    #TODO Transformar isso numa keyword

    Logar no aplicativo da Social Miner                 ${loja}     ${usuario}      ${senha}

    Sleep                                               5
    #TODO remover futuramente

    #Inicia gravação para o arquivo har
    New Har                                             instalacao
    Espere e Clique no elemento                         xpath://button[@class="styles__StyledButton-yy7hgf-0 gdyjcQ"]
    Wait Until Page Contains                            Primeiros passos    30

    #Coletando tráfego e inserindo no arquivo .har
    ${har}=                                             Get Har As Json
    Create File                                         ${EXECDIR}${/}har/file.har     ${har}
    #Finaliza o servidor local
    Stop Local Server

    #Validar o request url de install no file.har
    
    #Validar no front o resto da instalação
    Espere e Clique no elemento                         xpath://button[@class="styles__StyledButton-yy7hgf-0 fZbYaO"]
    Sleep                                               5
    Capture Page Screenshot                                  
    Espere e Clique no elemento                         xpath://button[@class="styles__StyledButton-yy7hgf-0 eZGCxp"]
    Espere e Clique no elemento                         xpath://p[@class="initial__StyledLink-sc-71y4e-4 kUqtZn"]

    #Usando a função do ValidadorHar.py para buscar a URL de behaviour
    ${validador_har}=                                   Validar Har          ${id}          ${request_url} 
    Should Be Equal                                     ${validador_har}     ${true}        Request URL de instalação não encontrada no arquivo har
    #Apagando o arquivo .har
    Deletar Har

    Page Should Contain                                 Conclusão da instalação em até 30 minutos!

    