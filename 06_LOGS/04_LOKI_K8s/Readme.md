# Loki na Kubernetes (Helm)

Chart `grafana/loki-stack` jest **deprecated** (oparty o Promtaila, ktory jest EOL).
Skladamy aktualny zestaw:

* **Loki** (chart `grafana/loki`, tryb SingleBinary) - przechowywanie logow,
* **Grafana** (chart `grafana/grafana`) - podglad,
* **Alloy** (chart `grafana/alloy`) - kolektor logow **Grafana Alloy** (nastepca
  Promtaila), rekomendowany przez Grafane. Config w `alloy-values.yaml`: zbiera
  logi podow przez API Kubernetesa (`loki.source.kubernetes`) i wysyla do Loki.

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

## 4. Alloy (-> Loki)

```sh
helm upgrade --install alloy grafana/alloy --namespace loki -f alloy-values.yaml
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
{namespace="loki"}      # Alloy ustawia etykiety namespace / pod / container
```

## Sprzatanie

```sh
helm uninstall alloy grafana loki -n loki
kubectl delete namespace loki
```
