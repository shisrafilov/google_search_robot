*** Settings ***
Library   Browser
Library   custom_keyword.py

*** Variables ***
${QUERY}    automated testing

*** Keywords ***
Open Google
    New Browser    chromium    headless=false
    New Context    viewport={'width': 1536, 'height': 754}
    New Page    https://google.com

Send A Search Query
    Fill Text    //input[@name="q"]    ${QUERY}
    Keyboard Key    press    Enter

Assert That All Snippets Contain Query
    ${snippet_xpath}    Set Variable    //div[@data-header-feature="0"]
    @{SNIPPETS}    Get Elements    ${snippet_xpath}
    FOR    ${snippet}    IN    @{SNIPPETS}
        ${text}    Get Text    ${snippet}
        Log    ${text}
        Assert That Snippet Contains Query    ${text}
    END
    Set Suite Variable    @{SNIPPETS}

Open First Link
    Click    ${SNIPPETS}[0]

Take Screenshots Of All Occurrences
    @{elements}    Get Elements    text=${QUERY}
    FOR    ${element}    IN    @{elements}
        Take Screenshot    selector=${element}
    END
