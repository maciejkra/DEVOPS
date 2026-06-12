# TLS na Gateway API

Listener HTTPS w Gateway API potrzebuje tylko Secretu typu `kubernetes.io/tls`,
do ktorego odwoluje sie `gateway-https.yaml` (`certificateRefs: [{Secret: app-tls}]`).
Skad wziac ten Secret — trzy warianty, od najprostszego:

## A. Self-signed recznie (openssl) — dziala offline, bez cert-managera

```sh
# 1) cert z SAN-ami dla naszych domen nip.io
openssl req -x509 -newkey rsa:2048 -nodes -days 365 \
  -keyout tls.key -out tls.crt \
  -subj "/CN=demo.127-0-0-1.nip.io" \
  -addext "subjectAltName=DNS:demo.127-0-0-1.nip.io,DNS:nginx.127-0-0-1.nip.io,DNS:echo.127-0-0-1.nip.io"

# 2) Secret kubernetes.io/tls o nazwie app-tls (tej oczekuje gateway-https.yaml)
kubectl create secret tls app-tls --cert=tls.crt --key=tls.key \
  --dry-run=client -o yaml | kubectl apply -f -

# 3) dorzuc listener HTTPS:443
kubectl apply -f ../gateway-https.yaml
```

Test (`-k`, bo cert jest self-signed; na Docker Desktop wprost na `:443`):
```sh
curl -kv https://demo.127-0-0-1.nip.io/ 2>&1 | grep -iE "subject:|issuer:|HTTP/"
# subject == issuer  => self-signed
```

## B. cert-manager, issuer `selfSigned` — dziala LOKALNIE, automatyzuje Secret

Najpierw zainstaluj cert-managera (bez Helma — patrz `../README.md`, sekcja TLS), potem:
```sh
kubectl apply -f certmanager-selfsigned.yaml
kubectl wait --for=condition=Ready certificate/app-tls --timeout=2m
kubectl get secret app-tls   # cert-manager sam utworzyl Secret kubernetes.io/tls
kubectl apply -f ../gateway-https.yaml
```

To samo HTTPS co w wariancie A, tyle ze Secret wystawia i odnawia cert-manager —
nie Ty openssl-em. To jest sedno cert-managera: produkcja i renewal certow.

## C. cert-manager + Let's Encrypt — PRODUKCJA, nie zadziala z localhost

`certmanager-letsencrypt.yaml` — wymaga publicznego IP (HTTP-01). Szczegoly i ograniczenia
w komentarzu w tym pliku oraz w `../README.md`. Lokalnie zostan przy wariancie A lub B.
