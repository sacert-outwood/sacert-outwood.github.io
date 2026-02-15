FROM golang:1.24-alpine AS builder
WORKDIR /app
COPY . .
RUN go mod download
RUN go build -o server main.go
FROM alpine:3.19
WORKDIR /app
COPY --from=builder /app/server .
COPY . .
EXPOSE 8080
ENV PORT=8080
ENV ROOT_DIR=/app
CMD ["./server"]
