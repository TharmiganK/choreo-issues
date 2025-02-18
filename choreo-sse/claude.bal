import ballerina/http;
import ballerina/io;

final http:Client clientEp = check new ("https://api.anthropic.com", poolConfig = {minEvictableIdleTime: 180, timeBetweenEvictionRuns: 60});

configurable string apiKey = ?;

service /api on new http:Listener(9090) {

    isolated resource function get result() returns stream<http:SseEvent, error?>|error {
        io:println("started resource execution");
        json req = {
            "model": "claude-2",
            "prompt": "\n\nHuman: Write a 800 word essay!\n\nAssistant:",
            "max_tokens_to_sample": 1000,
            "stream": true
        };
        return clientEp->/v1/complete.post(req, headers = {"x-api-key": apiKey, "anthropic-version": "2023-06-01"});
    }

    isolated resource function get models() returns json|error {
        return clientEp->/v1/models.get(headers = {"x-api-key": apiKey, "anthropic-version": "2023-06-01"});
    }
}
