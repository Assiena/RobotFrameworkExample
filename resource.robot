*** Settings ***
Documentation   A resource file with reusable keywords and variables
...
...             The system specific keywords created here form our own
...             domain specific language. They utilize keywords provided
...             by the imported  SeleniumLibrary
Library   SeleniumLibrary
Library    Collections
Library    XML

*** Variables ***

${user-name}    standard_user
${admin-name}    performance_glitch_user
${password}     something
${validpass}    secret_sauce
${error_mesg_login}   //*[@id="login_button_container"]/div/form/div[3]

*** Keywords ***
open the browser with the mortgage payment url
       Open Browser  https://www.saucedemo.com/  chrome
       Maximize Browser Window

Fill the login form
       [arguments]    ${user-name}     ${password} 
       Input Text    //*[@id="user-name"]    ${user-name} 
       Input Password    //*[@id="password"]    ${password}
       Click Button  //*[@id="login-button"]
       Sleep  4s
Fill the login details for Admin
       Input Text    //*[@id="user-name"]    ${admin-name} 
       Input Password    //*[@id="password"]    ${validpass} 
         Click Button  //*[@id="login-button"]
       Sleep  4s
wait until lement is located in my page
   [arguments]     ${element}
   Wait Until Element Is Visible    ${element}
   Sleep  5s
#wait until it checks and display error message
      #Wait Until Element Is Visible    ${error_mesg_login}
      #Sleep  5s
verify error message is correct
      ${result}=  Get Text    //*[@id="login_button_container"]/div/form/div[3]
 
      Should Be Equal As Strings   ${result}    Epic sadface: Username and password do not match any user in this service
verify card titles in the shop page
    @{clothes} =  Create List    Sauce Labs Backpack    Sauce Labs Bike Light      Sauce Labs Bolt T-Shirt     Sauce Labs Fleece Jacket    Sauce Labs Onesie     Test.allTheThings() T-Shirt (Red)
    ${elements} =  Get WebElements    css:.inventory_item_name
    @{actuallist} =   Create List
    FOR  ${element}  IN  @{elements}
    Log   ${element.text} 
    Append To List  ${actuallist}       ${element.text}
    END
    Lists Should Be Equal    ${clothes}    ${actuallist}
    Sleep  3s
 select the card
      [Arguments]    ${cardname}
      ${elements}=  Get WebElements    css:.inventory_item_name
      ${index}=  Set Variable  1
      FOR    ${element}    IN    @{elements}
         Exit For loop if   '${cardname}'=='${element.text}'
          
         ${index}=  Evaluate   ${index}+1
          
      END
     Click Button   xpath:(//*[@class="pricebar"])[${index}]/button
      Sleep  7s
Select the link of child window
       Wait Until Element Is Visible   //*[@id="react-burger-menu-btn"]
       Click Element   //*[@id="react-burger-menu-btn"]
       Wait Until Element Is Enabled   //*[@id="about_sidebar_link"]
       Run Keyword And Ignore Error  ClickingAboutLink
       Run Keyword And Ignore Error  ClickingLinkHeader
     
        Run Keyword And Ignore Error   ClickingLink
     # Press Keys      //*[@id="shopping_cart_container"]/a      CTRL+T
      Sleep   6s
ClickingAboutLink
       Click Element    //*[@id="about_sidebar_link"]
       Sleep  5s
ClickingLinkHeader
       Click Element    xpath://*[@id="headerMainNav"]/div/nav/ul/li[1]/ul[2]/li[4]/div[1]/div/a
       Sleep  5s
ClickingLink
      Click Element    //*[@id="headerMainNav"]/div/nav/ul/li[1]/ul[2]/li[4]/div[2]/div/div/div/ul/li[2]/div/ul/li/div/ul/li[2]/div/ul/li/ul/li[2]/a
       Sleep  5s
 Verify the user is switched to child window 
           Sleep  10s
           Go To    https://www.selenium.dev/
           SeleniumLibrary.Element Text Should Be    css:h1   Selenium automates browsers. That's it!
 Close Browser Session
     Close Browser

 Switch to parent window at the moment 
          Sleep  5s
          go to  https://saucelabs.com/
          Title Should Be   Cross Browser Testing, Selenium Testing, Mobile Testing | Sauce Labs

 add items to cart and check out
       Click Element   //*[@id="shopping_cart_container"]/a\
       Sleep  5s
       Click Button   //*[@id="checkout"]
       Sleep  5s
       Input Text    //*[@id="first-name"]    Mila
       Input Text    //*[@id="last-name"]    Marinova
       Input Text    //*[@id="postal-code"]   1111
        Sleep  5s
       Click Button   //*[@id="continue"]
       Wait Until Element Is Enabled  //*[@id="finish"]
        Sleep  5s
       Click Button   //*[@id="finish"]
              