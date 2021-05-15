FROM golang:1.16-alpine3.13
LABEL maintainer="Alex Shamuel<theshamuel@gmail.com>"

ENV \
    GOOS=linux \
    GOARCH=amd64 \
    CGO_ENABLED=0 \
    GOMETALINTER=3.0.0 \
    GOLANGCI=1.35.2 \
    TZ=UTC

RUN \
    apk add --no-cache --update tzdata git bash curl && \
    rm -rf /var/cache/apk/*

#Install GolangCI linter
RUN \
    GO111MODULE=on go get github.com/golangci/golangci-lint/cmd/golangci-lint@v${GOLANGCI} && \
    golangci-lint --version
