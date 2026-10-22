// Response types for the Wikivoyage MediaWiki REST API (action=query, prop=extracts).
type WikivoyagePage record {
    string title;
    string extract?;
};

type WikivoyageQuery record {
    map<WikivoyagePage> pages;
};

type WikivoyageExtractResponse record {
    WikivoyageQuery query?;
};
