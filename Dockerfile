FROM golang:1.18.0-alpine3.15
LABEL maintainer="Alex Shamuel<theshamuel@gmail.com>"

ENV \
    GOOS=linux \
    GOARCH=amd64 \
    CGO_ENABLED=0 \
    GOLANGCI=1.45.2 \
    TZ=UTC

RUN \
    apk add --no-cache --update tzdata git bash curl && \
    rm -rf /var/cache/apk/*

#Install GolangCI linter
RUN \
    GO111MODULE=on go install github.com/golangci/golangci-lint/cmd/golangci-lint@v${GOLANGCI} && \
    golangci-lint --version
