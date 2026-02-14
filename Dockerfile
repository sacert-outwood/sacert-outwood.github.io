FROM golang:1.22-alpine AS builder

WORKDIR /app
COPY . .

RUN go mod init static-server || true
RUN go mod tidy || true
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o server main.go

FROM alpine:3.19

WORKDIR /app
COPY --from=builder /app/server .
COPY . .

EXPOSE 8080

ENV PORT=8080
ENV ROOT_DIR=/app

CMD ["./server"]
