package main

import (
    "log"
    "net"
    "net/http"
    "net/http/httputil"
    "net/url"
    "time"
)

func main() {
    target := "http://localhost:9091" // The backend server to proxy to
    url, err := url.Parse(target)
    if err != nil {
        log.Fatalf("Error parsing URL: %v", err)
    }

    // Custom Transport with TCP keep-alive enabled
    transport := &http.Transport{
        Proxy: http.ProxyFromEnvironment,
        DialContext: (&net.Dialer{
            Timeout:   30 * time.Second,
            KeepAlive: 5 * time.Second, // Enable TCP keep-alive with a 30-second interval
        }).DialContext,
        MaxIdleConns:          100,
        IdleConnTimeout:       90 * time.Second,
        TLSHandshakeTimeout:   10 * time.Second,
        ExpectContinueTimeout: 1 * time.Second,
    }

    proxy := httputil.NewSingleHostReverseProxy(url)
    proxy.Transport = transport // Use custom transport in reverse proxy

    http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
        r.Host = url.Host
        proxy.ServeHTTP(w, r)
    })

    log.Println("Starting reverse proxy on port 8080 with TCP keep-alive...")
    err = http.ListenAndServe(":8080", nil)
    if err != nil {
        log.Fatalf("Error starting server: %v", err)
    }
}
