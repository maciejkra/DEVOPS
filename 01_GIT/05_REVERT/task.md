## Zadanie 5: Cofanie zmian

### Cel:
Nauczyć się cofania zmian za pomocą reset, revert, checkout

### Wymagania:
- Ukończone Zadanie 4

### Część A: Git Reset --soft

#### 1. Utwórz commit, który cofniesz

```bash
echo "To jest tymczasowy plik" > tymczasowy.txt
git add tymczasowy.txt
git commit -m "Dodaj tymczasowy plik"
```

#### 2. Zobacz historię

```bash
git log --oneline
```

#### 3. Cofnij ostatni commit (zachowaj zmiany)

```bash
git reset --soft HEAD~1
```

**Co się stało?**
- Commit został usunięty z historii
- Plik `tymczasowy.txt` nadal istnieje
- Zmiany są w staging area

#### 4. Sprawdź status

```bash
git status
```

**Oczekiwany wynik:**
```
Changes to be committed:
  (use "git restore --staged <file>..." to unstage)
        new file:   tymczasowy.txt
```

#### 5. Zobacz, że plik nadal istnieje

```bash
ls
cat tymczasowy.txt
```

#### 6. Popraw plik i zrób nowy commit

```bash
echo "To jest poprawiony plik" > tymczasowy.txt
git add tymczasowy.txt
git commit -m "Dodaj poprawiony plik"
```

### Część B: Git Reset --hard (UWAGA!)

#### 7. Utwórz kolejny commit

```bash
echo "Plik do usunięcia" > do-usuniecia.txt
git add do-usuniecia.txt
git commit -m "Dodaj plik do usunięcia"
```

#### 8. Cofnij commit i USUŃ zmiany

```bash
git reset --hard HEAD~1
```

⚠️ **UWAGA:** To usuwa zmiany bezpowrotnie!

#### 9. Sprawdź, czy plik został usunięty

```bash
ls
```

Plik `do-usuniecia.txt` **zniknął**!

### Część C: Git Revert (bezpieczniejsze)

#### 10. Utwórz commit, który cofniesz za pomocą revert

```bash
echo "Plik do revert" > revert.txt
git add revert.txt
git commit -m "Dodaj plik do revert"
```

#### 11. Użyj git revert

```bash
git revert HEAD
```

Otworzy się edytor z commit message. Zapisz i zamknij (w nano: Ctrl+X, Y, Enter).

#### 12. Zobacz historię

```bash
git log --oneline
```

**Obserwacja:**
- Są **2 commity**: "Dodaj plik do revert" i "Revert 'Dodaj plik do revert'"
- Historia **nie została usunięta**
- Plik `revert.txt` został usunięty

#### 13. Sprawdź, czy plik został usunięty

```bash
ls
```

Plik `revert.txt` **nie istnieje**, ale historia pokazuje, co się stało!

### Część D: Cofanie zmian w pliku (bez commit)

#### 14. Wprowadź zmianę w pliku

```bash
echo "Zła zmiana" >> README.md
```

#### 15. Zobacz różnicę

```bash
git diff
```

#### 16. Cofnij zmianę (przed git add)

```bash
git checkout -- README.md
```

**Alternatywnie** (nowsza składnia):
```bash
git restore README.md
```

#### 17. Sprawdź, czy zmiana została cofnięta

```bash
git diff
```

Powinno być puste - zmiana została cofnięta!

### ✅ Sprawdzenie:

- [ ] Użyłeś `git reset --soft` (cofnięcie commita, zachowanie zmian)
- [ ] Użyłeś `git reset --hard` (cofnięcie commita i usunięcie zmian)
- [ ] Użyłeś `git revert` (bezpieczne cofnięcie przez nowy commit)
- [ ] Użyłeś `git checkout --` (cofnięcie zmian w pliku)

### 📊 Porównanie:

| Komenda | Cofa commit? | Usuwa zmiany? | Bezpieczne dla remote? |
|---------|--------------|---------------|------------------------|
| `git reset --soft` | ✅ | ❌ | ❌ |
| `git reset --hard` | ✅ | ✅ | ❌ |
| `git revert` | ✅ (nowy commit) | ✅ | ✅ |
| `git checkout --` | ❌ | ✅ | N/A |

---

## Zadania dodatkowe
**Dla chętnych po zakończeniu głównych zadań**