FROM golang:alpine AS build

WORKDIR /app

COPY . ./

SHELL ["/bin/ash", "-eo", "pipefail", "-c"]

RUN apk add --no-cache curl git &&\
  curl -sL https://git.io/goreleaser | /bin/sh -s -- build --snapshot --single-target


FROM scratch

WORKDIR /app

COPY --from=build /app/dist/json-stats-exporter_linux_amd64_v1/* ./json-stats-exporter

ENTRYPOINT [ "./json-stats-exporter" ]
