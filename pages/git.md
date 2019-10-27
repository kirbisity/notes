# Git

[Back](../README.md)

https://git-scm.com/

### List of Contents

* [Basic commands](#basic-commands)
* [Rebase workflow](#rebase-workflow)

## Git concept



## Basic commands

* `git pull`  copy from remote to local

* `git add`  add a file to the index

  * Interactive Patching

    ```shell
    git add -p # Interactively choose what modification to add
    ```

    https://git-scm.com/book/en/v2/Git-Tools-Interactive-Staging

* `git status`  show current repository information

* `git commit`  commit to local repository

  * ```shell
    git commit -m "message" # add a commit message
    ```

* `git log`  see the commit history

  * ```shell
    git log --decorate --online --graph # show as a tree graph
    ```

* `git checkout <commit hash> <file path>` revert a file to earlier commit

#### Ignoring files

* Create a `.gitignore`  at the **root of the repository** with information about the ignorable files

  ```shell
  # ignore all files with certain extensions
  *.swp
  *.0
  *.tsk 
  # ignore all files under a folder
  folder/*
  # but keep track of some files under this folder
  !folder/vipfile.txt
  # keep an empty directory by adding a .gitkeep (git cannot have empty directory)
  !folder/vipfolder
  !folder/vipfolder/.gitkeep
  ```

#### Removing a file

* `rm`  removes a file from the working directory only
* `git rm`  removes a file from the index and working directory
* `git rm`  --cached  removes a file from the index only
* `git rm -f`  removes a file from the index and working directory even if there are unstaged changes

[Back To Top](#list-of-contents)

## Rebase workflow

https://git-scm.com/docs/git-rebase

Rebase is moving and combining a sequence of commits to a new base commit.

```
      A---B---C topic
     /
D---E---F---G master
```

```
              A---B---C topic
             /
D---E---F---G master
```

Use rebase when the master branch has new commits while you are working on a different fork or branch. So that it looks like your work start from the latest master.

##### Example

The following example assumes you work on a forked repository and made some changes. However, before the work is merged, the original repository has some new commits. So we need to rebase to make the commit history clean.

1. `git remote add upstream <original repository>`
2. `git fetch upstream`
3. `git rebase upstream/master`
4. Resolve the merge conflicts if any
5. `git push -f origin <branch>`

##### Organize the commit history

* `git rebase -i`  starts an interactive rebasing session

[Back To Top](#list-of-contents)

