FROM golang:alpine AS builder

WORKDIR /app

COPY . /app

RUN CGO_ENABLED=0 go build -a -trimpath -tags netgo -ldflags '-s -w -extldflags "-static"' -o ./lbhello ./

FROM scratch

EXPOSE 8080

CMD ["/lbhello"]

COPY --from=builder /app/lbhello /
