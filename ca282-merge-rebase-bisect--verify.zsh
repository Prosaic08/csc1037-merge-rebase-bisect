#!/usr/bin/zsh

python="python2.7"

# If you want to use this script, then you probably want to copy
# it to somewhere outside of the reop.

# Usage... either:
#
#    $ zsh ../ca282-merge-rebase-bisect--verify.zsh
#    (examine the repo in the current working directory)
#
# or:
#
#    $ zsh ../ca282-merge-rebase-bisect--verify.zsh DIRECTORY
#    (examine the repo in DIRECTORY)

integer points=0

atexit () {
   print $points
}
trap atexit EXIT

[[ $#argv == 0 ]] && set -- "."
cd $argv[1]

if [[ -n $( git status -s ) ]]
then
   print "error: you have uncommitted work"
   print "       refusing to run"
   exit
fi >&2

# Checkout the various branches.
set -e
for branch in subtract multiply divide square master
do
   git checkout $branch
done
set +e

# Verify that both subtract and multiply have been merged.
#
git merge-base --is-ancestor subtract master && points+=1
git merge-base --is-ancestor multiply master && points+=1

# Poor-man's test of the various functions.
#
git checkout -q master
$python -c "import arithmetic; print arithmetic.add(8, 9)" | grep -q -w 17
$python -c "import arithmetic; print arithmetic.subtract(18, 5)" | grep -q -w 13 && points+=1
$python -c "import arithmetic; print arithmetic.multiply(5, 7)" | grep -q -w 35 && points+=1
[[ -f arithmetic.pyc ]] && rm arithmetic.pyc

# Verify that master is now an ancestor of divide.
#
git checkout -q divide
git merge-base --is-ancestor master divide && points+=3

# Poor-man's test of the various functions.
#
$python -c "import arithmetic; print arithmetic.add(8, 9)" | grep -q -w 17
$python -c "import arithmetic; print arithmetic.subtract(18, 5)" | grep -q -w 13
$python -c "import arithmetic; print arithmetic.multiply(5, 7)" | grep -q -w 35
$python -c "import arithmetic; print arithmetic.divide(45, 5)" | grep -q -w 9 && points+=1
[[ -f arithmetic.pyc ]] && rm arithmetic.pyc

git checkout -q square
git merge-base --is-ancestor 58f763c6c98476f4bdc890372c5c3b1ff41083f2 square && points+=2

# Poor-man's test of the various functions.
#
$python -c "import arithmetic; print arithmetic.add(8, 9)" | grep -q -w 17
$python -c "import arithmetic; print arithmetic.square(12)" | grep -q -w 144 && points+=2
[[ -f arithmetic.pyc ]] && rm arithmetic.pyc

cat <<EOF
Your repo will also be manually reviewed for issues which this script isn't
able to detect.

EOF
