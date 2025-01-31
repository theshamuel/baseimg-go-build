FROM golang:1.23.5-alpine3.21

LABEL maintainer="Alex Shamuel<theshamuel@gmail.com>"

LABEL org.opencontainers.image.source https://github.com/theshamuel/baseimg-go-build

ENV \
    GOOS=linux \
    GOARCH=amd64 \
    CGO_ENABLED=0 \
    GOLANGCI=1.63.4 \
    TZ=UTC

RUN \
    apk add --no-cache --update tzdata git bash curl && \
    rm -rf /var/cache/apk/*

#Install GolangCI linter
RUN \
    GO111MODULE=on go install github.com/golangci/golangci-lint/cmd/golangci-lint@v${GOLANGCI} && \
    golangci-lint --version
