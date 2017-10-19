FROM golang:1.9.1-alpine
MAINTAINER Sergey Vasilenko <stalk@makeworld.ru>
RUN apk update \
  && apk add bash curl git glide \
  && go get -u github.com/golang/dep/... \
  && cd /go/src/github.com/golang/dep \
  && git checkout $(git tag | tail -n 1) \
  && go install github.com/golang/dep/... \
  && mv /go/bin/dep /usr/bin \
  # Cleanup
  && cd /go \
  && rm -rf /go/bin/* /go/src/*
WORKDIR /go