# build stage
ARG GOLANG_VERSION=1.12
FROM golang:$GOLANG_VERSION AS build-env
RUN mkdir -p /go/src/github.com/jasonrichardsmith/mwcexample
ENV GO111MODULE=on
WORKDIR /go/src/github.com/jasonrichardsmith/mwcexample
COPY . .
RUN CGO_ENABLED=0 GOOS=linux go build -a -gcflags 'all=-N -l' -ldflags '-extldflags "-static"' -o webhook
ENTRYPOINT ["/go/src/github.com/jasonrichardsmith/mwcexample/webhook"]

#FROM alpine:latest

#COPY --from=build-env /go/src/github.com/jasonrichardsmith/mwcexample/webhook .
#ENTRYPOINT ["/webhook"]
