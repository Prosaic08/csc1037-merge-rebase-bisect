#!/usr/bin/zsh

RANDOM=$$

sed -i '/^comment/ d' arithmetic.py
print "#comment $RANDOM" >> arithmetic.py
