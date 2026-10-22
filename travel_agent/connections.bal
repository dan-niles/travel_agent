import ballerina/http;

final http:Client wikivoyageClient = check new ("https://en.wikivoyage.org");
