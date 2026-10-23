import ballerina/ai;
import ballerina/http;
import ballerinax/ai.anthropic;

final http:Client wikivoyageClient = check new ("https://en.wikivoyage.org");
final anthropic:ModelProvider anthropicModelprovider = check new ("asdadsasd", "claude-opus-4-1-20250805");
final ai:InMemoryVectorStore aiInmemoryvectorstore = check new ();
final ai:Wso2EmbeddingProvider aiWso2embeddingprovider = check ai:getDefaultEmbeddingProvider();
final ai:VectorKnowledgeBase aiVectorknowledgebase = new (aiInmemoryvectorstore, aiWso2embeddingprovider, ai:AUTO);
