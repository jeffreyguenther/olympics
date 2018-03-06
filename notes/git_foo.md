# git Foo

To allows myself to integrate the lessons I learned from my benchmarking experiment,
done in separate branch quite without regard for code cleanliness as I was
learning and experimenting and didn't know how the pieces would all need to
fit together in the end, I used `git worktree`.

`git worktree` allows you to create a folder based on a particular branch
that you can use as if it were the main repo. In short, it allows you to have
two branches checked out at the same time without duplicating the repo, which
is important if a repo has been a while for any length of time.

Also, to help myself keep my fingers near the keyboard, I've started to use
`git add -i` to manipulate the files I want to stage and commit.

I've also used `git rebase` to clean up a mistake I made where I forgot to add a
file to a commit and didn't realize until a couple commits later after I had
pushed to GitHub. Normally, I'd just create another commit to add the file,
however because I'm working on this exercise alone, I am able to force push to
my remote, so I edited the history and forced pushed my changes.
