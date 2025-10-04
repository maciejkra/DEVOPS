### Zadanie 8: Git Amend

#### Cel:
Nauczyć się poprawiania ostatniego commita

#### Kroki:

1. Zrób commit z błędem:
   ```bash
   echo "Funkcja 1" > funkcja.txt
   git add funkcja.txt
   git commit -m "Dodaj funkjcę"  # literówka!
   ```

2. Popraw commit message:
   ```bash
   git commit --amend -m "Dodaj funkcję"
   ```

3. Dodaj zapomniany plik do ostatniego commita:
   ```bash
   echo "Funkcja 2" > funkcja2.txt
   git add funkcja2.txt
   git commit --amend --no-edit
   ```

4. Zobacz historię:
   ```bash
   git log --oneline
   ```
   Ostatni commit zawiera oba pliki!