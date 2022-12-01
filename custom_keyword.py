from robot.api.deco import keyword
import re


@keyword('Assert That Snippet Contains Query')
def assert_that_snippet_contains_query(snippet):
    # due to little differences in the search results, we have to use regexp
    pattern = r"automat(?:ed?|ion)|tes(?:t?|ing)"
    found_words = re.findall(pattern, snippet, flags=re.IGNORECASE)
    assert len(found_words) >= 2, "Not all required words are found!"
