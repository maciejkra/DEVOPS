# Loki + Docker logging driver

Zbieramy logi kontenerow **bez osobnego agenta**. Zamiast Promtaila (EOL od 2026,
nastepca to Grafana Alloy) uzywamy wbudowanego docker logging drivera `loki`, ktory
wysyla logi kontenera wprost do Loki.

## 1. Zainstaluj plugin (jednorazowo na hoscie)

Tag pluginu jest per-architektura. Wybierz wg swojego procesora:

```sh
# Apple Silicon (M1/M2/M3...) / ARM:
docker plugin install grafana/loki-docker-driver:3.7.2-arm64 --alias loki --grant-all-permissions

# Intel/AMD (x86_64):
docker plugin install grafana/loki-docker-driver:3.7.2-amd64 --alias loki --grant-all-permissions

docker plugin ls   # powinno pokazac "loki ... ENABLED true"
```

## 2. Odpal stack

```sh
docker compose up -d
```

- `loki`    - baza logow (http://localhost:3100)
- `grafana` - UI (http://localhost:3000, anonimowy login jako Admin)
- `app`     - przykladowy nginx; jego logi leca do Loki przez driver `loki`

## 3. Wygeneruj logi i sprawdz w Grafanie

```sh
curl http://localhost:8080/        # kilka razy, zeby nginx cos zalogowal
```

W Grafanie: **Connections -> Data sources -> add Loki** (URL `http://loki:3100`),
potem **Explore** i zapytanie:

```logql
{compose_service="app"}
```

Mozna tez sprawdzic z CLI:

```sh
curl -s 'http://localhost:3100/loki/api/v1/labels'
```

## Sprzatanie

```sh
docker compose down -v
```
