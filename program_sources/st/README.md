# nyankittone's st fork
This is my own patched version of Suckless's terminal emulator, [`st`](https://st.suckless.org/).
It contains only a couple patches for the things I care about.

Included patches are:
* [w3m](https://st.suckless.org/patches/w3m/)
* [bold-is-not-bright](https://st.suckless.org/patches/bold-is-not-bright/)
* [clickurl-nocontrol](https://st.suckless.org/patches/clickurl-nocontrol/)
* [title-parsing-fix](https://st.suckless.org/patches/title_parsing_fix/)
* [workingdir](https://st.suckless.org/patches/workingdir/)
* [glyph-wide-support](https://st.suckless.org/patches/glyph_wide_support/) (haven't tested to ensure this patch actually works)
* [desktopentry](https://st.suckless.org/patches/desktopentry/) (with a few tweaks)

I do not have patches for implementing some common stuff like scrolling, as I don't need it. `tmux`
implements scrolling on its own for me, so I just use that instead of splicing in support into my
terminal that will never get used.

The colorscheme used by default is based on Catppuccin Mocha.

# Requirements
In order to build st you need the Xlib header files.

# Installation
Edit config.mk to match your local setup (st is installed into
the /usr/local namespace by default).

Afterwards enter the following command to build and install st (if
necessary as root):

```sh
make clean install
```

Alternatively, this patched version of `st` allows you to install the program to your local user's
bin directory, like so:

```sh
make localinstall
```

or:
```sh
make l
```

This allows you to install the program without root privilages, but doing this will not install
the manpages for `st`.

# Running st
If you did not install st with make clean install, you must compile
the st terminfo entry with the following command:

    tic -sx st.info

See the man page for additional details.

# Credits
Based on Aurélien APTEL <aurelien dot aptel at gmail dot com> bt source code.

Also, check the credits for each of the included patches.

