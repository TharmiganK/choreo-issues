import ballerina/http;

configurable int port = 9090;

final http:Client echoClient = check new ("https://echo.free.beeceptor.com");

service / on new http:Listener(port) {
    resource function post greeting(@http:Payload json payload) returns http:Response|error {
        return echoClient->/post.post(payload);
    }
}
