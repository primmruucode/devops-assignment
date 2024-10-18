FROM golang:1.20-alpine AS builder

WORKDIR /app

COPY go.mod ./
RUN go mod download

COPY main.go .

RUN GOOS=linux GOARCH=amd64 go build -o hello-api

FROM alpine:latest

WORKDIR /app

COPY --from=builder /app/hello-api .

EXPOSE 8080

CMD ["./hello-api"]
