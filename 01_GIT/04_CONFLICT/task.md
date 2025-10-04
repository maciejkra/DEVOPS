## Zadanie 4: Rozwiązywanie konfliktu

### Cel:
Nauczyć się rozwiązywania konfliktów podczas merge

### Wymagania:
- Ukończone Zadanie 3

### Kroki:

#### 1. Upewnij się, że jesteś na main

```bash
git checkout main
```

#### 2. Utwórz plik, który będzie źródłem konfliktu

```bash
echo "Wersja 1: To jest oryginalny tekst" > konflikt.txt
git add konflikt.txt
git commit -m "Dodaj konflikt.txt z wersją 1"
```

#### 3. Utwórz pierwszy branch i zmień plik

```bash
git checkout -b branch-a
echo "Wersja A: Zmiana z brancha A" > konflikt.txt
git add konflikt.txt
git commit -m "Zmień konflikt.txt na branchu A"
```

#### 4. Wróć na main i utwórz drugi branch

```bash
git checkout main
git checkout -b branch-b
echo "Wersja B: Zmiana z brancha B" > konflikt.txt
git add konflikt.txt
git commit -m "Zmień konflikt.txt na branchu B"
```

#### 5. Zmerguj branch-a do main

```bash
git checkout main
git merge branch-a
```

**Oczekiwany wynik:**
```
Updating mno7890..pqr1234
Fast-forward
 konflikt.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
```

To był **fast-forward merge** - bez konfliktu.

#### 6. Spróbuj zmergować branch-b do main

```bash
git merge branch-b
```

**Oczekiwany wynik:**
```
Auto-merging konflikt.txt
CONFLICT (content): Merge conflict in konflikt.txt
Automatic merge failed; fix conflicts and then commit the result.
```

🎉 **Mamy konflikt!**

#### 7. Sprawdź status

```bash
git status
```

**Oczekiwany wynik:**
```
On branch main
You have unmerged paths.
  (fix conflicts and run "git commit")
  (use "git merge --abort" to abort the merge)

Unmerged paths:
  (use "git add <file>..." to mark resolution)
        both modified:   konflikt.txt
```

#### 8. Zobacz zawartość pliku z konfliktem

```bash
cat konflikt.txt
```

**Oczekiwany wynik:**
```
<<<<<<< HEAD
Wersja A: Zmiana z brancha A
=======
Wersja B: Zmiana z brancha B
>>>>>>> branch-b
```

**Wyjaśnienie:**
- `<<<<<<< HEAD` - początek twojej wersji (branch main)
- `=======` - separator
- `>>>>>>> branch-b` - koniec wersji z mergowanego brancha

#### 9. Rozwiąż konflikt

Otwórz plik w edytorze (np. `nano`, `vim`, `code`):

```bash
nano konflikt.txt
```

**Opcja 1:** Zostaw tylko wersję A
```
Wersja A: Zmiana z brancha A
```

**Opcja 2:** Zostaw tylko wersję B
```
Wersja B: Zmiana z brancha B
```

**Opcja 3:** Połącz obie wersje
```
Wersja A: Zmiana z brancha A
Wersja B: Zmiana z brancha B
```

**Opcja 4:** Napisz coś nowego
```
Wersja finalna: Połączenie A i B
```

**WAŻNE:** Usuń wszystkie znaczniki:
- `<<<<<<< HEAD`
- `=======`
- `>>>>>>> branch-b`

Zapisz i zamknij edytor.

#### 10. Sprawdź, czy plik jest poprawny

```bash
cat konflikt.txt
```

Upewnij się, że **NIE MA** znaczników `<<<<<<<`, `=======`, `>>>>>>>`.

#### 11. Dodaj rozwiązany plik

```bash
git add konflikt.txt
```

#### 12. Sprawdź status

```bash
git status
```

**Oczekiwany wynik:**
```
On branch main
All conflicts fixed but you are still merging.
  (use "git commit" to conclude merge)

Changes to be committed:
        modified:   konflikt.txt
```

#### 13. Zakończ merge

```bash
git commit -m "Rozwiąż konflikt w konflikt.txt"
```

**Uwaga:** Git automatycznie przygotuje commit message. Możesz go zaakceptować lub zmienić.

#### 14. Zobacz historię

```bash
git log --oneline --graph --all
```

Zobaczysz merge commit łączący oba branche!

#### 15. Usuń branche (opcjonalnie)

```bash
git branch -d branch-a
git branch -d branch-b
```

#### 16. Wypchnij zmiany na GitHub

```bash
git push
```

### ✅ Sprawdzenie:

- [ ] Utworzyłeś konflikt (dwa branche zmieniły ten sam plik)
- [ ] Git zgłosił konflikt podczas merge
- [ ] Rozwiązałeś konflikt ręcznie
- [ ] Usunąłeś znaczniki `<<<<<<<`, `=======`, `>>>>>>>`
- [ ] Zakończyłeś merge committem
- [ ] Zmiany są na GitHub

### 💡 Wskazówki:

- **Zawsze czytaj obie wersje** przed rozwiązaniem konfliktu
- **Testuj kod** po rozwiązaniu konfliktu
- **Nie panikuj** - konflikty są normalne w pracy zespołowej!
