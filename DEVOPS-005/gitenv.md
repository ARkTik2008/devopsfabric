# How to configure git to use the name and email from environment variables

**Docs from git help commit says**:

> COMMIT INFORMATION
> Author and committer information is taken from the following environment variables, if set:
> GIT_AUTHOR_NAME
> GIT_AUTHOR_EMAIL
> GIT_AUTHOR_DATE
> GIT_COMMITTER_NAME
> GIT_COMMITTER_EMAIL
> GIT_COMMITTER_DATE

Also, to set the name and email of the author from environment variables, we need to use **those commands**:
```bash
export GIT_AUTHOR_NAME="Bob Marley"
export GIT_AUTHOR_EMAIL="bmarley@fabric.baikalteam.com"
export GIT_COMMITTER_NAME="Bob Marley"
export GIT_COMMITTER_EMAIL="bmarley@fabric.baikalteam.com"
```

And then we can check them by typing
```bash
env | grep GIT_
GIT_COMMITTER_NAME=Bob Marley
GIT_AUTHOR_EMAIL=bmarley@ubuntu
GIT_COMMITTER_EMAIL=bmarley@ubuntu
GIT_AUTHOR_NAME=Bob Marley
```

After that we can commit as Bob Marley without any additional keys or config changes:
```bash
git commit -m "DEVOPS-005 added DEVOPS-005/gitenv.md"
# Output:
[DEVOPS-005-bob-git-branching 258b709] DEVOPS-005 added DEVOPS-005/gitenv.md
 1 file changed, 24 insertions(+)
 create mode 100644 DEVOPS-005/gitenv.md
```

Setting up the name and email of the author from environment variables for **Snoop Dogg**:
```bash
export GIT_AUTHOR_NAME="Snoop Dogg"
export GIT_AUTHOR_EMAIL="sdogg@ubuntu"
export GIT_COMMITTER_NAME="Snoop Dogg"
export GIT_COMMITTER_EMAIL="sdogg@ubuntu"
```

And then we can check them by typing
```bash
env | grep GIT_
GIT_COMMITTER_NAME=Snoop Dogg
GIT_AUTHOR_EMAIL=sdogg@ubuntu
GIT_COMMITTER_EMAIL=sdogg@ubuntu
GIT_AUTHOR_NAME=Snoop Dogg
```

All done.
