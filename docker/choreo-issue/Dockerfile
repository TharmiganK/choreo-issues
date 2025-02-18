# Auto Generated Dockerfile
FROM ballerina/jvm-runtime:2.0

LABEL maintainer="dev@ballerina.io"
COPY choreo_sse.jar /home/ballerina/jars/ 
RUN addgroup -g 10014 choreo && \
    adduser  --disabled-password  --no-create-home --uid 10014 --ingroup choreo choreouser

WORKDIR /home/ballerina

EXPOSE 9090
USER 10014

ENTRYPOINT ["java","-Xdiag","-cp","admin-choreo_sse-0.1.0.jar:jars/*","admin.choreo_sse.0.$_init","-Cballerina.http.traceLogConsole=true"]
