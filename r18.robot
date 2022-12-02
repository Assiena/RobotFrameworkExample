*** Settings ***
Library  SeleniumLibrary
Documentation  To validate the login form
Test Setup    open the browser with the mortgage payment url
Test Teardown  Close Browser Session  
Suite Setup
Suite Teardown
Resource  resource.robot

*** Test Cases ***  
Validate Unsuccessfull login
      
      Fill the login form   ${user-name}    ${password}
       wait until lement is located in my page    ${error_mesg_login}
      verify error message is correct
Validate Cards display in the shopping page
      Fill the login form  ${user-name}  ${validpass}
      wait until lement is located in my page   //*[@id="react-burger-menu-btn"]
      verify card titles in the shop page
       select the card    Sauce Labs Backpack
       add items to cart and check out
Select The form and navigate to child window 
     Fill the login details for Admin 
     wait until lement is located in my page   //*[@id="react-burger-menu-btn"]

Validate Child window functionality
       Fill the login form  ${user-name}  ${validpass}
       wait until lement is located in my page   //*[@id="react-burger-menu-btn"]
        Select the link of child window
        Verify the user is switched to child window
        Switch to parent window at the moment 

