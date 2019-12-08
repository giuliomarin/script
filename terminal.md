# Bash

## Find git repositories
```find ~ -type d -name .git```

## List contributions for eah git folder
```for f in `find . -name .git -maxdepth 2`; do pushd $f; printf "\n------\nFolder: $f\n\n"; git log --pretty=format:"%an" | sort | uniq -c | sort -r | head; popd; done```

## TODO: setup ssh
http://www.ece.uci.edu/~chou/ssh-key.html

# Find hpp files with using namespace
grep -rin --include \*.hpp "using namespace" .

# git

## Format log and show graph
```git log --pretty=format:'%m %Cred %an %Cblue %ar %n %Creset %B %n' --graph```

# LaTex

## Show difference of two versions
```latexdiff —flatten old.tex new.tex > differences.tex```
