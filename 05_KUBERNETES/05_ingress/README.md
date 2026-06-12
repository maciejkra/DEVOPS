# 05 — Gateway API (Envoy Gateway)

Nastepca **Ingress**. Ingress jest dzis legacy — routing po hoscie/sciezce, a wszystko
inne (rewrite, TLS, naglowki) przez adnotacje specyficzne dla kontrolera ("annotation
hell"). Gateway API (GA od K8s 1.29) robi to deklaratywnie, w typowanych obiektach:

| Obiekt         | Co opisuje                                   | Odpowiednik w Ingress |
|----------------|----------------------------------------------|-----------------------|
| `GatewayClass` | KTORA implementacja (Envoy, NGINX, Cilium…)  | `IngressClass`        |
| `Gateway`      | instancja LB: porty i listenery (80/443)     | czesc `Ingress`       |
| `HTTPRoute`    | reguly routingu (host, path, filtry)         | `rules:` w `Ingress`  |

W tym cwiczeniu uzywamy **Envoy Gateway** i dwoch samodzielnych backendow (`nginx` +
`echo-server` z `backends.yaml`) — bez zaleznosci od aplikacji z innych dni.

---

## Wymagania

**Docker Desktop** z wlaczonym Kubernetesem (Settings → Kubernetes → Enable).

> **Uwaga o portach 80/443:** musza byc wolne na hoscie. Jesli cos juz je zajmuje
> (`sudo lsof -nP -iTCP:80 -sTCP:LISTEN`), zatrzymaj to — inaczej ruch z `localhost`
> nie dojdzie do klastra.

---

## Krok 1 — Instalacja Envoy Gateway (bez Helma)

Helm poznajemy dopiero w `day5/05_helm`. Tu instalujemy zwyklym `kubectl apply`
z gotowego manifestu (analogicznie do `deploy.yaml` ingress-nginx, ktorego uzywalismy
wczesniej):

```sh
kubectl apply --server-side -f https://github.com/envoyproxy/gateway/releases/download/v1.3.2/install.yaml

kubectl wait --timeout=180s -n envoy-gateway-system \
  deployment/envoy-gateway --for=condition=Available
```

`install.yaml` zawiera CRD-y Gateway API + samego Envoy Gateway. **Nie** tworzy
`GatewayClass` — robi to za nas `gateway-http.yaml` w Kroku 2.

---

## Krok 2 — Sanity check

Docker Desktop ma wbudowany LoadBalancer: domyslny Service `LoadBalancer` data-plane'u
Envoya dostaje `EXTERNAL-IP: localhost` i jest wystawiony na `localhost:80` / `:443`.
Nic nie trzeba konfigurowac.

Stworz GatewayClass + Gateway + backendy + prosty catch-all route i sprawdz plumbing:

```sh
kubectl apply -f gateway-http.yaml -f backends.yaml

# catch-all route (welcome.yaml): bez hostnames -> lapie kazdy Host header
# (tez gole http://localhost/). Kieruje wszystko do nginx (demo-app).
kubectl apply -f welcome.yaml

kubectl wait --for=condition=Programmed gateway/training-gateway --timeout=120s

curl -s http://localhost/ | head -3
# <!DOCTYPE html> / <html> / <title>Welcome to nginx!</title>
```

> **Jesli `Programmed` dlugo jest `False`:** `EXTERNAL-IP <pending>` na Service
> data-plane'u Envoya oznacza zajety `:80`/`:443` na hoscie (inny kontener/aplikacja).
> Zwolnij porty (`sudo lsof -nP -iTCP:80 -sTCP:LISTEN`, zatrzymaj proces) i odswiez Gateway.

Widzisz HTML nginxa → ruch z hosta dociera do Envoya, GatewayClass reconciluje,
HTTPRoute jest podpiety. `welcome` zostaje na czas cwiczenia; bardziej specyficzne
route'y ponizej wygrywaja z nim dla swoich domen (Gateway API: most-specific-match).

---

## Przyklad 1 — Routing po sciezce (fanout)

```sh
kubectl apply -f fanout/httproute-path.yaml

curl http://demo.127-0-0-1.nip.io/         # -> nginx (demo-app)
curl http://demo.127-0-0-1.nip.io/echo     # -> echo-server (echo-app), odbija request
```

## Przyklad 2 — Routing po nazwie hosta (nip.io)

```sh
kubectl apply -f host/httproute-host.yaml

curl http://nginx.127-0-0-1.nip.io/        # -> nginx
curl http://echo.127-0-0-1.nip.io/         # -> echo-server
```

`<cokolwiek>.127-0-0-1.nip.io` rozwiazuje sie na `127.0.0.1` — bez ruszania `/etc/hosts`.
Envoy dopasowuje regule po naglowku `Host`.

## Przyklad 3 (bonus) — URLRewrite zamiast adnotacji

```sh
kubectl apply -f fanout/httproute-rewrite.yaml

curl http://demo.127-0-0-1.nip.io/echo2/v1   # echo pokaze, ze backend dostal "/v1"
```

To, co w Ingress wymagalo `nginx.ingress.kubernetes.io/rewrite-target`, tu jest
typowanym filterem `URLRewrite` w spec — przenosnym miedzy implementacjami.

## Przyklad 4 — TLS

Patrz **[`tls/README.md`](tls/README.md)**: self-signed (openssl) → cert-manager
`selfSigned` (lokalnie) → Let's Encrypt (produkcja).

### cert-manager bez Helma (do Przykladu 4B/4C)

```sh
kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.19.2/cert-manager.yaml
kubectl wait --timeout=180s -n cert-manager \
  deployment/cert-manager deployment/cert-manager-webhook --for=condition=Available
```

> Issuer `selfSigned` (4B) dziala od razu. Dla Let's Encrypt + Gateway API (4C)
> cert-manager musi miec wlaczony solver Gateway (`gateway-shim`) — w instalacji bez
> Helma dodaje sie to flaga kontrolera `--enable-gateway-api`. Lokalnie i tak
> nieosiagalne (brak publicznego IP), wiec na kursie zostajemy przy 4A/4B.

Patch dorzucajacy te flage do istniejacego Deploymentu cert-managera (potrzebny
tylko dla wariantu 4C — Let's Encrypt + Gateway API):

```sh
kubectl -n cert-manager patch deploy cert-manager --type=json \
  -p='[{"op":"add","path":"/spec/template/spec/containers/0/args/-","value":"--enable-gateway-api"}]'

kubectl -n cert-manager rollout status deploy/cert-manager
```

Bez tej flagi Challenge wisi w stanie `pending` z bledem
`couldn't Present challenge ...: gateway api is not enabled` — cert-manager nie wie,
jak utworzyc HTTPRoute dla solvera `http01.gatewayHTTPRoute`.

---

## Sprzatanie

```sh
kubectl delete -f host/ -f fanout/ -f backends.yaml --ignore-not-found
kubectl delete -f welcome.yaml --ignore-not-found
kubectl delete -f gateway-http.yaml --ignore-not-found
# (opcjonalnie) Envoy Gateway / cert-manager:
# kubectl delete -f https://github.com/envoyproxy/gateway/releases/download/v1.3.2/install.yaml
```

## Linki
- [Gateway API](https://gateway-api.sigs.k8s.io/)
- [Envoy Gateway](https://gateway.envoyproxy.io/)
- [cert-manager](https://cert-manager.io/docs/)
- [nip.io](https://nip.io/)
- [ingress2gateway — migracja Ingress → Gateway API](https://github.com/kubernetes-sigs/ingress2gateway)
