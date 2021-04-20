FROM golang:1.16.2 AS builder
WORKDIR /usr/local/go/src/ral
COPY go.mod ./
RUN go mod download
COPY main.go ./
RUN CGO_ENABLED=0 go build -ldflags '-extldflags "-static"' -o /ral .
RUN chmod +x /ral

FROM scratch
COPY --from=builder /ral .
ENTRYPOINT ["/ral"]