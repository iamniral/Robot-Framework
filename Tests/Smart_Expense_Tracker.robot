*** Settings ***
Library           DateTime
Library           OperatingSystem
Library           Collections


*** Variables ***
&{DAILY_EXPENSES}    food=350    travel=120     shopping=900    entertainment=200

@{CATEGORIES_LIST}       food    travel    shopping    entertainment

${REPORT_FILE}       ${CURDIR}/Daily_Expense_Report.txt


*** Test Cases ***
Track Daily Expenses And Generate Report
    ${total_expense}=    Set Variable    ${0}
    ${highest_amount}=   Set Variable    ${0}
    ${highest_category}=    Set Variable    None



    FOR     ${Category}     IN    @{CATEGORIES_LIST}
            ${Amount}=   Get From Dictionary    ${DAILY_EXPENSES}   ${Category}

    ${Amount_num}=     Convert To Number    ${Amount}

# Calculate Total Expense
    ${total_expense}=   Evaluate    ${total_expense}  +  ${Amount_num}

# Calculate Highest Expense Category
    IF    ${Amount_num} > {highest_amount}
          ${highest_amount}=    Set Variable    ${Amount_num}
          ${highest_category}=  Set Variable    ${category}
          END
    END





