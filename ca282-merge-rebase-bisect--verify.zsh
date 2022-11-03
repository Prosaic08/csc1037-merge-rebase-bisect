#!/usr/bin/zsh

user=$argv[1]

mark () {
  if [[ $#argv == 0 ]]
  then
    print "#mark" $user 1
  else
    print "#mark" $user $argv[1]
  fi
}

no_pyc () {
  for pyc in *.pyc(.N)
  do
    print $pyc
    mark -1
  done
}

# ######################################################
# task 1

if git merge-base --is-ancestor origin/subtract master
then
  mark
fi

if git merge-base --is-ancestor origin/multiply master
then
  mark
fi

no_pyc

test_python_1 ()
{
  python2 <<EOF
import arithmetic
print arithmetic.subtract(101, 2)
print arithmetic.multiply(11, 9)
EOF
}

test_python_1 | grep -w 99 | wc -l | read count
mark $count

# ######################################################
# task 2

test_python_2 ()
{
  python2 <<EOF
import arithmetic
print arithmetic.divide(81, 9)
EOF
}

if git merge-base --is-ancestor master origin/divide
then
  mark 1
  #
  find . -type f -name '*.pyc' -delete
  if git checkout --quiet --track origin/divide
  then
    no_pyc

    if test_python_2 | grep -q -w 9
    then
      mark 4
    fi
  fi
fi

# ######################################################
# task 3

test_python_3 ()
{
  python2 <<EOF
import arithmetic
print arithmetic.square(20)
EOF
}

find . -type f -name '*.pyc' -delete
if git checkout --quiet --track origin/square
then
  no_pyc

  if test_python_3 | grep -q -w 400
  then
    mark 2
  fi

  if git log | grep -q "reverts.*fd8fbca9ca6ba859038f4c2e32d5fac0b0e2e743"
  then
    mark 2
  fi
fi
