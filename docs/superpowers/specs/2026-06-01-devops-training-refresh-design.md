# Aktualizacja materiałów szkolenia DEVOPS (dni 3–5)

Data: 2026-06-01

## Cel

Kurs prowadzony od lat, poziom **basic**, **5 dni**, materiału za dużo. Zaktualizować
przestarzałe/martwe fragmenty bez rozbudowy zakresu. Zmiany **chirurgiczne**: jeden
działający flow na temat, nic „przy okazji".

## Kryterium sukcesu

Każdy zmieniony stack **realnie wstaje i odpowiada** (zweryfikowane uruchomieniem),
zanim zostanie uznany za gotowy. Docker działa lokalnie; Kubernetes z Docker Desktop
(NIE klastry zdalne — `gke-...-prod`, `microk8s-oracle`, `vip-prod` są nietykalne).

## Zakres per folder

### 05_KUBERNETES/05_ingress — pełna zamiana na Gateway API

- Usunąć cały `nginx/` (ingress-nginx host/fanout/tls) + obecny `README.md`.
- Wstawić Gateway API (Envoy Gateway) z referencji
  `github.com/maciejkra/k8s/tree/main/day3/07_gateway_api`, **wycięte z kind**:
  - usunąć plik `envoyproxy-hostport.yaml` (czysto kind),
  - z README/task/tls wyciąć sekcje „kind", `kubectl patch gatewayclass`,
    offset portów 10080/10443, wzmianki `kind.yaml`/`ingress-ready`/tolerations,
  - zostaje tylko ścieżka **Docker Desktop** (wbudowany LB → `localhost:80/443`).
- Struktura docelowa:
  ```
  05_ingress/
    README.md, task.md, backends.yaml
    gateway-http.yaml, gateway-https.yaml
    fanout/httproute-path.yaml, fanout/httproute-rewrite.yaml
    host/httproute-host.yaml
    tls/README.md, tls/certmanager-selfsigned.yaml, tls/certmanager-letsencrypt.yaml
  ```
- Wersje z referencji aktualne (Envoy Gateway v1.3.2, cert-manager v1.19.2,
  `gateway.networking.k8s.io/v1`). Let's Encrypt zostaje jako przykład produkcyjny
  (z notką, że lokalnie się nie uda).
- **Test:** DD k8s → install Envoy Gateway → `gateway-http.yaml` + `backends.yaml` +
  catch-all route → `curl http://localhost/` zwraca stronę nginx; fanout/host po nip.io;
  TLS wariant B (cert-manager selfSigned) → `curl -k https://demo.127-0-0-1.nip.io/`.

### 06_LOGS

**03_LOKI** — Loki 2.0 → 3.x, kolektor = Docker Loki logging driver (bez Promtaila):
- `loki-config.yaml`: kanoniczny config 3.x (schema **v13**, `store: tsdb`, blok
  `common`). Wyrzucić `boltdb`, `max_transfer_retries`, `table_manager`,
  `chunk_store_config`.
- `docker-compose.yml`: `loki:3.x` + `grafana:latest`; usunąć usługę `promtail`
  i plik `promtail-config.yaml`; dodać przykładową usługę logującą przez driver `loki`
  (`loki-url: http://localhost:3100/loki/api/v1/push`); usunąć `version:`.
- README: instalacja pluginu `docker plugin install grafana/loki-docker-driver`.
- **Test:** `docker compose up` → Loki `/ready` = ready; app generuje logi; query
  `/loki/api/v1/query_range` zwraca wpisy; Grafana wstaje na :3000.

**02_elk** — Open Distro (martwy) → OpenSearch 3.x + Dashboards + Fluent Bit:
- `docker-compose.yml`: `opensearchproject/opensearch` + `opensearch-dashboards`,
  `DISABLE_SECURITY_PLUGIN=true`, `OPENSEARCH_INITIAL_ADMIN_PASSWORD`,
  `discovery.type=single-node`; `filebeat` → `fluent-bit` (output `opensearch`).
- `elasticsearch.yml` → `opensearch.yml` (lub usunąć przy single-node);
  `filebeat.yml` → `fluent-bit.conf`.
- Powód zmiany shippera: `compatibility.override_main_response_version` usunięty
  w OpenSearch 2.0 → Filebeat OSS już nie łączy się z OpenSearch 2.x+.
- **Test:** OpenSearch `/_cluster/health` = green/yellow; Fluent Bit tworzy indeks
  (`/_cat/indices`); Dashboards wstaje na :5601.

**04_LOKI_K8s** — chart `loki-stack` (deprecated) → aktualny `grafana/loki`
(single-binary values); README zaktualizowany. **Test:** Helm install na DD k8s,
pody Running, `kubectl port-forward` → Grafana.

**01_syslog-ng** — `balabit/syslog-ng:latest` → utrzymywany obraz
(`linuxserver/syslog-ng` lub `axoflow/axosyslog`). **Test:** `docker compose up`,
logi nginx lądują w `./logs/`.

**05_Extra** (niski priorytet) — podbicie pinów (grafana/prometheus/loki/tempo),
fix endpointu `/api/prom/push` → `/loki/api/v1/push`. **Test:** stack wstaje, Grafana
ma dane.

### 07_MONITORING/02_PROMETHEUS — napraw + zamień martwe

- **Bug:** `ports: 3000:300` → `3000:3000`.
- `nginx-prometheus-exporter:0.8.0` → `1.5.x`, flaga `-nginx.scrape-uri`
  → `--nginx.scrape-uri`.
- `alertmanager.yml`: żywy webhook Slacka → placeholder `<SLACK_WEBHOOK_URL>`;
  `group_by` na realne etykiety.
- Usunąć `version:`, pinować obrazy `prometheus`/`grafana`/`alertmanager`.
- **01_ZABBIX** — bez zmian (aktualne).
- **Test:** `docker compose up` → Prometheus targets `up`; exporter `:9113/metrics`;
  Grafana :3000; Alertmanager :9093 ładuje config bez błędu.

### 08_CI — napraw + zamień martwe

- `Dockerfile`: **kubeval** (archived) → **kubeconform**; `KUBECTL_VERSION`
  v1.30.1 → aktualna stabilna.
- `Jenkinsfile`: `kubeval --strict` → `kubeconform -strict`.
- `Readme.md`: pod realny stan (`docker compose up`, nie nieistniejące
  `Dockerfile.jenkins`/`Dockerfile.kubectl`); fix „Lunch"→„Launch".
- **Test:** `docker build` przechodzi; w obrazie `kubeconform -v` i `kubectl version
  --client` działają; pluginy się instalują.

## Poza zakresem (NIE ruszać)

01_ZABBIX, logika Jenkinsfile poza kubeval, klastry zdalne, struktura katalogów poza
wymienionymi, jakiekolwiek zmiany „przy okazji".
