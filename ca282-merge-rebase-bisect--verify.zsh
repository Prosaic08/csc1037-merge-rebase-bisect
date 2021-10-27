#!/usr/bin/zsh

python="python2.7"

# Usage... either:
#
#    $ zsh ca282-merge-rebase-bisect--verify.zsh
#    (examine the repo in the current working directory)
#
# or:
#
#    $ zsh ca282-merge-rebase-bisect--verify.zsh DIRECTORY
#    (examine the repo in DIRECTORY)

if [[ $#argv == 0 ]]
then
   set -- "."
fi

set -e  # Fail on any error.
cd $argv[1]
set -x  # Show commands before executing them.

# Verify that both subtract and multiply have been merged.
#
git merge-base --is-ancestor origin/subtract master
git merge-base --is-ancestor origin/multiply master

# Poor-man's test of the various functions.
#
git checkout -q master
$python -c "import arithmetic; print arithmetic.add(8, 9)" | grep -q -w 17
$python -c "import arithmetic; print arithmetic.subtract(18, 5)" | grep -q -w 13
$python -c "import arithmetic; print arithmetic.multiply(5, 7)" | grep -q -w 35
[[ -f arithmetic.pyc ]] && rm arithmetic.pyc

# Verify that master is now an ancestor of divide.
#
git checkout -q divide
git merge-base --is-ancestor master divide

# 5e40b498 is a commit from the divide branch which should not have been affected by
# the rebase, and so should still be present in the rebased version of the divide branch.
#
# Check that 5e40b498 is still present in the log.
#
git log --oneline | grep -q -w 5e40b498

# Poor-man's test of the various functions.
#
$python -c "import arithmetic; print arithmetic.add(8, 9)" | grep -q -w 17
$python -c "import arithmetic; print arithmetic.subtract(18, 5)" | grep -q -w 13
$python -c "import arithmetic; print arithmetic.multiply(5, 7)" | grep -q -w 35
$python -c "import arithmetic; print arithmetic.divide(45, 5)" | grep -q -w 9
[[ -f arithmetic.pyc ]] && rm arithmetic.pyc

git checkout -q square
git merge-base --is-ancestor 58f763c6c98476f4bdc890372c5c3b1ff41083f2 square

# Poor-man's test of the various functions.
#
$python -c "import arithmetic; print arithmetic.add(8, 9)" | grep -q -w 17
$python -c "import arithmetic; print arithmetic.square(12)" | grep -q -w 144
[[ -f arithmetic.pyc ]] && rm arithmetic.pyc

set +x
cat <<EOF

okay

Your repo will also be manually reviewed for issues which this script isn't
able to detect.
EOF
