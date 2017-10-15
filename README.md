## Bash Git

Bash script that shows out current branch name if current working directory is a git repo.

-----

### Installation

Clone the repo somewhere in your machine and just source `git-cli.sh` on the end of your user `.bashrc`


```bash
source <path to cloned repo>/bash-git.sh
```

and restart your terminal.


------

Folder with git:

```bash
~/Projects/cli master* > {command} 
```

Folder without git:

```bash
~/Projects/cli > {command} 
```

Line is composed of 4 parts:

- current path (`~/Projects/cli`)
- (shown only in git folder) branch name (`master`) with one of 3 possible colours (red, green and yellow)
- (shown only in git folder) `*` only shows if current git repo has new files that are still not in repo
- `>` is simple separator that can be in 2 colours depending if previous command was successful or not



