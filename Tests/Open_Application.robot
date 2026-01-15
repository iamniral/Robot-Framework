*** Settings ***
Library    AppiumLibrary
Resource   ../Resources/password.robot

*** Variables ***

#*** Test Variable ***
&{User1-Details}        email=iamniralshah@gmail.com        password=${Password}

#*** Instruction Screen ***
${Instruction-Continue-Button}   id=com.samsung.android.oneconnect:id/intro_allow_button
${Instruction-More-Button}       com.samsung.android.oneconnect:id/global_permission_allow_button
${Instruction-Continue-Button1}  //android.widget.Button[@resource-id="com.samsung.android.oneconnect:id/global_permission_allow_button"]
${Instruction-Skip-Button}       id=com.samsung.android.oneconnect:id/cancel
${Instruction-Start-Button}      //android.widget.Button[@text = "Start SmartThings"]

#*** App Permission ***
${Permission-While-Allow}        //*[contains(@text,"While using the app")]
${Permission-Allow}              //android.widget.Button[@resource-id="com.android.permissioncontroller:id/permission_allow_button"]

#*** Home Screen ***
${Home-SignIn-Button}            id=com.samsung.android.oneconnect:id/signin_btn

#*** SignIn Screen ***
${SignIn-Email-Field}           //android.widget.EditText[@resource-id="iptLgnPlnID"]
${SignIn-Next}                   //*[contains(@text,"Next")]
${SignIn-Password-Field}         //android.widget.EditText[@resource-id="iptLgnPlnPD"]
${SignIn-Button}                 //android.widget.Button[@resource-id="signInButton"]


*** Test Cases ***
Open_Application
    Open Application        http://127.0.0.1:4723    platformName=Android    deviceName=emulator-5554    appPackage=com.samsung.android.oneconnect   appActivity=com.samsung.android.oneconnect.ui.SCMainActivity   automationName=UiAutomator2
    Click Element    ${Instruction-Continue-Button}
    Click Element    ${Instruction-More-Button}
    Click Element    ${Instruction-Continue-Button1}
    Click Element    ${Instruction-Skip-Button}
    Wait Until Element Is Visible    ${Permission-While-Allow}
    Click Element    ${Permission-While-Allow}
    Wait Until Element Is Visible    ${Permission-Allow}
    Click Element    ${Permission-Allow}
    Wait Until Element Is Visible    ${Permission-Allow}
    Click Element    ${Permission-Allow}
    Wait Until Element Is Visible       ${Home-SignIn-Button}
    Click Element    ${Home-SignIn-Button}
    Wait Until Element Is Visible    ${SignIn-Email-Field}
    Input Text       ${SignIn-Email-Field}      ${User1-Details}[email]
    Click Element    ${SignIn-Next}
    Wait Until Element Is Visible    ${SignIn-Password-Field}
    Input Text       ${SignIn-Password-Field}   ${User1-Details}[password]
    Click Element    ${SignIn-Button}