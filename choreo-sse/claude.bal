import ballerina/http;
import ballerina/io;

final http:Client clientEp1 = check new ("https://api.anthropic.com", httpVersion = http:HTTP_1_1);
final http:Client clientEp2 = check new ("https://api.anthropic.com");
final http:Client clientEp3 = check new ("https://api.anthropic.com", socketConfig = {keepAlive: true});

configurable string apiKey = ?;

listener http:Listener listenerEP = new (9090);

service /api on listenerEP {
    isolated resource function get v1() returns stream<http:SseEvent, error?>|error {
        io:println("started resource execution");
        json req = {
            "model": "claude-2",
            "prompt": "\n\nHuman: Write a 800 word essay!\n\nAssistant:",
            "max_tokens_to_sample": 1000,
            "stream": true
        };
        return clientEp1->/v1/complete.post(req, headers = {"x-api-key": apiKey, "anthropic-version": "2023-06-01"});
    }

    isolated resource function get v2() returns stream<http:SseEvent, error?>|error {
        io:println("started resource execution");
        json req = {
            "model": "claude-2",
            "prompt": "\n\nHuman: Write a 800 word essay!\n\nAssistant:",
            "max_tokens_to_sample": 1000,
            "stream": true
        };
        return clientEp2->/v1/complete.post(req, headers = {"x-api-key": apiKey, "anthropic-version": "2023-06-01"});
    }

    isolated resource function get v3() returns stream<http:SseEvent, error?>|error {
        io:println("started resource execution");
        json req = {
            "model": "claude-2",
            "prompt": "\n\nHuman: Write a 800 word essay!\n\nAssistant:",
            "max_tokens_to_sample": 1000,
            "stream": true
        };
        return clientEp3->/v1/complete.post(req, headers = {"x-api-key": apiKey, "anthropic-version": "2023-06-01"});
    }
}
