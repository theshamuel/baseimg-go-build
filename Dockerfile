FROM golang:1.12-alpine
LABEL maintainer="Alex Shamuel<theshamuel@gmail.com>"

ENV \
    GOOS=linux \
    GOARCH=amd64 \
    CGO_ENABLED=0 \
    GOMETALINTER=3.0.0 \
    GOLANGCI=1.17.1

RUN \
    apk add --no-cache --update tzdata git bash curl && \
    ln -s /usr/share/zoneinfo/Etc/UTC /etc/localtime && \
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