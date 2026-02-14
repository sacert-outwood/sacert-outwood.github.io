FROM golang:1.22-alpine AS builder

WORKDIR /app

COPY go.mod go.sum ./
RUN go mod download

COPY . .

RUN go build -o server main.go

FROM alpine:3.19

WORKDIR /app
COPY --from=builder /app/server .
COPY . .

EXPOSE 8080

ENV PORT=8080
ENV ROOT_DIR=/app

CMD ["./server"]
