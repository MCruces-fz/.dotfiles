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
+ [Setup on a New Device](#setup-on-a-new-device)
+ [Create your Own Repository](#create-your-own-repository)
+ [Track Files](#track-files)
+ [Restore Configurations](#restore-configurations)
+ [Additional Commands](#additional-commands)

## Screenshots

![Awesome WM](Pictures/screenshot_2.png)

  ...                                    |  ...
:---------------------------------------:|:---------------------------------------:
![Awesome WM](Pictures/screenshot_3.png) | ![Awesome WM](Pictures/screenshot_4.png)
![Awesome WM](Pictures/screenshot_1.png) | ![Awesome WM](Pictures/screenshot_5.png)

## Introduction

This repository contains my personal configuration files (also known as
*dotfiles*). In the following sections I'll explain how this dotfiles 
repository was set up, how to use it and how to restore them, for example 
on a new device.

## Setup on a New Device

Easy peasy lemon squeezy
```bash
git clone --bare https://github.com/MCruces-fz/.dotfiles "$HOME/.dotfiles"
alias dotager="/usr/bin/env git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"
dotager reset  # --soft (HEAD), --mixed (HEAD + index), --hard (HEAD + index + files)
dotager clean -fd
```

***Note:*** This is for my personal use. You can copy all you want, but I recommend
following the steps below.

## Create your Own Repository

To convert your `$HOME` directory into a Git repository you need to use a *bare-one*, 
if not, it could be a little messy.

Setup a bare git repository in your home directory
```bash
git init --bare "$HOME/.dotfiles"
```
Bare repositories have no working directory, so setup an alias to avoid 
typing the long command
```bash
echo 'alias dotager="/usr/bin/env git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"' \
    >> "$HOME/.zshrc"
source "$HOME/.zshrc"
```
Add the git directory `~/.dotfiles/` to the gitignore as a security measure.
```bash
echo '.dotfiles' >> "$HOME/.gitignore"
dotager add "$HOME/.gitignore"
dotager commit -m 'Git: Add gitignore'
```
Setup remote and push.
```bash
dotager remote add origin https://github.com/<username>/.dotfiles
dotager push --set-upstream origin master
```

If you want, you can hide untracked files when querying the status
```bash
dotager config --local status.showUntrackedFiles no
```
but I prefer add a *black-list* to `.gitignore` and choose which files belong to *white-list*, one by one
```bash
# .gitignore

# B L A C K L I S T 
# Before asking, all to Blacklist
/*

# W H I T E L I S T 
# Git
!.gitignore

# Shell
!.bashrc

# Configs
!.config/
.config/*

# Neovim
!.config/nvim
.config/nvim/*
!.config/nvim/init.vim

# [...]
```

***Note:*** The name `dotager` is an acronym of **dot**files man**ager**

## Track Files

Use the default git subcommands to track, update and remove files. You can
obviously also use branches and all other features of git.
```bash
dotager status
dotager add .zshrc
dotager commit -m 'Zsh: Add zshrc'
dotager add .config/nvim/init.vim
dotager commit -m 'Nvim: Update init.vim'
dotager push
```

To remove a file from the repository while keeping it locally you can use:
```bash
dotager rm --cached ~/.some_file
```

If you have a *black-list* and *white-list* in your `gitignore` as I have shown 
in previous section, you can move to the staging area all untracked changes (belonging
to the *white-list*, of course) with
```bash
dotager add --all
```
instead of add one by one.

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

If you want to add new features to your own `dotager` function, create new *cases*
into the flow control command
```bash
case "$1" in
    case-1)
        dotager [command-1]
        ;;
    case-2)
        dotager [command-2]
        ;;
    *)
        /usr/bin/env git --git-dir="$HOME/.dotfiles/" --work-tree="$HOME" "$@"
        ;;
esac
```
where `case-1`, `case-2` are the names you will use
```bash
dotager case-1
```
and bash will execute
```bash
/usr/bin/env git --git-dir="$HOME/.dotfiles/" --work-tree="$HOME" [command-1]

```

### ZSH Tip

`compdef` can provide `zsh` autocompletion of the `git` command for your
equivalent `dotager` command.

```bash
compdef dotager='git'
```
