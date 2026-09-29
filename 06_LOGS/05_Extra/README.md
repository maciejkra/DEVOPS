# Docker Compose Demo

Demo stawia docker-compose'em kompletny stack z przykladowa aplikacja (TNS):
Grafana, Prometheus, Loki i Tempo. Datasource'y i linki miedzy nimi
(logi <-> trace'y <-> metryki) sa juz skonfigurowane przez provisioning.

## 1. Zainstaluj plugin Loki (jednorazowo na hoscie)

Tag pluginu jest per-architektura. Wybierz wg swojego procesora:

```sh
# Apple Silicon (M1/M2/M3...) / ARM:
docker plugin install grafana/loki-docker-driver:3.7.8-arm64 --alias loki --grant-all-permissions

# Intel/AMD (x86_64):
docker plugin install grafana/loki-docker-driver:3.7.8-amd64 --alias loki --grant-all-permissions

docker plugin ls   # powinno pokazac "loki ... ENABLED true"
```

## 2. Odpal stack

```sh
docker compose up -d
```

Potem wejdz na http://localhost:3000, zeby zobaczyc Grafane.

## Ciekawe zapytanie

```
{job="tns/app"} | logfmt | status>=500 and status <=599 and duration > 50ms
```
