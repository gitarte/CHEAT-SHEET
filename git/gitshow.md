# gitshow
### Założymy sobie repo w GitHub i sklonujemy je na swój komputer
```bash
git clone https://github.com/user/xxx.git
cd xxx
git status
git log
```

### Skonfigurujemy repo tak, żeby ignorowało pliki *conf
```bash
echo '*.conf' > .gitignore
```

### Symulujemy pierwsze prace programistyczne dodając dwa pliki:
```bash 
echo 'print(lala print);' > main.py
echo 'lala=conf'          > main.conf
ls
git status
git add .
git status
git commit -am "add main.py"
git status
git push
git log
```

### Symulujemy pracę w grupie modyfikując plik ```main.py``` na stronie naszego repo w GitHub'ie (usuwamy średnik)
```bash
# sprawdzam czy jest potrzeba lokalnej aktualizacji
git fetch origin master
git diff FETCH_HEAD
# aktualizuję
git pull origin master
```

### Tworzymy własną gałąź w repo
```bash
git branch
git checkout -b new_emergency
git branch
echo 'print("lala print")' > main.py
git status
git commit -am "fix new_emergency"
git status
git push -u origin new_emergency
```

### Merdżujemy się do mastera
```bash
git checkout master
git branch
git diff  new_emergency
git merge new_emergency
git status
git push
```

### Cofanie ostatniego commita
```bash
git log
git revert [wstaw ID]
git status
git push
```

### Usuwanie obiektów
```bash
rm main.py 
git status 
git rm main.py 
git status 
git commit -am "remove main.py"
git push
```

### Sprawdzenie zawartości historycznego commita
```bash
git log
git checkout [wstaw ID]
cat main.py
git checkout master
```

### Przywrócenie pliku z historycznego commita
```bash
git checkout [wstaw ID] -- main.py
git add .
git commit -am "restore main.py"
git push
```
