import ballerina/ai;
import ballerina/url;

# Fetches a summary of tourist attractions for a given country from Wikivoyage.
# + country - the name of the country to look up tourist attractions for
# + return - a text excerpt describing notable tourist attractions in the country, or an error if the lookup fails
@ai:AgentTool
isolated function getCountryAttractions(string country) returns string|error {
    string encodedTitle = check url:encode(country, "UTF-8");
    string path = string `/w/api.php?action=query&prop=extracts&exintro=true&explaintext=true&redirects=1&format=json&titles=${encodedTitle}`;
    WikivoyageExtractResponse response = check wikivoyageClient->get(path);
    WikivoyageQuery? query = response.query;
    if query is () {
        return string `No Wikivoyage article found for ${country}.`;
    }
    map<WikivoyagePage> pages = query.pages;
    string[] pageIds = pages.keys();
    if pageIds.length() == 0 {
        return string `No Wikivoyage article found for ${country}.`;
    }
    WikivoyagePage page = pages.get(pageIds[0]);
    string? extract = page.extract;
    if extract is () || extract.length() == 0 {
        return string `No attraction information found for ${country}.`;
    }
    return extract;
}
