FROM golang:1.21-alpine AS build

WORKDIR /app

COPY . ./
RUN go mod download

RUN go build -o /bin/app

FROM debian:buster-slim

COPY --from=build /bin/app /bin

EXPOSE 8080

CMD [ "/bin/app" ]