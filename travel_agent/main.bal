import ballerina/ai;
import ballerina/http;

listener ai:Listener travelAgentListener = new (listenOn = check http:getDefaultListener());

service /travel\-agent on travelAgentListener {
    resource function post chat(@http:Payload ai:ChatReqMessage request) returns ai:ChatRespMessage|error {
        string stringResult = check travelAgent.run(request.message, request.sessionId);
        return {message: stringResult};
    }
}
