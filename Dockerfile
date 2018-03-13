FROM golang:1.10-alpine
MAINTAINER Sergey Vasilenko <stalk@makeworld.ru>
#  && apk add curl git glide tcpdump tshark make gcc musl-dev \
RUN apk update \
  && apk add curl git tcpdump vim make gcc musl-dev \
  # install dep
  && go get -u github.com/golang/dep/... \
  && cd /go/src/github.com/golang/dep \
  && git checkout $(git tag | tail -n 1) \
  && go install ./... \
  && mv /go/bin/dep /usr/bin \
  # install vgo
  && go get -u golang.org/x/vgo/... \
  && cd /go/src/golang.org/x/vgo \
  && go install ./... \
  && mv /go/bin/vgo /usr/bin \
  # Cleanup
  && cd /go \
  && rm -rf /go/bin/* /go/src/* /go/pkg/* \
  && rm -rf /var/cache/apk/*
ENV GOPATH /go
WORKDIR /go
ENTRYPOINT sh
# should be latest for proper versioning
RUN date +%Y%m%d-%H:%M:%S-%Z > /buildinfo.txt
