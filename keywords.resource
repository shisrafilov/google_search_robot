*** Settings ***
Library   Browser

*** Variables ***
${QUERY}    manual testing

*** Keywords ***
Open Google
    New Browser    chromium    headless=false
    New Context    viewport={'width': 1536, 'height': 754}
    New Page    https://google.com

Send A Search Query
    Fill Text    //input[@name="q"]    ${QUERY}
    Keyboard Key    press    Enter

Assert That All Snippets Contain Query
    ${snippet_xpath}    Set Variable    //div[@class="kvH3mc BToiNc UK95Uc"]
    @{SNIPPETS}    Get Elements    ${snippet_xpath}
    FOR    ${snippet}    IN    @{SNIPPETS}
        ${text}    Get Text    ${snippet}
        Log    ${text}
        Should Contain    ${text}    ${QUERY}    ignore_case=True
    END
    Set Suite Variable    @{SNIPPETS}

Open First Link
    Click    ${SNIPPETS}[0]//h3

Take Screenshots Of All Occurrences
    @{elements}    Get Elements    text=${QUERY}
    FOR    ${element}    IN    @{elements}
        Take Screenshot    selector=${element}
    END
