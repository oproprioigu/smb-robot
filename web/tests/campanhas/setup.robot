*** Settings ***
Library         SeleniumLibrary

*** Variables ***
${url}              https://loja-s.tray.com.br/adm/login.php 
${tempo}            15
#tempo = timeout padrão
${link_botao}       https://socialminer.com/ 
#link do botão das campanhas
${email_teste}      qa.smbtest@gmail.com
#e-mail que será enviado o e-mail de teste da campanha

*** Keywords ***
Nova sessão
    Open Browser                    ${url}     chrome

Encerra sessão
    Capture Page Screenshot
    Close Browser

Logar no aplicativo da Social Miner
    [Arguments]    ${loja}      ${usuario}      ${senha} 
    Maximize Browser Window
    Input Text                          id:loja                 ${loja}
    Input Text                          id:usuario              ${usuario}
    Input Text                          id:senha                ${senha}
    Click Element                       id:btn-submit
    Wait Until Element Contains         class:topbar__store-id  ${loja}         ${tempo}
    Click Element                       class:fe-menu
    #Esperando popup de feedback da Tray (Zendesk)
    Wait Until Element Is Visible       id:tracksale-iframe     30
    Select Frame                        id:tracksale-iframe
    Espere e Clique no elemento         xpath://a[@class="close"]
    Unselect Frame
    #Abre o menu lateral esquerdo
    Wait Until Element Contains         xpath://span[contains(text(),'Meus aplicativos')]      Meus aplicativos        ${tempo}
    Click Element                       xpath://span[contains(text(),'Meus aplicativos')]
    Click Element                       class:fe-menu
    #Fecha o menu lateral esquerdo > Estava dando conflito com o ifram por algum motivo
    Sleep                               2
    #Resolução temporária pro iframe
    Wait Until Element Is Visible       xpath://iframe[@id='centro']            ${tempo}
    Select Frame                        xpath://iframe[@id='centro']
    Wait Until Element Contains         xpath://h1[contains(text(),'Meus aplicativos')]        Meus aplicativos        ${tempo}
    #Esperar os aplicativos aparecerem na tela
    Wait Until Element Is Visible       xpath://a[contains(text(),'Acessar') and contains(@href,'socialminer')]         ${tempo}
    Click Link                          xpath://a[contains(text(),'Acessar') and contains(@href,'socialminer')]
    #O xpath acima foi inserido pois temos dois links iguais no iframe para acessar o Social Miner 
    #Mas só podemos acessar pelo botão Acessar já que o link Social Miner abre uma nova aba (saindo assim da Tray)

Rolar até o fim da página
    Execute JavaScript                  window.scrollTo(0, document.body.scrollHeight)

Espere e Clique no elemento
    [Arguments]     ${elemento}             
    Wait Until Element Is Visible       ${elemento}                    ${tempo}
    Scroll Element Into View            ${elemento}
    Click Element                       ${elemento}
Espere e Insira no elemento
    [Arguments]     ${elemento}         ${texto}
    Wait Until Element Is Visible       ${elemento}                    ${tempo}
    Scroll Element Into View            ${elemento}
    Input Text                          ${elemento}                    ${texto} 

Criar campanha do tipo e-mail
    [Arguments]     ${el_tipo_campanha}        ${el_audiencia_campanha}       ${nome_campanha}
    #Argumentos -> Elemento do tipo de campanha para clicar e elemento tipo de audiencia para clicar
    Wait Until Page Contains            Criar campanha                                                              ${tempo}                    
    Wait Until Element Is Visible       xpath://button[@class='styles__StyledButton-yy7hgf-0 fZbYaO']               ${tempo}
    Click Element                       xpath://button[@class='styles__StyledButton-yy7hgf-0 fZbYaO']
    #TODO - Pedir para incluir ID nesse elemento
    Espere e Clique no elemento         xpath://h2[@class='styles__Title-sc-1a03kpz-1 fmMrdD']
    #TODO - Pedir para incluir ID nesse elemento
    Espere e Clique no elemento         ${el_tipo_campanha}                           
    #TODO - Pedir para incluir ID nesse elemento
    Espere e Clique no elemento         ${el_audiencia_campanha}
    #TODO - Pedir para incluir ID nesse elemento
    Wait Until Element Is Visible       xpath://button[contains(text(),'Criar e-mail')]                             ${tempo}
    Scroll Element Into View            xpath://h3[contains(text(),'Disparo da campanha')]
    #Scrollando a tela para a barra de progresso da campanha não atrapalhar o click 
    Click Element                       xpath://button[contains(text(),'Criar e-mail')]  
    #TODO - Pedir para incluir ID nesse elemento
    Wait Until Element Is Visible       xpath://span[contains(text(),'Botão')]                                      ${tempo}
    Click Element                       xpath://span[contains(text(),'Botão')]
    #TODO - Pedir para incluir ID nesse elemento
    Espere e Insira no elemento         xpath://input[@class='styles__Input-rjrgfq-1 gdxDhc']                       ${link_botao}
    Espere e Clique no elemento         xpath://button[@class='styles__StyledButton-yy7hgf-0 lmjXfW']
    #TODO - Pedir para incluir ID nesse elemento
    Espere e Clique no elemento         xpath://button[@class='styles__StyledButton-yy7hgf-0 lmjXfW']
    #TODO - Pedir para incluir ID nesse elemento
    Espere e Insira no elemento         xpath://input[@class='styles__Input-rjrgfq-1 gdxDhc']                       ${nome_campanha}
    Espere e Insira no elemento         xpath://input[@class='styles__Input-rjrgfq-1 gdxDhc' and contains(@placeholder, 'john@socialminer.com')]                    ${email_teste}
    Wait Until Element Is Visible       xpath://button[contains(text(),'e-mail de teste')]                          ${tempo}
    Rolar até o fim da página
    Click Element                       xpath://button[contains(text(),'e-mail de teste')]
    Wait Until Page Contains            Você receberá um e-mail de teste em até 5 minutos
    Click Element                       xpath://div[@class='styles__CloseButtonContainer-ier3rq-3 bGsqn']
    #Scroll Element Into View            xpath://button[contains(text(),'Criar')]
    #Click Element                       xpath://button[contains(text(),'Criar')]
    Scroll Element Into View            xpath://button[@class="styles__StyledButton-yy7hgf-0 igryzJ"]
    Click Element                       xpath://button[@class="styles__StyledButton-yy7hgf-0 igryzJ"]
    Wait Until Element Is Visible       xpath://h3[@class='list-campaign__ModalSuccessTitle-sc-1387qit-12 cQZcAT']  ${tempo}
    Page Should Contain                 sucesso