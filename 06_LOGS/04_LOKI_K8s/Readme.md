# Loki na Kubernetes (Helm)

Chart `grafana/loki-stack` jest **deprecated** (oparty o Promtaila, ktory jest EOL).
Skladamy aktualny zestaw:

* **Loki** (chart `grafana/loki`, tryb SingleBinary) - przechowywanie logow,
* **Grafana** (chart `grafana/grafana`) - podglad,
* **k8s-monitoring** (chart `grafana/k8s-monitoring`) - kolektor logow oparty o
  **Grafana Alloy** (nastepca Promtaila), rekomendowany przez Grafane sposob
  zbierania telemetrii z Kubernetesa. Tutaj wlaczamy z niego TYLKO logi podow.

> Uwaga: `k8s-monitoring` to sam kolektor - wysyla do *destination*. Loki i Grafane
> i tak instalujemy osobno (k8s-monitoring zastepuje samodzielny chart `alloy`).

## 1. Repo Helm

```sh
helm repo add grafana https://grafana.github.io/helm-charts
helm repo update
```

## 2. Loki (SingleBinary)

```sh
helm upgrade --install loki grafana/loki \
  --namespace loki --create-namespace \
  -f loki-values.yaml
```

## 3. Grafana

```sh
helm upgrade --install grafana grafana/grafana --namespace loki
```

## 4. k8s-monitoring (Alloy -> Loki)

```sh
helm upgrade --install k8s-monitoring grafana/k8s-monitoring \
  --namespace loki \
  -f k8s-monitoring-values.yaml
```

## 5. Podglad

Haslo admina Grafany:

```sh
kubectl get secret -n loki grafana -o jsonpath="{.data.admin-password}" | base64 --decode ; echo
```

```sh
kubectl port-forward -n loki svc/grafana 3000:80
```

W Grafanie dodaj **Data source -> Loki** z URL
`http://loki.loki.svc.cluster.local:3100`, potem **Explore** i np.:

```logql
{cluster="docker-desktop"}      # albo zawez do namespace, np. {namespace="loki"}
```

## Sprzatanie

```sh
helm uninstall k8s-monitoring grafana loki -n loki
kubectl delete namespace loki
```
