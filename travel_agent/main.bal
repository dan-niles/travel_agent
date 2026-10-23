import ballerina/ai;
import ballerina/http;
import ballerina/log;
import ballerinax/trigger.github;

listener ai:Listener travelAgentListener = new (listenOn = check http:getDefaultListener());

service /travel\-agent on travelAgentListener {
    resource function post chat(@http:Payload ai:ChatReqMessage request) returns ai:ChatRespMessage|error {
        string stringResult = check travelAgent.run(request.message, request.sessionId);
        return {message: stringResult};
    }
}

listener github:Listener githubListener = new ({webhookSecret: "test"}, 8090);

service github:IssuesService on githubListener {
    remote function onReopened(github:IssuesEvent payload) returns error? {
    }

    remote function onTransferred(github:IssuesEvent payload) returns error? {
    }

    remote function onUnpinned(github:IssuesEvent payload) returns error? {
    }

    remote function onAssigned(github:IssuesEvent payload) returns error? {
    }

    remote function onMilestoned(github:IssuesEvent payload) returns error? {
    }

    remote function onLabeled(github:IssuesEvent payload) returns error? {
    }

    remote function onOpened(github:IssuesEvent payload) returns error? {
    }

    remote function onPinned(github:IssuesEvent payload) returns error? {
    }

    remote function onTyped(github:IssuesEvent payload) returns error? {
    }

    remote function onEdited(github:IssuesEvent payload) returns error? {
    }

    remote function onUntyped(github:IssuesEvent payload) returns error? {
    }

    remote function onDemilestoned(github:IssuesEvent payload) returns error? {
    }

    remote function onLocked(github:IssuesEvent payload) returns error? {
    }

    remote function onUnassigned(github:IssuesEvent payload) returns error? {
        _ = start self.runAgentOnUnassigned(payload);
    }

    remote function onUnlocked(github:IssuesEvent payload) returns error? {
    }

    remote function onUnlabeled(github:IssuesEvent payload) returns error? {
    }

    remote function onClosed(github:IssuesEvent payload) returns error? {
    }

    remote function onDeleted(github:IssuesEvent payload) returns error? {
    }

    function runAgentOnUnassigned(github:IssuesEvent payload) {
        string|error result = travelAgent.run(string `Review this event and summarize what happened and what should be done next.

Event payload:
${payload.toJsonString()}`);
        if result is error {
            log:printError("Agent run failed", result);
            return;
        }
        // TODO: replace this with what should happen with the agent's answer
        log:printInfo("Agent result", result = result);
    }
}
