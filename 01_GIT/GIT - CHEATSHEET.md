# GIT - ŚCIĄGAWKA
## Najważniejsze komendy

---

## 🚀 Podstawy

### Konfiguracja

```bash
# Ustaw nazwę użytkownika
git config --global user.name "Twoje Imię"

# Ustaw email
git config --global user.email "twoj@email.com"

# Zobacz konfigurację
git config --list

# Edytuj konfigurację
git config --global --edit
```

### Tworzenie repozytorium

```bash
# Nowe repozytorium
git init

# Sklonuj istniejące
git clone <url>

# Sklonuj do konkretnego katalogu
git clone <url> nazwa-katalogu
```

---

## 📝 Podstawowe operacje

### Status i informacje

```bash
# Status repozytorium
git status

# Status w skrócie
git status -s

# Historia commitów
git log

# Historia w jednej linii
git log --oneline

# Historia z grafem
git log --oneline --graph --all

# Ostatni commit
git log -1

# Zmiany w plikach
git diff

# Zmiany w staging
git diff --staged
```

### Dodawanie i commitowanie

```bash
# Dodaj plik do staging
git add plik.txt

# Dodaj wszystkie pliki
git add .

# Dodaj wszystkie pliki z rozszerzeniem
git add *.js

# Usuń plik ze staging
git restore --staged plik.txt
# lub (starsza składnia)
git reset HEAD plik.txt

# Commit
git commit -m "Wiadomość"

# Commit z dodaniem wszystkich zmienionych plików
git commit -am "Wiadomość"

# Popraw ostatni commit
git commit --amend -m "Nowa wiadomość"

# Dodaj plik do ostatniego commita
git add zapomniany-plik.txt
git commit --amend --no-edit
```

---

## 🌿 Branching

### Podstawowe operacje

```bash
# Lista branchy
git branch

# Lista wszystkich branchy (lokalne + remote)
git branch -a

# Utwórz nowy branch
git branch nazwa-brancha

# Przełącz się na branch
git checkout nazwa-brancha
# lub (nowsza składnia)
git switch nazwa-brancha

# Utwórz i przełącz się na branch
git checkout -b nazwa-brancha
# lub (nowsza składnia)
git switch -c nazwa-brancha

# Usuń branch
git branch -d nazwa-brancha

# Wymuś usunięcie brancha (jeśli nie zmergowany)
git branch -D nazwa-brancha

# Zmień nazwę brancha
git branch -m stara-nazwa nowa-nazwa
```

### Mergowanie

```bash
# Zmerguj branch do bieżącego
git merge nazwa-brancha

# Przerwij merge (w przypadku konfliktu)
git merge --abort

# Zobacz zmergowane branche
git branch --merged

# Zobacz niezmergowane branche
git branch --no-merged
```

---

## 🔄 Remote (praca ze zdalnym repo)

### Podstawowe operacje

```bash
# Dodaj remote
git remote add origin <url>

# Zobacz remote
git remote -v

# Usuń remote
git remote remove origin

# Zmień URL remote
git remote set-url origin <nowy-url>

# Pobierz zmiany (bez merge)
git fetch

# Pobierz i zmerguj zmiany
git pull

# Wypchnij zmiany
git push

# Wypchnij i ustaw upstream
git push -u origin main

# Wypchnij branch
git push origin nazwa-brancha

# Usuń branch z remote
git push origin --delete nazwa-brancha
```

---

## ⏪ Cofanie zmian

### Cofanie zmian w plikach

```bash
# Cofnij zmiany w pliku (przed git add)
git checkout -- plik.txt
# lub (nowsza składnia)
git restore plik.txt

# Cofnij wszystkie zmiany
git checkout -- .
# lub
git restore .

# Usuń plik ze staging (po git add)
git restore --staged plik.txt
# lub (starsza składnia)
git reset HEAD plik.txt
```

### Git Reset

```bash
# Cofnij commit, zachowaj zmiany w staging
git reset --soft HEAD~1

# Cofnij commit, zachowaj zmiany w working directory
git reset --mixed HEAD~1
# lub krócej
git reset HEAD~1

# Cofnij commit i USUŃ zmiany (UWAGA!)
git reset --hard HEAD~1

# Cofnij do konkretnego commita
git reset --hard <commit-hash>
```

### Git Revert

```bash
# Cofnij ostatni commit (bezpieczne)
git revert HEAD

# Cofnij konkretny commit
git revert <commit-hash>

# Cofnij bez automatycznego commita
git revert -n HEAD
```

---

## 💾 Git Stash

```bash
# Schowaj zmiany
git stash

# Schowaj z wiadomością
git stash save "Wiadomość"

# Lista schowanych zmian
git stash list

# Przywróć ostatnie zmiany
git stash pop

# Przywróć konkretne zmiany
git stash apply stash@{0}

# Usuń ostatnie stash
git stash drop

# Usuń wszystkie stash
git stash clear

# Zobacz zawartość stash
git stash show -p
```

---

## 🔍 Przeszukiwanie i analiza

### Git Log

```bash
# Historia z grafem
git log --graph --oneline --all

# Historia dla konkretnego pliku
git log -- plik.txt

# Historia z różnicami
git log -p

# Ostatnie N commitów
git log -5

# Commity od daty
git log --since="2024-01-01"

# Commity do daty
git log --until="2024-12-31"

# Commity autora
git log --author="Jan Kowalski"

# Wyszukaj w commit messages
git log --grep="bug"

# Pokaż tylko merge commity
git log --merges

# Pokaż bez merge commitów
git log --no-merges
```

### Git Blame

```bash
# Kto zmienił każdą linię
git blame plik.txt

# Kto zmienił linie 10-20
git blame -L 10,20 plik.txt

# Pokaż email autora
git blame -e plik.txt
```

### Git Show

```bash
# Pokaż ostatni commit
git show

# Pokaż konkretny commit
git show <commit-hash>

# Pokaż konkretny plik z commita
git show <commit-hash>:plik.txt
```

---

## 🏷️ Tagi

```bash
# Lista tagów
git tag

# Utwórz tag
git tag v1.0.0

# Utwórz tag z wiadomością
git tag -a v1.0.0 -m "Wersja 1.0.0"

# Utwórz tag dla konkretnego commita
git tag v1.0.0 <commit-hash>

# Wypchnij tag na remote
git push origin v1.0.0

# Wypchnij wszystkie tagi
git push --tags

# Usuń tag lokalnie
git tag -d v1.0.0

# Usuń tag z remote
git push origin --delete v1.0.0

# Zobacz commit dla tagu
git show v1.0.0
```

---

## 🗑️ Usuwanie plików

```bash
# Usuń plik i dodaj do staging
git rm plik.txt

# Usuń plik tylko z Git (zostaw lokalnie)
git rm --cached plik.txt

# Usuń katalog
git rm -r katalog/

# Przenieś/zmień nazwę pliku
git mv stary.txt nowy.txt
```

---

## 🔧 Zaawansowane

### Git Reflog

```bash
# Historia wszystkich operacji
git reflog

# Odzyskaj usunięty commit
git reflog
git checkout <commit-hash>
```

### Git Cherry-pick

```bash
# Zastosuj konkretny commit na bieżącym branchu
git cherry-pick <commit-hash>

# Cherry-pick bez automatycznego commita
git cherry-pick -n <commit-hash>
```

### Git Rebase

```bash
# Rebase bieżącego brancha na main
git rebase main

# Interaktywny rebase (ostatnie 3 commity)
git rebase -i HEAD~3

# Kontynuuj rebase po rozwiązaniu konfliktów
git rebase --continue

# Przerwij rebase
git rebase --abort
```

### Git Clean

```bash
# Zobacz, co zostanie usunięte
git clean -n

# Usuń nieśledzone pliki
git clean -f

# Usuń nieśledzone pliki i katalogi
git clean -fd

# Usuń również pliki z .gitignore
git clean -fx
```

---

## 🛠️ Narzędzia i aliasy

### Przydatne aliasy

Dodaj do `~/.gitconfig`:

```ini
[alias]
    st = status
    co = checkout
    br = branch
    ci = commit
    unstage = reset HEAD --
    last = log -1 HEAD
    visual = log --oneline --graph --all
    amend = commit --amend --no-edit
    undo = reset --soft HEAD~1
```

Użycie:
```bash
git st       # zamiast git status
git co main  # zamiast git checkout main
git visual   # ładna historia
```

---

## 🚨 Ratowanie sytuacji

### "Zrobiłem commit do złego brancha"

```bash
git reset --soft HEAD~1
git stash
git checkout correct-branch
git stash pop
git commit -m "message"
```

### "Chcę cofnąć push (NIE ROBIĆ W ZESPOLE!)"

```bash
git reset --hard HEAD~1
git push --force
```

⚠️ **UWAGA:** `--force` usuwa historię dla wszystkich!

### "Mam konflikt podczas merge"

```bash
# 1. Otwórz plik z konfliktem
# 2. Znajdź znaczniki: <<<<<<<, =======, >>>>>>>
# 3. Rozwiąż konflikt
# 4. Usuń znaczniki
git add plik-z-konfliktem.txt
git commit
```

### "Przypadkowo usunąłem plik"

```bash
# Jeśli nie zrobiłeś commit
git checkout -- plik.txt

# Jeśli zrobiłeś commit
git revert HEAD
```

### "Chcę zobaczyć usunięty commit"

```bash
git reflog
git checkout <commit-hash>
```

---

## 📊 Porównanie komend

### Reset vs Revert

| | Reset | Revert |
|---|---|---|
| **Usuwa historię** | ✅ | ❌ |
| **Bezpieczne dla remote** | ❌ | ✅ |
| **Tworzy nowy commit** | ❌ | ✅ |
| **Użycie** | Lokalne cofanie | Cofanie po push |

### Checkout vs Switch

| | Checkout | Switch |
|---|---|---|
| **Przełączanie branchy** | ✅ | ✅ |
| **Tworzenie brancha** | `-b` | `-c` |
| **Cofanie zmian** | ✅ | ❌ |
| **Nowsza składnia** | ❌ | ✅ |

### Merge vs Rebase

| | Merge | Rebase |
|---|---|---|
| **Zachowuje historię** | ✅ | ❌ |
| **Liniowa historia** | ❌ | ✅ |
| **Bezpieczne dla remote** | ✅ | ❌ |
| **Łatwiejsze** | ✅ | ❌ |

---

## 🎯 Najczęściej używane komendy

### Codzienna praca

```bash
git status              # Sprawdź status
git add .               # Dodaj wszystkie zmiany
git commit -m "..."     # Commituj
git pull                # Pobierz zmiany
git push                # Wypchnij zmiany
```

### Praca z branchami

```bash
git checkout -b feature/X   # Nowy branch
git add .                   # Dodaj zmiany
git commit -m "..."         # Commituj
git push -u origin feature/X # Wypchnij branch
# [Utwórz Pull Request]
git checkout main           # Wróć na main
git pull                    # Pobierz zmiany
```

### Rozwiązywanie problemów

```bash
git status              # Co się dzieje?
git log --oneline       # Historia
git diff                # Jakie zmiany?
git reflog              # Historia operacji
```

---

## 📚 Dodatkowe zasoby

- **Oficjalna dokumentacja:** https://git-scm.com/doc
- **Pro Git (książka PL):** https://git-scm.com/book/pl
- **Interaktywna nauka:** https://learngitbranching.js.org
- **GitHub cheat sheet:** https://training.github.com/downloads/github-git-cheat-sheet.pdf

---

## 💡 Najlepsze praktyki

1. ✅ **Commituj często** - małe, atomowe commity
2. ✅ **Pisz dobre commit messages** - jasne i opisowe
3. ✅ **Pull przed push** - zawsze aktualizuj przed wysłaniem
4. ✅ **Używaj branchy** - nie pracuj bezpośrednio na main
5. ✅ **Nie commituj wrażliwych danych** - hasła, klucze API
6. ✅ **Używaj .gitignore** - ignoruj pliki tymczasowe
7. ✅ **Code review** - Pull Requests przed merge
8. ❌ **Nie używaj --force** - chyba że wiesz, co robisz
9. ❌ **Nie rebase publicznych branchy** - tylko lokalnie
10. ❌ **Nie commituj dużych plików** - użyj Git LFS
