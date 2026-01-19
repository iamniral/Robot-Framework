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
${Permission-While-Allow}       //*[contains(@text,"While using the app")]
${Permission-Allow}             //android.widget.Button[@resource-id="com.android.permissioncontroller:id/permission_allow_button"]

#*** Home Screen ***
${Home-SignIn-Button}            id=com.samsung.android.oneconnect:id/signin_btn
${Home-Title}                   //android.widget.TextView[@resource-id="com.samsung.android.oneconnect:id/title"]
${Home-Menu-Button}             //android.widget.TextView[@resource-id="com.samsung.android.oneconnect:id/navigation_bar_item_small_label_view" and @text="Menu"]
${Home-Message-Description}     //android.widget.TextView[@resource-id="com.samsung.android.oneconnect:id/message_description"]

#*** SignIn Screen ***
${SignIn-Email-Field}            //android.widget.EditText[@resource-id="iptLgnPlnID"]
${SignIn-Next}                   //*[contains(@text,"Next")]
${SignIn-Password-Field}         //android.widget.EditText[@resource-id="iptLgnPlnPD"]
${SignIn-Button}                 //android.widget.Button[@resource-id="signInButton"]

#*** Menu Screen ***
${Menu-Settings-Button}         //android.widget.ImageButton[@content-desc="Settings"]

#*** Samsung Account Screen ***
${Account-Signout-Button}       id=com.samsung.android.oneconnect:id/sign_out_btn
${Account-Sync-Signout-Button}      //android.widget.Button[@resource-id="signOut"]

#*** Settings ***
${Settings-Samsung-Account}      //android.widget.TextView[@resource-id="android:id/title" and @text="Samsung account"]
${Setting-SmartThins-Settings-Title}        //android.widget.TextView[@text="SmartThings settings"]

*** Keywords ***

Open Samsung Application
    Open Application        http://127.0.0.1:4723    platformName=Android    deviceName=emulator-5554    appPackage=com.samsung.android.oneconnect   appActivity=com.samsung.android.oneconnect.ui.SCMainActivity   automationName=UiAutomator2

Skip Instruction
    Click Element    ${Instruction-Continue-Button}
    Click Element    ${Instruction-More-Button}
    Click Element    ${Instruction-Continue-Button1}
    Wait Until Element Is Visible       ${Instruction-Skip-Button}
    Click Element    ${Instruction-Skip-Button}

Allow Permission
    Wait Until Element Is Visible    ${Permission-While-Allow}
    Click Element    ${Permission-While-Allow}
    Wait Until Element Is Visible    ${Permission-Allow}
    Click Element    ${Permission-Allow}
    Wait Until Element Is Visible    ${Permission-Allow}
    Click Element    ${Permission-Allow}

Signin with user
    [Arguments]    ${EMAIL}     ${PASSWORD}
    Navigate To Signin Screen
    Input User Email        ${EMAIL}
    Input User Password     ${PASSWORD}
    Submit Login
    Verify Login is Successfull

Navigate To Signin Screen
    Wait Until Element Is Visible       ${Home-SignIn-Button}
    Click Element    ${Home-SignIn-Button}

Input User Email
    [Arguments]    ${EMAIL}
    Wait Until Element Is Visible    ${SignIn-Email-Field}
    Input Text       ${SignIn-Email-Field}      ${EMAIL}
    Click Element    ${SignIn-Next}

Input User Password
    [Arguments]    ${PASSWORD}
    Wait Until Element Is Visible    ${SignIn-Password-Field}
    Input Text       ${SignIn-Password-Field}   ${PASSWORD}

Submit Login
        Click Element    ${SignIn-Button}

Verify Login is Successfull
    Wait Until Element Is Visible       ${Home-Message-Description}

Logout With User
    Go Menu page
    Click on Settings button
    Click on Samsung Account
    Click on Signout button
    Verify Logout is Successful

Go Menu page
    Click Element       ${Menu-Settings-Button}

Click on Settings button
    Click Element       ${Menu-Settings-Button}

Click on Samsung Account
    Click Element       ${Settings-Samsung-Account}

Click on Signout button
    Click Element       ${Account-Signout-Button}
    Wait Until Element Is Visible   ${Account-Sync-Signout-Button}
    Click Element       ${Account-Sync-Signout-Button}

Verify Logout is Successful
    Wait Until Element Is Visible       ${Setting-SmartThins-Settings-Title}



