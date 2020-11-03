That branch contains and implementation of the function square(n).

The original implementation of square(n) is correct.

However, at some point, and error was introduced.

Your task is to find the offending commit and revert it.

There are a lot of commits!

Try this:

   $ git log --oneline --graph

Use "git bisect" to find the offending commit.

Then use "git revert" to revert that commit.

You can use "git log" to find which commits are known good and known bad:

- This recent commit is known bad:

    240b7237c663d90f2c0c1b68b4634b992a7d0775

- This old commit is known good:

    cdd621f16f028b18e88a87a1c6823048521349bb
