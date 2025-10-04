### Zadanie 9: Git Blame

#### Cel:
Znaleźć, kto zmienił konkretną linię

#### Kroki:

1. Zobacz, kto zmienił README.md:
   ```bash
   git blame README.md
   ```

2. Zobacz autora konkretnych linii (np. 1-5):
   ```bash
   git blame -L 1,5 README.md
   ```