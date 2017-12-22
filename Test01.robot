*** Settings ***
Library           Selenium2Library
Library           DatabaseLibrary

*** Variables ***
${Browser}        Firefox
${SiteUrl}        http://localhost:8181/WebProjectTest02/add-car.html
${Delay}          5s
${Brand}          Chevrolet
${Type}           Celta
${Year}           2016
${Port}           1433
${Username}       root
${DatabaseHost}    localhost
${Password}       admin

*** Test Cases ***
BuyGasCarTest
    Open Browser to the First Page
    Enter Brand
    Enter Type
    Select From List By Value    xpath=.//select    ${Year}
    Select Fuel
    Select Market
    Click Save
    Sleep    ${Delay}
    ${Message}    Get Text    xpath=html/body
    Should Be Equal    ${Message}    Car ${Brand} ${Type} ${Year} gasoline to buy added successful    Test Case Passed
    [Teardown]    Close Browser

BuyGasCar_MySqlTest
    Open Browser to the First Page
    Enter Brand
    Enter Type
    Select From List By Value    xpath=.//select    ${Year}
    Select Fuel
    Select Market
    Click Save
    Sleep    ${Delay}
    ${Message}    Get Text    xpath=html/body
    Should Be Equal    ${Message}    Car ${Brand} ${Type} ${Year} gasoline to buy added successful
    Connect to Database    pymssql    database02    ${Username}    ${Password}    ${DatabaseHost}    ${Port}
    @{QueryResult}    Query    select * from cars
    Log    @{QueryResult}
    Disconnect From Database
    [Teardown]    Close Browser

*** Keywords ***
Open Browser to the First Page
    open browser    ${SiteUrl}    ${Browser}
    Maximize Browser Window

Enter Brand
    Wait Until Element Is Visible    xpath=.//input[@name='brand']
    Input Text    xpath=.//input[@name='brand']    ${Brand}

Enter Type
    Wait Until Element Is Visible    xpath=.//input[@name='type']
    Input Text    xpath=.//input[@name='type']    ${Type}

Select Fuel
    Wait Until Element Is Visible    xpath=.//input[@value='gasoline']
    Click Element    xpath=.//input[@value='gasoline']

Select Market
    Wait Until Element Is Visible    xpath=.//input[@value='buy']
    Click Element    xpath=.//input[@value='buy']

Click Save
    Wait Until Element Is Visible    xpath=.//input[@type='submit']
    Click Button    xpath=.//input[@type='submit']
