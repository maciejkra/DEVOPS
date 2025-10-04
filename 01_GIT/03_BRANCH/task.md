## Zadanie 3: Tworzenie brancha

### Cel:
Nauczyć się tworzenia branchy, przełączania się między nimi i mergowania

### Wymagania:
- Ukończone Zadanie 2

### Kroki:

#### 1. Sprawdź, na jakim branchu jesteś

```bash
git branch
```

**Oczekiwany wynik:**
```
* main
```

Gwiazdka `*` pokazuje aktywny branch.

#### 2. Utwórz nowy branch

```bash
git checkout -b feature/dodaj-info
```

**Oczekiwany wynik:**
```
Switched to a new branch 'feature/dodaj-info'
```

**Alternatywnie** (nowsza składnia):
```bash
git switch -c feature/dodaj-info
```

#### 3. Sprawdź listę branchy

```bash
git branch
```

**Oczekiwany wynik:**
```
* feature/dodaj-info
  main
```

#### 4. Utwórz nowy plik na branchu

```bash
echo "Autor: $(whoami)" > info.txt
echo "Data: $(date)" >> info.txt
```

#### 5. Dodaj i commituj

```bash
git add info.txt
git commit -m "Dodaj plik info.txt z informacjami"
```

#### 6. Sprawdź, czy plik istnieje

```bash
ls
cat info.txt
```

#### 7. Przełącz się na branch main

```bash
git checkout main
```

#### 8. Sprawdź, czy plik istnieje na main

```bash
ls
```

**Obserwacja:** Pliku `info.txt` **NIE MA** na branchu main! To jest normalne - każdy branch ma swoją wersję plików.

#### 9. Wróć na branch feature

```bash
git checkout feature/dodaj-info
ls
```

Plik `info.txt` **jest z powrotem**!

#### 10. Zmerguj branch do main

```bash
git checkout main
git merge feature/dodaj-info
```

**Oczekiwany wynik:**
```
Updating ghi9012..jkl3456
Fast-forward
 info.txt | 2 ++
 1 file changed, 2 insertions(+)
 create mode 100644 info.txt
```

#### 11. Sprawdź, czy plik jest teraz na main

```bash
ls
cat info.txt
```

Plik `info.txt` jest teraz na branchu main!

#### 12. Zobacz historię w formie grafu

```bash
git log --oneline --graph --all
```

#### 13. Usuń branch feature (opcjonalnie)

```bash
git branch -d feature/dodaj-info
```

**Oczekiwany wynik:**
```
Deleted branch feature/dodaj-info (was jkl3456).
```

**Uwaga:** Zmiany z brancha **pozostają** na main po merge!

#### 14. Wypchnij zmiany na GitHub

```bash
git push
```

### ✅ Sprawdzenie:

- [ ] Utworzyłeś branch `feature/dodaj-info`
- [ ] Dodałeś plik na branchu
- [ ] Zmergowałeś branch do main
- [ ] Plik `info.txt` jest na main
- [ ] Zmiany są na GitHub