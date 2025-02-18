# Auto Generated Dockerfile
FROM ballerina/jvm-runtime:2.0

LABEL maintainer="dev@ballerina.io"
COPY http2_passthrough.jar /home/ballerina/jars/ 
RUN addgroup troupe \
    && adduser -S -s /bin/bash -g 'ballerina' -G troupe -D ballerina \
    && apk add --update --no-cache bash \
    && rm -rf /var/cache/apk/*

WORKDIR /home/ballerina

EXPOSE  9090
USER ballerina

CMD java -Xdiag -cp "admin-http2_passthrough-0.1.0.jar:jars/*" 'admin.http2_passthrough.0.$_init' -Cballerina.http.traceLogConsole=true
