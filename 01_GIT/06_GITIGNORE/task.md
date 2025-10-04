### Zadanie 6: .gitignore

#### Cel:
Nauczyć się ignorowania plików

#### Kroki:

1. Utwórz plik, który nie powinien być w repo:
   ```bash
   echo "SECRET_KEY=abc123" > .env
   ```

2. Sprawdź status:
   ```bash
   git status
   ```
   Plik `.env` jest untracked.

3. Utwórz `.gitignore`:
   ```bash
   echo ".env" > .gitignore
   ```

4. Sprawdź status ponownie:
   ```bash
   git status
   ```
   Plik `.env` **zniknął** z listy! Jest ignorowany.

5. Dodaj więcej reguł do `.gitignore`:
   ```bash
   echo "*.log" >> .gitignore
   echo "node_modules/" >> .gitignore
   echo "__pycache__/" >> .gitignore
   ```

6. Commituj `.gitignore`:
   ```bash
   git add .gitignore
   git commit -m "Dodaj .gitignore"
   git push
   ```