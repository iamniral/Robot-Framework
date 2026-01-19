*** Settings ***
Library    AppiumLibrary
Resource   ../Resources/android-res.robot

*** Test Cases ***
Login
    Open Samsung Application
    Skip Instruction
    Allow Permission
    Signin with user    ${User1-Details}[email]     ${User1-Details}[password]
    Logout With User