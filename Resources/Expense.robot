*** Settings ***
Documentation     A native Robot Framework test suite that acts as a daily expense tracker.
...               Calculates totals, finds the highest category, evaluates budget tiers,
...               and writes a summary report file.
Library           DateTime
Library           OperatingSystem
Library           Collections

*** Variables ***
# 1. Dictionary variable storing categories and their respective amounts
&{DAILY_EXPENSES}    Food=450    Travel=150    Shopping=1200    Entertainment=300

# 2. List variable to explicitly drive the iteration order of the categories
@{CATEGORIES_LIST}   Food    Travel    Shopping    Entertainment

# Filepath for the generated report
${REPORT_FILE}       ${CURDIR}/Daily_Expense_Report.txt

*** Test Cases ***
Track Daily Expenses And Generate Report
    [Documentation]    Main execution flow to process daily expenses.

    # Initialize Tracking Variables
    ${total_expense}=    Set Variable    ${0}
    ${highest_amount}=   Set Variable    ${0}
    ${highest_category}=    Set Variable    None

    # 3. Iterate through expense categories using the list variable
    FOR    ${category}    IN    @{CATEGORIES_LIST}
        # Fetch the amount from the dictionary using the current list item as the key
        ${amount}=    Get From Dictionary    ${DAILY_EXPENSES}    ${category}

        # Convert to number to ensure safe mathematical operations
        ${amount_num}=    Convert To Number    ${amount}

        # Calculate Total Daily Expense
        ${total_expense}=    Evaluate    ${total_expense} + ${amount_num}

        # Calculate Highest Expense Category
        IF    ${amount_num} > ${highest_amount}
            ${highest_amount}=    Set Variable    ${amount_num}
            ${highest_category}=  Set Variable    ${category}
        END
    END

    # 4. Categorize daily spending based on thresholds
    ${spending_tier}=    Set Variable    UNKNOWN
    IF    ${total_expense} <= 500
        ${spending_tier}=    Set Variable    LOW
    ELSE IF    ${total_expense} > 500 and ${total_expense} <= 2000
        ${spending_tier}=    Set Variable    MEDIUM
    ELSE IF    ${total_expense} > 2000
        ${spending_tier}=    Set Variable    HIGH
    END

    # 5. Capture execution date and time using DateTime library
    ${current_time}=    Get Current Date    result_format=%Y-%m-%d %H:%M:%S

    # 6. Construct the readable expense summary text
    ${report_content}=    Catenate    SEPARATOR=\n
    ...    ==================================================
    ...    DAILY EXPENSE REPORT
    ...    ==================================================
    ...    Generated On       : ${current_time}
    ...    --------------------------------------------------
    ...    BREAKDOWN BY CATEGORY:
    ...    • Food             : $&{DAILY_EXPENSES}[Food]
    ...    • Travel           : $&{DAILY_EXPENSES}[Travel]
    ...    • Shopping         : $&{DAILY_EXPENSES}[Shopping]
    ...    • Entertainment    : $&{DAILY_EXPENSES}[Entertainment]
    ...    --------------------------------------------------
    ...    SUMMARY METRICS:
    ...    Total Spent        : $${total_expense}
    ...    Highest Category   : ${highest_category} ($${highest_amount})
    ...    Budget Alert Tier  : ${spending_tier}
    ...    ==================================================

    # 7. Create and write the report file using OperatingSystem keywords
    Create File    ${REPORT_FILE}    ${report_content}

    # Log to Console so results are instantly visible in terminal execution
    Log To Console    \n${report_content}
    Log To Console    Report successfully saved to: ${REPORT_FILE}