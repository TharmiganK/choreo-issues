import ballerina/http;

final http:Client echoClient = check new ("https://echo.free.beeceptor.com");

service / on new http:Listener(9090) {
    resource function get greeting(string? name) returns string|error {
        if name is () {
            return error("name should not be empty!");
        }
        return echoClient->/post.post(string `Hello, ${name}`);
    }
}
