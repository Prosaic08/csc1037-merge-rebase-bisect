#!/usr/bin/zsh

RANDOM=$$

sed -i '/^#comment/ d' arithmetic.py
print "#comment $RANDOM" >> arithmetic.py

git commit -a -m "There is not information in this commit message."
