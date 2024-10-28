import ballerina/http;
import ballerina/io;

final http:Client clientEp = check new ("https://api.anthropic.com");
configurable string apiKey = ?;

type Request record {|
    string name;
|};

service on new http:Listener(9090) {
    isolated resource function post .(Request reques) returns stream<http:SseEvent, error?>|error {
        io:println("Request from user", reques);
        json req = {
            "model": "claude-2",
            "prompt": "\n\nHuman: Write a 800 word essay!\n\nAssistant:",
            "max_tokens_to_sample": 1000,
            "stream": true
        };
        stream<http:SseEvent, error?> events = check clientEp->/v1/complete.post(req, headers = {"x-api-key": apiKey, "anthropic-version": "2023-06-01"});
        return events;
    }
}
