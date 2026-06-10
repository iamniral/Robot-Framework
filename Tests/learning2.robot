*** Settings ***
Resource    ../Resources/resources.robot

*** Keywords ***


*** Variables ***

*** Test Cases ***
TEST
    Log My Specific Username & Password     ${DICTIONARY}[Username]     ${DICTIONARY}[Password]