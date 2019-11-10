# Git

[Back](../README.md)

https://git-scm.com/

### List of Contents

* [Basic commands](#basic-commands)
* [Rebase workflow](#rebase-workflow)
* [Sample workflow](#sample-workflow)

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

* ##### `git commit`  commit to local repository

  * ```shell
    git commit -m "message" # add a commit message
    ```

* `git log`  see the commit history

  * ```shell
    git log --decorate --online --graph # show as a tree graph
    ```

* `git checkout <commit hash> <file path>` revert a file to earlier commit

##### Ignoring files

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

##### Removing a file

* `rm`  removes a file from the working directory only
* `git rm`  removes a file from the index and working directory
* `git rm`  --cached  removes a file from the index only
* `git rm -f`  removes a file from the index and working directory even if there are unstaged changes

##### Undo an add

* `git reset HEAD <file>`  Undo a git add

##### Undo a unshared commit

* `git reset`  undo local changes that have not yet been shared
* `git reset --hard` will also undo the changes in the working directory 

##### Undo a shared commit

* `git revert`  revert changes that have already been shared
* `git revert HEAD`  reverses the latest commit
* `git revert` will create a new commit

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

   then `git rebase --continue`  

5. `git push -f origin <branch>`

##### Organize the commit history

* `git rebase -i`  starts an interactive rebasing session
  * fixup redundant commits together, or rename etc.

[Back To Top](#list-of-contents)

## Sample workflow

**Fork**
We have a repo  `<org name>/<repo name>` , let's fork it into  `<your name>/<repo name>`

* Now anything you do to in  `<your name>/<repo name>` , which is **origin**, will not affect  `<org name>/<repo name>`, which is **upstream**. 
* If we want to get our change into upstream. We would create a pull request.

**Clone**

Using `git clone` to download the origin repo into a local directory.

**Add**

Do the work in local working directory.  When finished use `git add` to add file to the index.

* create a `.gitignore` file to ignore some unwanted files like executables or libraries.
* use `git add -p` to partially add file.

**Commit**

Use `git commit` to commit local repository. 

* see the commit history by using `git log`
* see a specific commit changes by using `git show <commit hash>`

**Rebase**

At this point, the upstream might have some new changes to it. Use `git rebase`  to make sure our branch stay at the top.

* `git rebase -i`  can rename, drop and merge commits together
* Resolve the merge conflicts if any, then `git rebase --continue`  

**Push**

Use `git push` to push local change to origin.

* if rebase is used, we might want to force push to rewrite history.

**Pull request**

Create a pull request across forks, use upstream as base and origin as head. If the reviews and tests are ok, we can merge change into it final destination.

[Back To Top](#list-of-contents)