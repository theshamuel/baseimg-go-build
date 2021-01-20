FROM golang:1.15-alpine3.13
LABEL maintainer="Alex Shamuel<theshamuel@gmail.com>"

ENV \
    GOOS=linux \
    GOARCH=amd64 \
    CGO_ENABLED=0 \
    GOMETALINTER=3.0.0 \
    GOLANGCI=1.24.0 \
    TZ=UTC

RUN \
    apk add --no-cache --update tzdata git bash curl && \
    rm -rf /var/cache/apk/*

#Install Metalinter and other external deps
RUN \
    go get -u -v github.com/alecthomas/gometalinter && \
    cd /go/src/github.com/alecthomas/gometalinter && \
    git checkout v${GOMETALINTER} && \
    go install github.com/alecthomas/gometalinter && \
    gometalinter --install && \
    go get -u -v github.com/stretchr/testify

#Install GolangCI linter
RUN \
    GO111MODULE=on go get github.com/golangci/golangci-lint/cmd/golangci-lint@v${GOLANGCI} && \
    golangci-lint --version
