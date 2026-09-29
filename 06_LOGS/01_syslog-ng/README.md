# syslog-ng + docker syslog driver

Najprostsze centralne logowanie: dwa kontenery nginx (`www1`, `www2`) wysylaja
swoje logi przez wbudowany docker logging driver `syslog` do kontenera
**syslog-ng**, ktory zapisuje je do plikow - osobny plik per aplikacja
(wg `tag` z drivera: `http1`, `http2`).

## 1. Odpal stack

```sh
docker compose up -d
```

- `syslog` - syslog-ng, nasluchuje na tcp `localhost:5514`, pisze do `./logs/`
- `www1`   - nginx na http://localhost:80, tag `http1`
- `www2`   - nginx na http://localhost:81, tag `http2`

## 2. Wygeneruj logi i sprawdz pliki

```sh
curl localhost:80
curl localhost:81
```

```sh
tail -f logs/http1.log logs/http2.log
```

## Sprzatanie

```sh
docker compose down
```
