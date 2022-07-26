*** Settings ***
Resource        setup.robot
Test Setup      Nova sessão
Test Teardown   Encerra sessão

*** Variables ***
${loja}         954305
${usuario}      smploja4
${senha}        De211968?

*** Test Cases ***
Deve criar com sucesso uma campanha de e-mail autómatico de abandono no carrinho
    [tags]      teste                            
    Logar no aplicativo da Social Miner                 ${loja}     ${usuario}      ${senha}
    Criar campanha do tipo e-mail                       xpath://button[contains(text(),'automática')]       xpath://p[contains(text(),'Abandono')]          Abandono Teste     

Deve criar com sucesso uma campanha de e-mail autómatico de frequência
    [tags]      automatica                            
    Logar no aplicativo da Social Miner                 ${loja}     ${usuario}      ${senha}
    Criar campanha do tipo e-mail                       xpath://button[contains(text(),'automática')]       xpath://p[contains(text(),'Frequência')]        Frequencia Teste

Deve criar com sucesso uma campanha de e-mail autómatico de cadastro
    [tags]      automatica                              
    Logar no aplicativo da Social Miner                 ${loja}     ${usuario}      ${senha}
    Criar campanha do tipo e-mail                       xpath://button[contains(text(),'automática')]       xpath://p[contains(text(),'cadastros')]         Cadastro Teste

Deve criar com sucesso uma campanha de e-mail autómatico de resgate de inativos
    [tags]      automatica                              
    Logar no aplicativo da Social Miner                 ${loja}     ${usuario}      ${senha}
    Criar campanha do tipo e-mail                       xpath://button[contains(text(),'automática')]       xpath://p[contains(text(),'Inatividade')]      Resgate 2 Dias Teste

Deve criar com sucesso uma campanha de e-mail pontual de engajados
    [tags]      pontual
    Logar no aplicativo da Social Miner                 ${loja}     ${usuario}      ${senha}
    Criar campanha do tipo e-mail                       xpath://button[contains(text(),'pontual')]          xpath://p[contains(text(),'engajadas')]         Engajados Teste

Deve criar com sucesso uma campanha de e-mail pontual de inativos
    [tags]      pontual
    Logar no aplicativo da Social Miner                 ${loja}     ${usuario}      ${senha}
    Criar campanha do tipo e-mail                       xpath://button[contains(text(),'pontual')]          xpath://p[contains(text(),'inativas')]          Inativos Teste

Deve criar com sucesso uma campanha de e-mail pontual de ativos
    [tags]      pontual
    Logar no aplicativo da Social Miner                 ${loja}     ${usuario}      ${senha}
    Criar campanha do tipo e-mail                       xpath://button[contains(text(),'pontual')]          xpath://p[contains(text(),'ativas')]            Ativos Teste     
