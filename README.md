This fork has shut down
=======================

This fork is deprecated and is no longer reviewing or merging changes. Please
rebase / re-clone [the original repo][original] and open new issues and PRs
there.

This repo serves as historical record of the fork.

- https://github.com/zsh-users/prezto/issues/44
- https://github.com/zsh-users/prezto/issues/26
- https://github.com/sorin-ionescu/prezto/issues/1239
- https://github.com/sorin-ionescu/prezto/issues/1269

&mdash; @facastagnini, @johnpneumann, and @paulmelnikow

* * *

[![Gitter](https://badges.gitter.im/zsh-users/prezto.svg)](https://gitter.im/zsh-users/prezto?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge)

Prezto — Instantly Awesome Zsh
==============================

Prezto is the configuration framework for [Zsh][1]; it enriches the command line
interface environment with sane defaults, aliases, functions, auto completion,
and prompt themes.

Upgrading from sorin-ionescu/prezto
-----------------------------------

Prezto's [original maintainer][original] abandoned the project. This is a
young, community-maintained fork, which was created [in December 2016][fork].

To upgrade your Prezto installation to use the new fork, run these commands:

    cd "${ZDOTDIR:-$HOME}/.zprezto"
    git remote set-url origin https://github.com/zsh-users/prezto.git
    git pull
    git submodule update --init --recursive

This assumes a typical installation. If you have forked or modified the
project your steps may vary.

[original]: https://github.com/sorin-ionescu/prezto
[fork]: https://github.com/sorin-ionescu/prezto#1239

Installation
------------

Prezto will work with any recent release of Zsh, but the minimum required
version is 4.3.17.

  1. Launch Zsh:

        zsh

  2. Clone the repository:

        git clone --recursive https://github.com/zsh-users/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"

  3. Create a new Zsh configuration by copying the Zsh configuration files
     provided:

        setopt EXTENDED_GLOB
        for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
          ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
        done

  4. Set Zsh as your default shell:

        chsh -s /bin/zsh

  5. Open a new Zsh terminal window or tab.

### Troubleshooting

If you are not able to find certain commands after switching to *Prezto*,
modify the `PATH` variable in *~/.zprofile* then open a new Zsh terminal
window or tab.

Updating
--------

Make sure you are tracking this fork:

    $ git remote -v
    origin  https://github.com/zsh-users/prezto.git (fetch)
    origin  https://github.com/zsh-users/prezto.git (push)

If you see `sorin-ionescu` instead of `zsh-users`, update your remote:

    git remote set-url origin https://github.com/zsh-users/prezto.git

Then pull the latest changes and update submodules.

    git pull && git submodule update --init --recursive

Usage
-----

Prezto has many features disabled by default. Read the source code and
accompanying README files to learn of what is available.

### Modules

  1. Browse */modules* to see what is available.
  2. Load the modules you need in *~/.zpreztorc* then open a new Zsh terminal
     window or tab.

### Themes

  1. For a list of themes, type `prompt -l`.
  2. To preview a theme, type `prompt -p name`.
  3. Load the theme you like in *~/.zpreztorc* then open a new Zsh terminal
     window or tab.

     ![sorin theme][2]

Customization
-------------

The project is managed via [Git][3]. It is highly recommended that you fork this
project; so, that you can commit your changes and push them to [GitHub][4] to
not lose them. If you do not know how to use Git, follow this [tutorial][5] and
bookmark this [reference][6].

Resources
---------

The [Zsh Reference Card][7] and the [zsh-lovers][8] man page are indispensable.

Project leaders
---------------

These are the active contributors that donate time on a consistent basis to help guide the project:

* [facastagnini](https://github.com/facastagnini)
* [johnpneumann](https://github.com/johnpneumann)
* [paulmelnikow](https://github.com/paulmelnikow)

License
-------

This project is licensed under the MIT License.

[1]: http://www.zsh.org
[2]: http://i.imgur.com/nrGV6pg.png "sorin theme"
[3]: http://git-scm.com
[4]: https://github.com
[5]: http://gitimmersion.com
[6]: http://gitref.org
[7]: http://www.bash2zsh.com/zsh_refcard/refcard.pdf
[8]: http://grml.org/zsh/zsh-lovers.html
