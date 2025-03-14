FROM public.ecr.aws/docker/library/golang:alpine3.21 AS builder

WORKDIR /app
COPY . .

RUN go build "--ldflags=-s -w" -o ./json-stats-exporter -v main.go

FROM scratch

LABEL org.opencontainers.image.source="https://github.com/MGSousa/json-stats-exporter"

WORKDIR /app
COPY --from=builder --chmod=775 /app/json-stats-exporter /bin/

ENTRYPOINT [ "/bin/json-stats-exporter" ]
