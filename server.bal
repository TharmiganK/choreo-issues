import ballerina/http;

service /api on new http:Listener(9091, socketConfig = {keepAlive: true}) {

    resource function get path() returns string {
        return "Hello, World!";
    }
}
