# Zadanie — Gateway API: wystaw aplikacje python

Cel: caly ruch dla hosta **`api.127.0.0.1.nip.io`** skierowac przez Gateway API
do aplikacji **python** z kursu (`python-service`, port `5002`).

## Przygotowanie

1. Envoy Gateway zainstalowany, a GatewayClass `eg` + Gateway `training-gateway`
   dzialaja (patrz `README.md`, Krok 1–2). Sanity check: `curl http://localhost/`
   zwraca strone nginx.

2. Wdroz aplikacje python + redis z lekcji o Service (`04_service`):
   ```sh
   kubectl apply -f ../04_service/solution/
   kubectl rollout status deployment/python-deployment
   ```
   Powstaje m.in. Service `python-service` (port **5002**) — to do niego pokierujemy ruch.

## Zadanie

Napisz **HTTPRoute**, ktory CALY ruch dla hosta `api.127.0.0.1.nip.io` skieruje do
`python-service` na porcie `5002`. Podpowiedzi:

- `parentRefs` → `training-gateway`
- `hostnames` → `api.127.0.0.1.nip.io`
- regula bez `matches` (albo z `PathPrefix: /`) = lapie caly ruch hosta
- `backendRefs` → `python-service`, `port: 5002`

Zapisz do wlasnego pliku i zaaplikuj:
```sh
kubectl apply -f <twoj-plik>.yaml
```

## Weryfikacja

```sh
curl http://api.127.0.0.1.nip.io/
```
Powinienes dostac odpowiedz z aplikacji python (nie ze strony nginx).

Sprawdz status route'u:
```sh
kubectl get httproute <nazwa> \
  -o jsonpath='{.status.parents[0].conditions[*].type}{"\n"}'
# Accepted i ResolvedRefs powinny byc True
```

## Pytania

- Czym rozni sie route po `hostnames` od catch-all `welcome` (bez `hostnames`)?
- Co pokaze `kubectl describe httproute <nazwa>`, jesli pomylisz port backendu
  (np. wpiszesz 80 zamiast 5002)?

## Sprzatanie

```sh
kubectl delete httproute <nazwa> --ignore-not-found
kubectl delete -f ../04_service/solution/ --ignore-not-found
```
