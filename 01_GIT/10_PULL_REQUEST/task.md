### Zadanie 10: Praca z Pull Request (GitHub)

#### Cel:
Nauczyć się workflow z Pull Request

#### Kroki:

1. Utwórz branch:
   ```bash
   git checkout -b feature/nowa-funkcja
   ```

2. Wprowadź zmiany:
   ```bash
   echo "## Nowa funkcja" >> README.md
   git add README.md
   git commit -m "Dodaj nową funkcję"
   ```

3. Wypchnij branch na GitHub:
   ```bash
   git push -u origin feature/nowa-funkcja
   ```

4. Wejdź na GitHub - zobaczysz przycisk **"Compare & pull request"**

5. Kliknij przycisk i utwórz Pull Request:
   - Tytuł: "Dodaj nową funkcję"
   - Opis: "Ta zmiana dodaje..."
   - Kliknij **"Create pull request"**

6. (Opcjonalnie) Poproś kogoś o code review

7. Zmerguj Pull Request na GitHub (przycisk **"Merge pull request"**)

8. Pobierz zmiany lokalnie:
   ```bash
   git checkout main
   git pull
   ```

9. Usuń lokalny branch:
   ```bash
   git branch -d feature/nowa-funkcja
   ```
