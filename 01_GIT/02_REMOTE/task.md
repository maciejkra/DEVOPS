## Zadanie 2: Praca z remote (GitHub)

### Cel:
Nauczyć się pracy ze zdalnym repozytorium (push, pull)

### Wymagania:
- Konto na GitHub (https://github.com)
- Ukończone Zadanie 1

### Kroki:

#### 1. Utwórz nowe repozytorium na GitHub

1. Wejdź na https://github.com
2. Kliknij przycisk **"New"** (zielony przycisk) lub **"+"** w prawym górnym rogu
3. Wypełnij formularz:
   - **Repository name:** `git-workshop`
   - **Description:** (opcjonalnie) "Warsztat Git"
   - **Public** lub **Private** - wybierz według preferencji
   - **NIE zaznaczaj** "Initialize this repository with a README"
4. Kliknij **"Create repository"**

#### 2. Połącz lokalne repozytorium z GitHub

GitHub pokaże Ci instrukcje. Użyj sekcji **"…or push an existing repository from the command line"**:

```bash
cd moj-pierwszy-projekt
git remote add origin https://github.com/TWOJA-NAZWA-UŻYTKOWNIKA/git-workshop.git
git branch -M main
git push -u origin main
```

**Uwaga:** Zamień `TWOJA-NAZWA-UŻYTKOWNIKA` na swoją nazwę użytkownika GitHub!

**Możliwe problemy:**
- Jeśli GitHub prosi o logowanie, użyj Personal Access Token zamiast hasła
- Instrukcja: https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/creating-a-personal-access-token

#### 3. Sprawdź repozytorium na GitHub

Odśwież stronę GitHub - powinieneś zobaczyć swój plik `README.md`!

#### 4. Wprowadź zmianę lokalnie

```bash
echo "" >> README.md
echo "## Opis projektu" >> README.md
echo "To jest mój pierwszy projekt Git!" >> README.md
```

#### 5. Zobacz różnice

```bash
git diff
```

**Oczekiwany wynik:**
```diff
diff --git a/README.md b/README.md
index ...
--- a/README.md
+++ b/README.md
@@ -1 +1,4 @@
 # Mój pierwszy projekt Git
+
+## Opis projektu
+To jest mój pierwszy projekt Git!
```

#### 6. Dodaj i commituj zmiany

```bash
git add README.md
git commit -m "Dodaj opis projektu do README"
```

#### 7. Wypchnij zmiany na GitHub

```bash
git push
```

**Oczekiwany wynik:**
```
Enumerating objects: 5, done.
Counting objects: 100% (5/5), done.
...
To https://github.com/TWOJA-NAZWA/git-workshop.git
   abc1234..def5678  main -> main
```

#### 8. Sprawdź zmiany na GitHub

Odśwież stronę - powinieneś zobaczyć zaktualizowany `README.md`!

#### 9. Wprowadź zmianę bezpośrednio na GitHub

1. Na stronie GitHub kliknij plik `README.md`
2. Kliknij ikonę ołówka (Edit)
3. Dodaj na końcu:
   ```
   ## Autor
   Twoje Imię
   ```
4. Przewiń w dół, wpisz commit message: "Dodaj autora"
5. Kliknij **"Commit changes"**

#### 10. Pobierz zmiany lokalnie

```bash
git pull
```

**Oczekiwany wynik:**
```
remote: Enumerating objects: 5, done.
...
Updating def5678..ghi9012
Fast-forward
 README.md | 3 +++
 1 file changed, 3 insertions(+)
```

#### 11. Sprawdź plik lokalnie

```bash
cat README.md
```

Powinieneś zobaczyć sekcję "Autor"!

### ✅ Sprawdzenie:

- [ ] Repozytorium istnieje na GitHub
- [ ] Lokalnie masz co najmniej 2 commity
- [ ] `git pull` pobiera zmiany z GitHub
- [ ] `git push` wysyła zmiany na GitHub
