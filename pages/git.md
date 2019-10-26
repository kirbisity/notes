# Git

[Back](../README.md)

### List of Contents

* [Basic commands](#basic-commands)

## Git concept



## Basic commands

* `git pull`  copy from remote to local

  ```
  
  ```

  

* `git status`  show current repository information

* `git add`  add a file to the index

  * ```shell
    git add -A  # add everything other than .gitignore
    ```

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

