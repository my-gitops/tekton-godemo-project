FROM golang:alpine AS builder

LABEL stage=gobuilder

ENV CGO_ENABLED 0
ENV GOOS linux
ENV GOPROXY https://goproxy.cn,direct

WORKDIR /opt

ADD go.mod .
ADD go.sum .

RUN go mod download

COPY . .

RUN go build -ldflags="-s -w" -o /opt/app /opt/main.go

FROM alpine
ENV TZ Asia/Shanghai

WORKDIR /opt
COPY --from=builder /opt/app /opt/app

CMD ["/opt/app"]