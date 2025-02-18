# Auto Generated Dockerfile
FROM ballerina/jvm-runtime:2.0

LABEL maintainer="dev@ballerina.io"
COPY http2_passthrough.jar /home/ballerina/jars/ 
RUN addgroup -g 10014 choreo && \
    adduser  --disabled-password  --no-create-home --uid 10014 --ingroup choreo choreouser

WORKDIR /home/ballerina

EXPOSE  9090
USER 10014

CMD java -Xdiag -cp "admin-http2_passthrough-0.1.0.jar:jars/*" 'admin.http2_passthrough.0.$_init' -Cballerina.http.traceLogConsole=true
