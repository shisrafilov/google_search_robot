*** Settings ***
Resource    keywords.resource

*** Test Cases ***
Google Search
    Open Google
    Send A Search Query
    Assert That All Snippets Contain Query
    Open First Link
    Take Screenshots Of All Occurrences
