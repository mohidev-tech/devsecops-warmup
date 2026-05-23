# syntax=docker/dockerfile:1.7

FROM golang:1.22-alpine AS build
WORKDIR /src
RUN adduser -D -u 10001 app
COPY go.mod ./
RUN go mod download
COPY . .
RUN CGO_ENABLED=0 GOOS=linux GOFLAGS="-trimpath" \
    go build -ldflags="-s -w" -o /out/server ./cmd/server

FROM gcr.io/distroless/static-debian12:nonroot
COPY --from=build /out/server /server
USER nonroot:nonroot
EXPOSE 8080
ENTRYPOINT ["/server"]
