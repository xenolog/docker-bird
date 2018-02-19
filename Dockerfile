FROM golang:1.10-alpine
MAINTAINER Sergey Vasilenko <stalk@makeworld.ru>
#  && apk add curl git glide tcpdump make gcc musl-dev \
RUN apk update \
  && apk add curl git tcpdump make gcc musl-dev \
  && go get -u github.com/golang/dep/... \
  && cd /go/src/github.com/golang/dep \
  && git checkout $(git tag | tail -n 1) \
  && go install ./... \
  && mv /go/bin/dep /usr/bin \
  # Cleanup
  && cd /go \
  && rm -rf /go/bin/* /go/src/* /go/pkg/* \
  && rm -rf /var/cache/apk/*
ENV GOPATH /go
WORKDIR /go
ENTRYPOINT sh
# should be latest for proper versioning
RUN date +%Y%m%d-%H:%M:%S-%Z > /buildinfo.txt
