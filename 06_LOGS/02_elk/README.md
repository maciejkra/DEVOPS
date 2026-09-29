# OpenSearch + OpenSearch Dashboards + Fluent Bit

Nazwa katalogu (`02_elk`) jest historyczna. Klasyczny ELK (Elasticsearch +
Logstash + Kibana) / Amazon Open Distro zastapilismy otwartym nastepca:

* **OpenSearch** - przechowywanie i wyszukiwanie logow (zamiast Elasticsearcha),
* **OpenSearch Dashboards** - UI (zamiast Kibany),
* **Fluent Bit** - kolektor logow (zamiast Logstasha/Filebeata).

Kontener `app` (nginx) wysyla logi przez docker logging driver `fluentd` do
Fluent Bita, a ten zapisuje je w OpenSearch w indeksie `docker-logs`.
Plugin security jest wylaczony (bez TLS i hasel) - prosciej na warsztacie.

## 1. Odpal stack

```sh
docker compose up -d
```

OpenSearch startuje ok. 30-60 s (Fluent Bit czeka na jego healthcheck).

## 2. Wygeneruj logi

```sh
curl localhost:8080      # kilka razy, zeby nginx cos zalogowal
```

## 3. Sprawdz indeks w OpenSearch

```sh
curl 'localhost:9200/_cat/indices?v'
```

Na liscie powinien byc indeks `docker-logs`.

## 4. OpenSearch Dashboards

Wejdz na http://localhost:5601, utworz **index pattern** `docker-logs*`
(Dashboards Management -> Index patterns), potem **Discover**.

## Sprzatanie

```sh
docker compose down -v
```
