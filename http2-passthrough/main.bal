import ballerina/http;

final http:Client echoClient = check new ("https://echo.free.beeceptor.com");

service / on new http:Listener(9090) {
    resource function post greeting(@http:Payload json payload) returns http:Response|error {
        return echoClient->/post.post(payload);
    }
}
