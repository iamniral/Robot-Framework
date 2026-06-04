*** Settings ***


*** Variables ***
${Password}     Vasupujy@3
@{LIST}    Test1    Test2    Test3
&{DICTIONARY}   Username=testuser   Password=passdemo
&{DICTIONARY2}   Username=testuser2   Password=passdemo

*** Keywords ***
Log My Username
    log    ${DICTIONARY}[Username]

Log My PASSWORD
    log    ${DICTIONARY}[Password]

Log My Username & PASSWORD
    Log My Username
    Log My PASSWORD

Log My Specific Username
    [Arguments]    ${USERNAME}
    Log            ${USERNAME}

Log My Specific Username & Password
    [Arguments]    ${USERNAME}  ${PASSWORD}
    Log     ${USERNAME}
    Log     ${PASSWORD}
