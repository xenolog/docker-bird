FROM golang:1.9.2-alpine
MAINTAINER Sergey Vasilenko <stalk@makeworld.ru>
RUN apk update \
  && apk --no-cache add curl git glide tcpdump make gcc musl-dev \
  && go get -u github.com/golang/dep/... \
  && cd /go/src/github.com/golang/dep \
  && git checkout $(git tag | tail -n 1) \
  && go install github.com/golang/dep/... \
  && mv /go/bin/dep /usr/bin \
  # Cleanup
  && cd /go \
  && rm -rf /go/bin/* /go/src/* \
  && rm -rf /var/cache/apk/*
ENV GOPATH /go
WORKDIR /go
ENTRYPOINT sh