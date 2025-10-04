
### Skonfiguruj Git (jeśli jeszcze nie zrobiłeś):

```bash
git config --global user.name "Twoje Imię Nazwisko"
git config --global user.email "twoj@email.com"
```

### Sprawdź konfigurację:

```bash
git config --list
```

---

## Zadanie 1: Pierwszy commit

### Cel:
Nauczyć się podstawowych operacji: init, add, commit, status, log

### Kroki:

#### 1. Utwórz nowy katalog projektu

```bash
mkdir moj-pierwszy-projekt
cd moj-pierwszy-projekt
```

#### 2. Zainicjalizuj repozytorium Git

```bash
git init
```

**Oczekiwany wynik:**
```
Initialized empty Git repository in /path/to/moj-pierwszy-projekt/.git/
```

#### 3. Sprawdź status repozytorium

```bash
git status
```

**Oczekiwany wynik:**
```
On branch main
No commits yet
nothing to commit (create/copy files and use "git add" to track)
```

#### 4. Utwórz plik README.md

```bash
echo "# Mój pierwszy projekt Git" > README.md
```

#### 5. Sprawdź status ponownie

```bash
git status
```

**Oczekiwany wynik:**
```
Untracked files:
  (use "git add <file>..." to include in what will be committed)
        README.md
```

#### 6. Dodaj plik do staging area

```bash
git add README.md
```

#### 7. Sprawdź status po dodaniu

```bash
git status
```

**Oczekiwany wynik:**
```
Changes to be committed:
  (use "git rm --cached <file>..." to unstage)
        new file:   README.md
```

#### 8. Zrób pierwszy commit

```bash
git commit -m "Dodaj README.md"
```

**Oczekiwany wynik:**
```
[main (root-commit) abc1234] Dodaj README.md
 1 file changed, 1 insertion(+)
 create mode 100644 README.md
```

#### 9. Zobacz historię commitów

```bash
git log
```

**Oczekiwany wynik:**
```
commit abc1234567890... (HEAD -> main)
Author: Twoje Imię <twoj@email.com>
Date:   ...

    Dodaj README.md
```

#### 10. Zobacz historię w skróconej formie

```bash
git log --oneline
```

### ✅ Sprawdzenie:

Wykonaj:
```bash
ls
git status
git log --oneline
```

Powinieneś zobaczyć:
- Plik `README.md` w katalogu
- Status: "nothing to commit, working tree clean"
- Jeden commit w historii
