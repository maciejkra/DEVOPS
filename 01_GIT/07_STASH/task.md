### Zadanie 7: Git Stash

#### Cel:
Nauczyć się tymczasowego chowania zmian

#### Kroki:

1. Wprowadź zmianę (nie commituj):
   ```bash
   echo "Niedokończona praca" >> README.md
   ```

2. Sprawdź status:
   ```bash
   git status
   ```

3. Schowaj zmiany:
   ```bash
   git stash
   ```

4. Sprawdź status:
   ```bash
   git status
   ```
   Working tree jest czysty!

5. Zobacz listę stash:
   ```bash
   git stash list
   ```

6. Przywróć zmiany:
   ```bash
   git stash pop
   ```

7. Sprawdź plik:
   ```bash
   cat README.md
   ```
   Zmiany są z powrotem!
