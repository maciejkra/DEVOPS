# CI/CD - Jenkins

Jenkins z dobudowanym `docker` CLI, `kubectl` i `kubeconform` (patrz `Dockerfile`).
Pluginy instaluja sie automatycznie z `plugins.txt` podczas budowania obrazu.

## Uruchomienie

```sh
docker compose up -d --build
```

Jenkins wstanie na http://localhost:8080 (agent port 50000).

## Pierwsze logowanie

Haslo poczatkowego admina:

```sh
docker exec jenkins cat /var/jenkins_home/secrets/initialAdminPassword
```

## Pipeline

`Jenkinsfile` buduje obraz aplikacji (buildx, multi-arch), waliduje manifesty
przez `kubeconform -strict` i wdraza na Kubernetes (`kubectl apply` + rollout,
z rollbackiem przy bledzie). Wymaga skonfigurowanych credentials:

* `dockerhub`            - login/haslo do Docker Hub
* `docker-for-desktop`  - kubeconfig (withKubeConfig) do docelowego klastra

## Sprzatanie

```sh
docker compose down
```
