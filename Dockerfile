FROM golang:1.11-alpine
MAINTAINER Sergey Vasilenko <stalk@makeworld.ru>
#  && apk add curl git glide tcpdump tshark make gcc musl-dev \
RUN apk update && apk add curl git tcpdump vim make gcc musl-dev \
  && rm -rf /var/cache/apk/*
  # install golang tooling
RUN go get -u github.com/golang/dep/... \
  && cd /go/src/github.com/golang/dep \
  && git checkout $(git tag | tail -n 1) \
  && go install ./... \
  && mv /go/bin/dep /usr/bin \
  # install glide
  && go get -u github.com/Masterminds/glide/... \
  && cd /go/src/github.com/Masterminds/glide \
  && git checkout $(git tag | tail -n 1) \
  && go install ./... \
  && mv /go/bin/glide /usr/bin \
  # Cleanup go tools
  && cd /go \
  && rm -rf /go/bin/* /go/src/* /go/pkg/*
#ENV GOPATH /go
WORKDIR /go
ENTRYPOINT sh
# should be latest for proper versioning
RUN date +%Y%m%d-%H:%M:%S-%Z > /buildinfo.txt
