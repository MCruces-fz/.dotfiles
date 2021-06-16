<div align="center">
    <h1>.dotfiles</h1>
    <p>Welcome <b><code>~</code></b> !</p>
    <p>
    <!-- <img src="https://....svg" /> -->
    <!-- <img src="https://....svg" /> -->
    <!-- <br><br> -->
    <!-- <img src="pictures/dotfiles.png"> -->
    </p>
</div>

## Table of Contents

+ [Screenshots](#screenshots)
+ [Introduction](#introduction)
+ [Setup Repository](#setup-repository)
+ [Track Files](#track-files)
+ [Restore Configurations](#restore-configurations)
+ [Additional Commands](#additional-commands)

## Screenshots

![Awesome WM](Pictures/screenshot_2.png)

...                        |  ...
:-------------------------:|:-------------------------:
![Awesome WM](Pictures/screenshot_3.png) | ![Awesome WM](Pictures/screenshot_4.png)
:-------------------------:|:-------------------------:
![Awesome WM](Pictures/screenshot_1.png) | ![Awesome WM](Pictures/screenshot_5.png)

## Introduction

This repository contains my personal configuration files (also known as
*dotfiles*). In the following sections I'll explain how this dotfiles 
repository was set up, how to use it and how to restore them, for example 
on a new device.

## Setup Repository

Setup a bare git repository in your home directory. Bare repositories have no
working directory, so setup an alias to avoid typing the long command. Add the
git directory `~/.dotfiles/` to the gitignore as a security measure. Setup
remote and push. Hide untracked files when querying the status.

```bash
git init --bare "$HOME/.dotfiles"

echo 'alias dotager="/usr/bin/env git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"' \
    >> "$HOME/.zshrc"
source "$HOME/.zshrc"

echo '.dotfiles' >> "$HOME/.gitignore"
dotager add "$HOME/.gitignore"
dotager commit -m 'Git: Add gitignore'

dotager remote add origin https://github.com/MCruces-fz/.dotfiles
dotager push --set-upstream origin master
dotager config --local status.showUntrackedFiles no
```

***Note:*** The name `dotager` is an acronym of **dot**files man**ager**

## Track Files

Use the default git subcommands to track, update and remove files. You can
obviously also use branches and all other features of git.

```bash
dotager status
dotager add .zshrc
dotager commit -m 'Zsh: Add zshrc'
dotager add .vimrc
dotager commit -m 'Vim: Add vimrc'
dotager push
```

To remove a file from the repository while keeping it locally you can use:

```bash
dotager rm --cached ~/.some_file
```

## Restore Configurations

First clone dependent repositories, in this case for example `oh-my-zsh`. Clone
your dotfiles repository as bare repository. Setup temporary alias and then
checkout. If there exist files that collide with your repository (like a default
`.bashrc`), the files will be moved to `~/.dotfiles.bak/`. Then update all
submodules and again hide untracked files when querying the status.

```bash
git clone https://github.com/robbyrussell/oh-my-zsh \
    "$HOME/.oh-my-zsh"

git clone --bare --recursive https://github.com/MCruces-fz/.dotfiles \
    "$HOME/.dotfiles"

function dotager() {
    /usr/bin/env git --git-dir="$HOME/.dotfiles/" --work-tree="$HOME" "$@"
}

dotager checkout
if [ "$?" -ne 0 ]; then
    mkdir -p "$HOME/.dotfiles.bak"
    dotager checkout 2>&1 \
        | grep -P '^\s+[\w.]' \
        | awk {'print $1'} \
        | xargs -I{} sh -c 'cp -r --parents "{}" "$HOME/.dotfiles.bak/" && rm -rf "{}"'
    dotager checkout
fi

dotager submodule update --recursive --remote
dotager config --local status.showUntrackedFiles no
```

Note that the automatic moving of already existing (thus conflicting) files
fails if there are too many of them (git cuts the message at some point).

The short variant, using a script with the commands above:

```bash
. <(curl -Ls https://dotfiles.mariya.ch)
```

(Note: This is for my personal use. Instead of directly sourcing the install
script, you should save it somewhere on your system and review it.)

## Additional Commands

Instead of the alias provided above, you can use following function. `listall`
will show all tracked files, `listtree` will show those files in a tree format
(requires the package `treeify`). You may need to use a pager for these
commands.

```bash
dotager() {
    case "$1" in
        listall)
            shift
            dotager ls-tree --full-tree -r --name-only HEAD "$@"
            ;;
        listtree)
            shift
            if hash treeify 2>/dev/null; then
                dotager ls-tree --full-tree -r --name-only HEAD "$@" | treeify
            else
                dotager listall
            fi
            ;;
        *)
            /usr/bin/env git --git-dir="$HOME/.dotfiles/" --work-tree="$HOME" "$@"
            ;;
    esac
}
```

`compdef` can provide `zsh` autocompletion of the `git` command for your
equivalent `dotager` command.

```bash
compdef dotager='git'
```
