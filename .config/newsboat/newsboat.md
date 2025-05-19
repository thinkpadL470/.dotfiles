# The Newsboat RSS Feedreader

Table of Contents

  * 1\. Introduction
    * 1.1. Platforms
    * 1.2. Why "Newsboat"?
  * 2\. Installation
    * 2.1. Pre-built binaries
    * 2.2. From source
  * 3\. First Steps
    * 3.1. Adding Feeds
    * 3.2. First UI Interaction
  * 4\. Configuration
    * 4.1. Example
    * 4.2. Splitting long lines into multiple ones
    * 4.3. Using Double Quotes
    * 4.4. Shell Evaluation
    * 4.5. Escaping
    * 4.6. Key Bindings
    * 4.7. Old Style Key Bindings
    * 4.8. Colors
    * 4.9. Files
  * 5\. Migrating from other RSS Feed Readers
    * 5.1. Newsbeuter (automatic migration)
    * 5.2. Other readers (via OPML)
  * 6\. Newsboat as a Client for Newsreading Services
    * 6.1. The Old Reader
    * 6.2. NewsBlur
    * 6.3. FeedHQ
    * 6.4. Bazqux
    * 6.5. Feedbin
    * 6.6. FreshRSS
    * 6.7. Tiny Tiny RSS
    * 6.8. ownCloud News and nextCloud News
    * 6.9. Inoreader
    * 6.10. Miniflux
    * 6.11. OPML Online Subscription Mode
    * 6.12. Passwords for external APIs
  * 7\. Advanced Features
    * 7.1. Tagging
    * 7.2. Scripts and Filters (Snownews Extensions)
    * 7.3. Bookmarking
    * 7.4. Command Line
    * 7.5. Filter Language
    * 7.6. Killfiles
    * 7.7. Query Feeds
    * 7.8. Flagging Articles
    * 7.9. Commandline Commands
    * 7.10. Format Strings
    * 7.11. Highlighting Text
    * 7.12. Advanced Dialog Management
    * 7.13. Macro Support
    * 7.14. Open Links with External Commands
    * 7.15. Podcast Support
    * 7.16. Running multiple copies of Newsboat simultaneously
    * 7.17. Using SQLite Triggers with Newsboat
    * 7.18. Environment variables
  * 8\. Feedback and security
  * Appendix A: Newsboat Configuration Commands
  * Appendix B: Newsboat Operations
  * Appendix C: Podboat Configuration Commands
  * Appendix D: Podboat Operations
  * Appendix E: License

## 1\. Introduction

Newsboat is an RSS/Atom feedreader. RSS and Atom are a number of widely-used
XML formats to transmit, publish and syndicate articles, for example news or
blog articles. Newsboat is designed to be used on text terminals on Unix or
Unix-like systems such as GNU/Linux, FreeBSD or macOS.

### 1.1. Platforms

Newsboat has been tested on Linux (with glibc and musl-libc), FreeBSD and
macOS.

NetBSD is currently not supported, due to technical limitations in the
`iconv()` implementation.

### 1.2. Why "Newsboat"?

"Newsboat" is a play on the name of its ancestor, "Newsbeuter". They're
spelled quite differently, but sound similar. ("Newsbeuter" is a pun on German
word "wildbeuter"; "newsboat" is an English word.)

Newsboats were the vessels that collected and delivered news shuffling between
boats in the port. Newsboat the program will collect the news for you, just
like its namesakes did back in the day.

## 2\. Installation

### 2.1. Pre-built binaries

Newsboat binaries are available in a number of repositories:

  * various Linux and BSD distributions, Homebrew etc.; [here's a non-exclusive list](https://repology.org/project/newsboat);

  * distribution-independent [Snap](https://snapcraft.io/docs/installing-snapd) store:
    
        $ sudo snap install newsboat

### 2.2. From source

#### 2.2.1. Download the source code

The most up-to-date source code can always be downloaded from the Git
repository:

    
    
    $ git clone https://github.com/newsboat/newsboat.git

There are also signed release tarballs available from [our
website](https://newsboat.org/).

#### 2.2.2. Install dependencies

Newsboat depends on a number of libraries, which need to be installed before
Newsboat can be compiled. Make sure to install the header files as well (on
Debian and derivatives, headers are in `-dev` packages, e.g.
`libsqlite3-dev`.)

  * GNU Make 4.0 or newer

  * C++ compiler that accepts `-std=c++17` option: GCC 5.0 or newer, or Clang 5 or newer. If you have libicu 76 or newer, than C++17 support is required as Newsboat indirectly depends on libicu headers via libxml2. Newsboat 2.40 (ETA 2025.06.22) is expected to require a compiler that _supports_ C++17

  * Stable [Rust](https://www.rust-lang.org/en-US/) and Cargo (Rust's package manager) (1.81.0 or newer; might work with older versions, but we don't check that)

  * [STFL (version 0.21 or newer)](https://github.com/newsboat/stfl) (the link points to our own fork because [the upstream](http://www.clifford.at/stfl/) is dead)

  * [SQLite3 (version 3.5 or newer)](https://www.sqlite.org/download.html)

  * [libcurl (version 7.32.0 or newer)](https://curl.haxx.se/download.html)

  * Header files for the SSL library that libcurl uses. You can find out which library that is from the output of `curl --version`; most often that's OpenSSL, sometimes GnuTLS, or maybe something else.

  * GNU gettext (on systems that don't provide gettext in the libc): <ftp://ftp.gnu.org/gnu/gettext/>

  * [pkg-config](https://pkg-config.freedesktop.org/wiki/)

  * [libxml2](http://xmlsoft.org/downloads.html)

  * [json-c (version 0.11 or newer)](https://github.com/json-c/json-c/wiki)

  * [Asciidoctor](https://asciidoctor.org/) (1.5.3 or newer)

  * Some implementation of AWK like [GNU AWK](https://www.gnu.org/software/gawk) or [NAWK](https://github.com/onetrueawk/awk).

Developers will also need:

  * [`xtr` (version 0.1.4 or newer)](https://github.com/woboq/tr) (can be installed with `cargo install xtr`)

  * [Coco/R for C++](http://www.ssw.uni-linz.ac.at/coco/), needed to re-generate filter language parser using `regenerate-parser` target.

#### 2.2.3. Compile and install

There are a few different ways:

  * build inside Docker. For that, check out _doc/docker.md_ in the source tree. Note that the resulting binary might not run outside of that same Docker container if your system doesn't have all the necessary libraries, or if their versions are too old;

  * build in a chroot: to avoid polluting your system with developer packages, or to avoid upgrading, you might use a tool like [`debootstrap`](https://wiki.debian.org/Debootstrap) to create an isolated environment. Once that's done, just build from source as outlined in the next item;

  * build from source:
    
        $ make                   #  pass -jN to use N CPU cores, e.g. -j8
    $ sudo make install      #  install everything under /usr/local

To install to a different directory, pass `prefix` like so: `sudo make
prefix=/opt/newsboat install`. If you're cross-compiling, set
`CARGO_BUILD_TARGET`; see [cargo documentation](https://doc.rust-
lang.org/cargo/reference/config.html#environment-variables) for details.

To uninstall, run `sudo make uninstall`.

## 3\. First Steps

After you've installed Newsboat, you can run it for the first time by typing
`newsboat` on your command prompt. This will bring you the following message:

    
    
    Error: no URLs configured. Please fill the file /home/ak/.newsboat/urls with RSS feed URLs or import an OPML file.
    
    Newsboat 2.22
    usage: ./newsboat [-i <file>|-e] [-u <urlfile>] [-c <cachefile>] [-x <command> ...] [-h]
        -e, --export-to-opml            export OPML feed to stdout
        -r, --refresh-on-start          refresh feeds on start
        -i, --import-from-opml=<file>   import OPML file
        -u, --url-file=<urlfile>        read RSS feed URLs from <urlfile>
        -c, --cache-file=<cachefile>    use <cachefile> as cache file
        -C, --config-file=<configfile>  read configuration from <configfile>
        -X, --vacuum                    compact the cache
        -x, --execute=<command>...      execute list of commands
        -q, --quiet                     quiet startup
        -v, --version                   get version information
        -l, --log-level=<loglevel>      write a log with a certain loglevel (valid values: 1 to 6)
        -d, --log-file=<logfile>        use <logfile> as output log file
        -E, --export-to-file=<file>     export list of read articles to <file>
        -I, --import-from-file=<file>   import list of read articles from <file>
        -h, --help                      this help
            --cleanup                   remove unreferenced items from cache

This means that Newsboat can't start without any configured feeds.

### 3.1. Adding Feeds

To add feeds to Newsboat, you can simply add one feed URL per line to the
_~/.newsboat/urls_ configuration file:

    
    
    http://rss.cnn.com/rss/cnn_topstories.rss
    http://newsrss.bbc.co.uk/rss/newsonline_world_edition/front_page/rss.xml

You can also import an OPML file by running `newsboat -i blogroll.opml`

**Adding comments** Lines that start with `#` can contain anything you want.
Comments are ignored by Newsboat, but can serve as documentation for you.
Please note, that commenting out URLs for debugging purposes might lead to
unexpected data loss, see `cleanup-on-quit` for more details.

**Feeds with restricted access**

If you need to add URLs that have restricted access, simply provide
username/password:

    
    
    https://username:password@hostname.domain.tld/feed.rss

In case there is a _@_ in the username, you need to write it as _%40_.

In order to protect usernames and passwords, make sure to restrict read access
for _~/.newsboat/urls_ to you and optionally your group:

    
    
    $ chmod u=rw,g=r,o= ~/.newsboat/urls

Newsboat makes sure to not display usernames and passwords in its user
interface.

**Local files as feeds**

You can also configure local files as feeds, by prefixing the local path with
`file://` and adding it to the _urls_ file:

    
    
    file:///var/log/rss_eventlog.xml

### 3.2. First UI Interaction

The main UI of Newsboat consists of three views

_Feed List View -> Article List View -> Article View_

You can drill down those views by pressing `Enter` and move to the previous
one by pressing `Q`. Pressing `Q` on the _Feed List View_ — or pressing
`Shift`+`Q` from anywhere — closes Newsboat.

You can also search articles' title or content by pressing `/` on the _Feed
List View_ or the _Article List View_. On the _Feed List View_ all articles of
all feeds are taken into account. On the _Article List View_ the articles of
the current feed are taken into account. When opening an article from a search
result dialog, the search phrase is highlighted.

**Search history** The history of all your searches is saved to the
filesystem, to the _history.search_ file (stored next to the _cache.db_ file).
By default, the last 100 search phrases are stored.

You can influence how many search phrases are stored by configuring `history-
limit`.

**Feed List View**

When you start Newsboat, it presents you with a list of feeds that you added
previously.

You can now:

  * Press `Shift`+`R` to download articles for all feeds.

  * Press `R` to download articles for the selected feed.

  * Press `/` to search all articles in all feeds.

  * Press `Enter` to go to the article list of a selected feed.

  * Press `Q` to close Newsboat.

**Local articles** Newsboat keeps the articles that it downloads. When you
start Newsboat again and reload a feed, old articles can still be read even if
they aren't in the current RSS feeds anymore. The maximum number of articles
is controlled by `max-items`.

**Caching** Newsboat uses a number of measures to preserve the users' and feed
providers' bandwidth through the use of conditional HTTP downloading. It saves
every feed's "Last-Modified" and "ETag" response header values (if present)
and advises the feed's HTTP server to only send data if the feed has been
updated. This doesn't only make feed downloads for RSS feeds with no new
updates faster, it also reduces the amount of transferred data per request.

You can disable conditional HTTP downloading per feed by configuring `always-
download`.

**Article List View**

After you entered a feed, you can see the list of available articles by their
title. A `N` on the left indicates that an article wasn't read yet.

You can now:

  * Press `Q` to go back to the _Feed List View_.

  * Press `/` to search all articles of this feed.

  * Press `Enter` to read a selected article.

**Article View**

On an article you can scroll through the text and read it. Each link in the
article has a number next to it.

You can now:

  * Press any number to open an article link in the browser. For numbers larger than 9 type `#`, then the number and press `Enter`.

  * Press `O` to open the article in the browser.

  * Press `Q` to go back to the _Article List View_.

**Browser view** Sometimes the content of an article is empty or just an
abstract or short description. You can always press `O` to view the complete
article in a browser. The default browser is _lynx_.

You can use your browser of choice by configuring `browser`.

## 4\. Configuration

Several aspects of Newsboat can be configured via a _config_ file, which is
stored next to the _urls_ file. A configuration line looks like this in
general:

    
    
    <config-command> <arg1> ...

The configuration file can contain comments, which start with the `#`
character and go as far as the end of line.

**User contrib** Newsboat also comes with user contributed content like
scripts and color themes. The user contributed content can be found in
`/usr/share/doc/newsboat/contrib/`. End users are encouraged to take a look as
they may find something useful.

### 4.1. Example

An example configuration looks like this

    
    
    # a comment
    max-items        100 # such comments are possible, too
    browser          links
    show-read-feeds  no
    
    unbind-key       R
    bind             ^R feedlist reload-all

### 4.2. Splitting long lines into multiple ones

Settings such as macros and `ignore-article` can be quite lengthy. A long line
can be broken into multiple ones using backslashes. A backslash must be the
last character on the line and will immediately concatenate it with the
following line. It's important that _nothing_ follows the `\` on the same
line, otherwise the `\` character is treated "as is". For example:

    
    
    macro p open; \
    reload; quit; \
    quit;         \
    quit -- "Opens, reloads then makes sure to quit newsboat"

Please note that a backslash only makes Newsboat ignore the following newline.
It doesn't do _anything_ else at all. For example, this nicely formatted
option:

    
    
    ignore-article \
        "*" \
        "author =~ \"(\
            John Doe| \
            Mary Sue \
        )\""

_does not_ turn into this:

    
    
    ignore-article "*" "author =~ \"(John Doe|Mary Sue)\""

Instead, as only newlines are removed, it turns to this:

    
    
    ignore-article     "*"     "author =~ \"(        John Doe|         Mary Sue     )\""

For this reason, be conscious of where you're splitting the lines, because it
might matter.

### 4.3. Using Double Quotes

**TL;DR** Use double quotes for strings that contain spaces or double quotes.
Escape double quotes (use \") and backslashes (use \\\\). Don't escape stuff
outside of double quotes, and don't use single quotes for quoting — Newsboat
doesn't support that.

Many of Newsboat's options expect strings as arguments, be it commands,
passwords, dialog titles, URLs etc. Some options even take _multiple_ strings
at once. These strings can contain spaces, which might confuse Newsboat since
it already uses spaces to separate option names from option arguments.

To help Newsboat understand your intent, put such strings into double quotes:

    
    
    browser "firefox --new-tab %u"

What if you need a double quote inside a string? Escape it with a backslash:

    
    
    ocnews-password "UnbalancedQuotes\"AreSoFun!"

And what about the backslash itself? Escape it, too! Suppose you have a
program called `my favourite pager`, and you want to view articles with it.
Newsboat ultimately passes commands to the shell, and shell expects spaces to
be escaped if you want them preserved. But since Newsboat interprets
backslashes, you have to add _another_ layer of escaping. Thus, you end up
with a command like this:

    
    
    pager "/usr/bin/my\\ favourite\\ pager"

### 4.4. Shell Evaluation

It is also possible to integrate the output of external commands into the
configuration. The text between two ``` backticks is evaluated as shell
command, and its output is used. This works like backtick evaluation in
Bourne-compatible shells and allows users to use external information from the
system within the configuration.

### 4.5. Escaping

Backticks and `#` characters can be escaped with a backslash (e.g. `\`` and
`\#`). In this case, they are replaced with literal ``` or `#` in the
configuration.

### 4.6. Key Bindings

_New style key bindings described here are supported since Newsboat 2.39._

You can bind a key (or sequence of keys) to an operation (or a list of
operations) with the `bind` configuration command.

The syntax for a binding looks like this:

    
    
    bind <key-sequence> <dialog>[,<dialog>] <operation-list> [-- "<description>"]

⚠ |  Limitations Bindings that share a prefix must all have the same length; otherwise, only the last binding is created. For example:
    
    
    bind ab everywhere …
    bind abc everywhere …

will only create a binding for `abc`. Re-ordering the commands will create a
binding for `ab`. This avoids ambiguity when `ab` is typed and Newsboat
doesn't know if it should run the binding for `ab` already or the user is
going to press `c` next, triggering the other binding. To have both bindings,
either:

  * rename them to have different prefixes (e.g. `ab` and `bcd`), or
  * make them the same length (e.g. rename `ab` to `abd` to match the length of `abc`).

  
---|---  
  
**Key Sequence**

Lowercase keys, uppercase keys and special characters are written literally.

Key combinations with `Ctrl` are written using the caret `^`. For instance
`Ctrl`+`R` equals to `^R`. Please be aware that all `Ctrl`-related key
combinations need to be written in uppercase.

Alternatively, key combinations using `Shift` or `Ctrl` can be written like
`<S-a>` and `<C-a>`, for `Shift`+`A` and `Ctrl`+`A` respectively. Note that
this alternative syntax only works with the `bind` command. It is not
supported with the older `bind-key` command.

The following identifiers for special keys are supported:

  * `<ENTER>` (Enter key)

  * `<BACKSPACE>` (backspace key)

  * `<LEFT>` (left cursor)

  * `<RIGHT>` (right cursor)

  * `<UP>` (up cursor)

  * `<DOWN>` (down cursor)

  * `<PPAGE>` (page up cursor)

  * `<NPAGE>` (page down cursor)

  * `<HOME>` (cursor to beginning of list/article)

  * `<END>` (cursor to end of list/article)

  * `<ESC>` (Esc key)

  * `<TAB>` (Tab key)

  * `<LT>` (`<` key)

  * `<GT>` (`>` key)

  * `<^>` (`^` key, can also be specified as just `^` if it is not followed by a letter)

  * `<F1>` to `<F12>` (F1 key to F12 key)

Multiple keys can be placed in sequence. For example `gg` means pressing `g`
twice and `^O<ENTER>` means pressing `Ctrl`+`O` followed by `Enter`. Pressing
`Esc` will cancel a multi-key input.

**Dialog**

A dialog is a context in which the key binding is active. Available dialogs
are:

  * `everywhere`

  * `feedlist`

  * `filebrowser`

  * `help`

  * `articlelist`

  * `article`

  * `tagselection`

  * `filterselection`

  * `urlview`

  * `podboat`

  * `dirbrowser`

  * `searchresultslist`

Multiple dialogs can be specified with a comma in between. For example:

    
    
    bind k feedlist,articlelist,urlview up
    bind j feedlist,articlelist,urlview down

or using `everywhere` to apply the binding in all dialogs:

    
    
    bind k everywhere up
    bind j everywhere down

**Operation List**

Operations get executed when pressing the corresponding sequence of keys. For
a complete list of available operations see Newsboat Operations and Podboat
Operations.

Multiple operations can be specified by writing them down separated by a
semicolon. Some operations allow specifying an argument, e.g. `set <config
option> <config value>` can be used to change a configuration option.

A sequence with two dashes followed by text between double quotes can be used
to add a description to a binding (e.g. `-- "some description"`). If present,
the description is shown in the help dialog.

In combination, this might look like:

    
    
    bind of everywhere set browser "firefox" ; open-in-browser -- "Open in Firefox"

The above example means that pressing `o` followd by `f` will change the
configured browser to `firefox` and then run the `open-in-browser` command to
open the feed/article in the configured browser.

`bind` is similar to macros but is more flexible. Macros are configured
globally, whereas `bind` can be applied to specific dialogs. Additionally,
macros always require pressing 2 keys (`macro-prefix` followed by a key
specific to the macro) while `bind` can specify a key-sequence of any length.

### 4.7. Old Style Key Bindings

You can bind a single key to a single operation with the `bind-key`
configuration command. This is an older, more limited form of keybinding
syntax. You can specify an optional dialog. This is the context in which the
key binding is active.

The syntax for an old style key binding looks like this:

    
    
    bind-key <key> <operation> [<dialog>]

**Key**

Lowercase keys, uppercase keys and special characters are written literally.

Key combinations with `Ctrl` are written using the caret `^`. For instance
`Ctrl`+`R` equals to `^R`. Please be aware that all `Ctrl`-related key
combinations need to be written in uppercase.

The following identifiers for special keys are supported:

  * `ENTER` (Enter key)

  * `BACKSPACE` (backspace key)

  * `LEFT` (left cursor)

  * `RIGHT` (right cursor)

  * `UP` (up cursor)

  * `DOWN` (down cursor)

  * `PPAGE` (page up cursor)

  * `NPAGE` (page down cursor)

  * `HOME` (cursor to beginning of list/article)

  * `END` (cursor to end of list/article)

  * `ESC` (Esc key)

  * `TAB` (Tab key)

  * `F1` to `F12` (F1 key to F12 key)

**Operation**

An operation gets executed when pressing the corresponding key. For a complete
list of available operations see Newsboat Operations and Podboat Operations.

**Dialog**

A dialog is a context in which the key binding is active. Available dialogs
are:

  * `all` (default if not specified)

  * `feedlist`

  * `filebrowser`

  * `help`

  * `articlelist`

  * `article`

  * `tagselection`

  * `filterselection`

  * `urlview`

  * `podboat`

  * `dirbrowser`

  * `searchresultslist`

### 4.8. Colors

It is possible to configure custom color settings in Newsboat. The basic
configuration syntax is:

    
    
    color <element> <foreground color> <background color> [<attribute> ...]

This means that if you configure colors for a certain element, you need to
provide a foreground color and a background color as a minimum. The following
colors are supported:

  * `black`

  * `red`

  * `green`

  * `yellow`

  * `blue`

  * `magenta`

  * `cyan`

  * `white`

  * `default`

  * `color<n>`, e.g. `color123`

The `default` color means that the terminal's default color will be used. The
`color<n>` color name (where `<n>` is a decimal number **not** starting with
zero) can be used if your terminal supports 256 colors (e.g. `gnome-terminal`,
or `xterm` with `TERM` set to `xterm-256color`). Newsboat contains support for
256 color terminals since version 2.1. For a complete chart of colors and
their corresponding numbers, please see
<https://www.calmar.ws/vim/256-xterm-24bit-rgb-color-chart.html>.

Optionally, you can also add one or more attributes. The following attributes
are supported:

  * `standout`

  * `underline`

  * `reverse`

  * `blink`

  * `dim`

  * `bold`

  * `protect`

  * `invis`

Currently, the following elements are supported:

  * `background`: the application background

  * `listnormal`: a normal list item

  * `listfocus`: the currently selected list item

  * `listnormal_unread`: an unread list item

  * `listfocus_unread`: the currently selected unread list item

  * `title` (_added in 2.25_): current dialog's title, which is usually at the top of the screen (but see `show-title-bar` and `swap-title-and-hints`). If you don't specify a style for this element, then the `info` style is used

  * `info`: the hints bar, which is usually at the bottom of the screen (but see `show-keymap-hint` and `swap-title-and-hints`)

  * `hint-key` (_added in 2.25_): a key in the hints bar. If you don't specify a style for this element, then the `info` style is used

  * `hint-keys-delimiter` (_added in 2.25_): the comma that separates keys in the hints bar. If you don't specify a style for this element, then the `info` style is used

  * `hint-separator` (_added in 2.25_): the colon separating keys from their descriptions in the hints bar. If you don't specify a style for this element, then the `info` style is used

  * `hint-description` (_added in 2.25_): a description of a key in the hints bar. If you don't specify a style for this element, then the `info` style is used

  * `article`: the article text

  * `end-of-text-marker`: filler lines (~) below blocks of text

The default color configuration of Newsboat looks like this:

    
    
    color background          white   black
    color listnormal          white   black
    color listfocus           yellow  blue   bold
    color listnormal_unread   white   black  bold
    color listfocus_unread    yellow  blue   bold
    color title               yellow  blue   bold
    color info                yellow  blue   bold
    color hint-key            yellow  blue   bold
    color hint-keys-delimiter white   blue
    color hint-separator      white   blue   bold
    color hint-description    white   blue
    color article             white   black

### 4.9. Files

By default, Newsboat stores all the files in a traditional Unix fashion, i.e.
in a "dotdir" located at _~/.newsboat_. However, it also supports a modern
way, [XDG Base Directory
Specification](https://standards.freedesktop.org/basedir-spec/basedir-spec-
latest.html), which splits the files between the following locations:

  1. _$XDG_CONFIG_HOME/newsboat/_ (`XDG_CONFIG_HOME` defaults to _~/.config_)

  2. _$XDG_DATA_HOME/newsboat/_ (`XDG_DATA_HOME` defaults to _~/.local/share_)

If the _newsboat_ directory exists under `XDG_CONFIG_HOME`, then Newsboat will
use XDG directories (creating the data directory if necessary). Otherwise,
Newsboat will default to _~/.newsboat_.

If you're currently using _~/.newsboat/_ but wish to migrate to XDG
directories, you should move the files as follows:

_config_ , _urls_

    

to _$XDG_CONFIG_HOME/newsboat/_

_cache.db_ , _history.search_ , _history.cmdline_ , _queue_

    

to _$XDG_DATA_HOME/newsboat/_

Newsboat and Podboat also create "lock files". These prevent you from starting
two instances of the same program, and thus from corrupting your data.
Newsboat and Podboat remove these files when you quit the program, so there is
no need to copy them anywhere — just be aware of them in case you write
scripts that work with _cache.db_ or _queue_. By default, lock files are
located as follows:

| dotdir | XDG  
---|---|---  
Newsboat | _~/.newsboat/cache.db.lock_ | _$XDG_DATA_HOME/newsboat/cache.db.lock_  
Podboat | _~/.newsboat/pb-lock.pid_ | _$XDG_DATA_HOME/newsboat/.lock_  
  
Newsboat places the lock file next to the cache file, so if you specify cache-
file setting or pass `--cache-file` command-line argument, the path to the
lock file will change too. Podboat's lock can be placed elsewhere using
`--lock-file` command-line argument.

## 5\. Migrating from other RSS Feed Readers

It is very likely that you have used other RSS feed readers before. In this
case, it is practical to migrate the previous configuration to Newsboat.

### 5.1. Newsbeuter (automatic migration)

Newsboat is a fork of Newsbeuter, so the migration from the latter is
partially automated. Simple enough configurations will be transferred without
any user intervention, while more complicated ones might require a little
tweaking afterwards.

To prevent data loss, please check the results before deleting your old
configuration. Pay extra attention to files that you `include` in your
configuration--​you'd probably want to manually copy them over to Newsboat
directories, and possibly update the include paths.

Migration from Newsbeuter is attempted on startup if the following conditions
are met:

  * none of `-u`, `-c`, `-C` options were specified; and

  * the urls file doesn't exist (neither _~/.newsboat/urls_ nor _$XDG_CONFIG_HOME/newsboat/urls_).

Newsboat first tries to migrate an XDG configuration, and if that fails, it
tries the dotdir one. If that fails as well, Newsboat proceeds with the
startup as usual.

XDG migration checks that:

  * _$XDG_CONFIG_HOME/newsbeuter/_ is readable and executable; and

  * neither _$XDG_CONFIG_HOME/newsboat/_ nor _$XDG_DATA_HOME/newsboat/_ exist.

If both conditions are met, Newsboat tries to create its XDG dirs (aborting
the migration if that fails), then copies the following files: _urls_ and
_config_ from config dir; _cache.db_ , _queue_ , _history.search_ ,
_history.cmdline_ from data dir.

Dotdir migration checks that _~/.newsbeuter/_ is readable and executable, and
_~/.newsboat/_ doesn't exist. If those conditions are met, it tries to create
_~/.newsboat/_ (aborting the migration if that fails), then copies the
following files: _urls_ , _cache.db_ , _config_ , _queue_ , _history.search_ ,
_history.cmdline_.

There's one scenario where the process breaks: if you have an XDG
configuration for Newsbeuter, _~/.newsboat/_ exists and _~/.newsboat/urls_
doesn't exist, then Newsboat will migrate XDG files and proceed, ignoring the
dotdir. Please don't confuse the poor program like that!

### 5.2. Other readers (via OPML)

The vast amount of RSS feed readers allows the export of subscriptions via
OPML files. OPML is an XML file format that was designed to save outlines, and
has found its primary use in the import and export of feed subscriptions
between different RSS feed readers.

The best thing to start with is to export your subscriptions from the old
reader. Usually, RSS feed readers have appropriate menu items available to do
so.

Snownews 1.7+ stores its subscriptions natively in OPML, in
_~/.config/snownews/urls.opml_. Earlier versions provide an export script:

    
    
    snow2opml > ~/blogroll.opml

To export the subscription list from raggle, the following command is
necessary:

    
    
    raggle --export-opml ~/blogroll.opml

You can then import subscriptions into Newsboat:

    
    
    newsboat -i ~/blogroll.opml

Don't worry, Newsboat won't destroy your existing configuration, or add
subscriptions more than once: every URL that is added to the subscription list
is checked before whether it is already in the list, and is only added if not.
This makes it possible to merge several OPML files into your subscription
list.

If your old RSS feed reader was able to structure your subscriptions in
hierarchies, and reflected this structure in the exported OPML file, Newsboat
doesn't throw away this information (although it doesn't support hierarchies),
but generates tags from it. Tags are Newsboat's way of organizing
subscriptions in a non-hierarchical way. More information on the use of tags
can be found below.

Imagine the following folder hierarchy:

    
    
    |- News
    | |- Europe
    | `- International
    |- IT
    | |- Linux
    | |- Windows
    | `- Programming
    |   |- C++
    |   |- Ruby
    |   `- Erlang
    `- Private

Subscriptions found in the folder "Private" will be tagged with "Private",
subscriptions in the folder "International" will be tagged with "News" and
"News/International", subscriptions in the folder "Erlang" will be tagged ith
"IT", "IT/Programming" and "IT/Programming/Erlang", and so on. This means that
when you select the tag "Programming" in Newsboat, you will see all
subscriptions that were in the "Programming" folder or one of its subfolders
before. This means that you will lose virtually nothing of your previously
configured structure.

## 6\. Newsboat as a Client for Newsreading Services

Newsboat is a perfectly capable feedreader in its own right, but it can’t
cover _all_ the use-cases. For example, you might want to synchronize your
news between devices, or you don’t have a computer that’s running 24/7 to
fetch your feeds. In such cases, you might register with some online
feedreader, and use Newsboat as a client. The next few sections provide
configuration instructions for each supported service.

### 6.1. The Old Reader

[The Old Reader](https://theoldreader.com/) is a successor to Google Reader.
In order to use it, you first need to configure the proper URL source:

    
    
    urls-source "oldreader"

In addition, Newsboat needs to know your The Old Reader username and password
so that it can authenticate with the service:

    
    
    oldreader-login "your-oldreader-account"
    oldreader-password "your-password"

Note that double quotes and backslashes in your password should be escaped.

See also `oldreader-passwordfile`, `oldreader-passwordeval`, and Passwords for
external APIs.

After setting these configuration values, you can start Newsboat. It will
authenticate with The Old Reader and download your subscription list.

When you mark single items or complete feeds as read, Newsboat will
synchronize this information directly to The Old Reader. This, of course,
includes opening articles. Toggling read articles back to "unread" is also
communicated to The Old Reader.

In addition, The Old Reader provides the ability to "star" and to "share"
articles. Starred articles are basically bookmarks, while shared articles are
shown to people that follow your The Old Reader account. Newsboat allows the
use of this feature by mapping its powerful "flags" to the "star"/"unstar"
resp. "share"/"unshare" operations.

In order to use this mapping, all you need to do is to configure the flags
that shall be used:

    
    
    oldreader-flag-share "a"
    oldreader-flag-star "b"

After that, use these flags when you edit flags for an article, and these
articles will be starred resp. shared.

By default, Newsboat also shows The Old Reader "special feeds":

  * People you follow: articles shared by people that you follow.

  * Starred items: articles that you starred.

  * Shared items: articles that you shared.

You can disable these feeds by setting the following configuration variable:

    
    
    oldreader-show-special-feeds no

The Old Reader's folders are converted into Newsboat tags. You can select and
filter feeds by tags; see Tagging and Filter Language for details.

### 6.2. NewsBlur

[NewsBlur](https://newsblur.com/) is a successor to Google Reader. To use it,
set your `urls-source`:

    
    
    urls-source "newsblur"

Then, configure your NewsBlur credentials:

    
    
    newsblur-login "your-newsblur-account"
    newsblur-password "your-password"

Note that double quotes and backslashes in your password should be escaped.

See also `newsblur-passwordfile`, `newsblur-passwordeval`, and Passwords for
external APIs.

Finally, set a path to the file where Newsboat can store the HTTP cookies:

    
    
    cookie-cache "~/.newsboat/cookies.txt"

When you start Newsboat, it will download the feeds that you configured in
NewsBlur. Please take a closer look at the configuration commands for what you
can configure in Newsboat regarding NewsBlur.

NewsBlur's folders are converted into Newsboat tags. You can select and filter
feeds by tags; see Tagging and Filter Language for details. NewsBlur's
starring/saving feature is currently unsupported by Newsboat.

### 6.3. FeedHQ

[FeedHQ](https://feedhq.org/) is a successor to Google Reader. Configuration
basically works the same as with The Old Reader.

First, set your `urls-source`:

    
    
    urls-source "feedhq"

Then, configure your FeedHQ credentials:

    
    
    feedhq-login "your-feedhq-account"
    feedhq-password "your-password"

Note that double quotes and backslashes in your password should be escaped.

See also `feedhq-passwordfile`, `feedhq-passwordeval`, and Passwords for
external APIs.

If you're using a standalone instance, you should add one more setting:

    
    
    feedhq-url "https://the.url.of/your/feedhq/instance"

When you start Newsboat, it will download the feeds that you configured in
FeedHQ. Please take a closer look at the configuration commands for what you
can configure in Newsboat regarding FeedHQ.

FeedHQ's folders are converted into Newsboat tags. You can select and filter
feeds by tags; see Tagging and Filter Language for details.

### 6.4. Bazqux

[Bazqux](https://bazqux.com/) uses "Google Reader API", which is also used by
other readers like FeedHQ. Thus, one can leverage Newsboat's support for
FeedHQ (described above) to synchronize with Bazqux:

    
    
    urls-source "feedhq"
    feedhq-url "https://bazqux.com/"
    feedhq-login "username"
    feedhq-password "password"

See Passwords for external APIs for other, more secure ways to store your
password.

### 6.5. Feedbin

_Supported since Newsboat 2.35_.

[Feedbin](https://feedbin.com) is a web-based RSS reader. To use it, point
Newsboat to your Feedbin account:

    
    
    urls-source "feedbin"
    feedbin-login "myusername"
    feedbin-password "mypassword"

See Passwords for external APIs for other, more secure ways to store your
password.

### 6.6. FreshRSS

_Supported since Newsboat 2.24_.

[FreshRSS](https://freshrss.org) is a self-hosted feed reader that also uses a
"Google Reader API", but is incompatable with the FeedHQ API. To use FreshRSS
support, ensure that [API access is
enabled](https://freshrss.github.io/FreshRSS/en/users/06_Mobile_access.html#enable-
the-api-in-freshrss) in the Authentication settings for your server, and that
you have set an API password for your user Profile. Then point Newsboat to
your server:

    
    
    urls-source "freshrss"
    freshrss-url "https://freshrss.example.com/api/greader.php"
    freshrss-login "myusername"
    freshrss-password "mypassword"

See Passwords for external APIs for other, more secure ways to store your
password.

Newsboat will request 20 articles by default. Change this with e.g.

    
    
    freshrss-min-items 100

FreshRSS provides the ability to "favourite"/"star" articles. Starred articles
are basically bookmarks. Newsboat allows the use of these features by mapping
its flags to the "star" operation.

In order to use this mapping, you need to configure the flag that should be
used:

    
    
    freshrss-flag-star "s"

After that, use this flag when you edit flags for an article, and these
articles will be starred.

By default a "Starred Items" feed is included in the feed list. This can be
removed with:

    
    
    freshrss-show-special-feeds "false"

FreshRSS categories are converted into Newsboat tags. You can select and
filter feeds by tags; see Tagging and Filter Language for details.

### 6.7. Tiny Tiny RSS

Newsboat can be used to synchronize with [Tiny Tiny RSS](https://tt-rss.org/)
installations. Tiny Tiny RSS is a web-based and (optionally) multi-user feed
reader.

If you want to use Tiny Tiny RSS support, don't forget to activate the
external API support in your preferences.

To use Tiny Tiny RSS support, you need to configure a few things. First of
all, Newsboat needs to know that you want to use Tiny Tiny RSS and which
installation exactly:

    
    
    urls-source "ttrss"
    ttrss-url "https://example.com/ttrss/"

In addition, it requires username and password for authentication:

    
    
    ttrss-login "myusername"
    ttrss-password "mypassword"

Note that double quotes and backslashes in your password should be escaped.

See also `ttrss-passwordfile`, `ttrss-passwordeval`, and Passwords for
external APIs.

Tiny Tiny RSS provides two modes of usage: single-user mode and multi-user
mode. Newsboat needs to know about this, too: in single-user mode,
authentication is done via Basic HTTP authentication, while in multi-user
mode, authentication is done against Tiny Tiny RSS itself.

    
    
    ttrss-mode "single"		# "multi" is default

If Tiny Tiny RSS is configured in multi-user mode and still deployed behind an
additional HTTP-BasicAuth, the required username and password (which may
deviate from `ttrss-login` and `ttrss-password`) can be specified in the user-
part of the url like this:

    
    
    ttrss-url "https://htuser:htpasswd@example.com/ttrss/"

With these settings, Newsboat should be able to connect to Tiny Tiny RSS and
download your subscribed feeds. Articles or even complete feeds that you
marked as read are synchronized directly to Tiny Tiny RSS.

Tiny Tiny RSS provides the ability to "star" and to "publish" articles.
Starred articles are basically bookmarks, while published articles can be
retrieved via a public RSS feed. Newsboat allows the use of these features by
mapping its flags to the "star" and "publish" operations.

In order to use this mapping, you need to configure the flags that shall be
used:

    
    
    ttrss-flag-star "s"
    ttrss-flag-publish "p"

After that, use these flags when you edit flags for an article, and these
articles will be starred resp. published.

TT-RSS folders are converted into Newsboat tags. You can select and filter
feeds by tags; see Tagging and Filter Language for details.

### 6.8. ownCloud News and nextCloud News

_Supported since Newsboat 2.10._

[ownCloud News](https://github.com/owncloudarchive/news) and [nextCloud
News](https://github.com/nextcloud/news) implement the same protocol, so
Newsboat treats them as equivalent. Instructions below apply to both.

First, set your `urls-source` to `ocnews` and tell Newsboat where to find your
ownCloud instance:

    
    
    urls-source "ocnews"
    ocnews-url "https://localhost/owncloud"

Username and password are required:

    
    
    ocnews-login "user"
    ocnews-password "password"

See also `ocnews-passwordfile`, `ocnews-passwordeval`, and Passwords for
external APIs.

ownCloud News API uses HTTP basic auth, therefore running ownCloud with SSL is
highly recommended. If for any reason you don't want Newsboat to verify the
hostname of your instance against the hostname specified in the SSL
certificate you're using, just say so:

    
    
    ocnews-verifyhost "no"

If you see intermittent "Authentication failed" errors, try [configuring
memory
caching](https://docs.nextcloud.com/server/stable/admin_manual/configuration_server/caching_configuration.html).
That should improve the responsiveness of the API and fix the errors.

ownCloud News provides the ability to "star" articles; starred articles are
basically bookmarks. Newsboat allows the use of this feature by mapping user-
specified flag to the "star" operation.

In order to use this mapping, you need to configure the flag that shall be
used:

    
    
    ocnews-flag-star "s"

After that, use these flags when you edit flags for an article, and these
articles will be starred.

OwnCloud News' folders are converted into Newsboat tags. You can select and
filter feeds by tags; see Tagging and Filter Language for details.

### 6.9. Inoreader

_Supported since Newsboat 2.10.2._

⚠ |  As of 2022-04-21, this only works for Inoreader Pro users, and only if they don't have too many feeds and/or don't reload them too often.   
---|---  
  
⚠ |  As of 2021-08-23, Inoreader's API doesn't list enclosures, so Newsboat won't display podcasts, cover images etc.   
---|---  
  
[Inoreader](https://inoreader.com/) is a successor to Google Reader.

To use Newsboat with Inoreader, you should first get an Inoreader Pro
subscription and [register your own
application](https://www.inoreader.com/developers/register-app). This is
needed because app credentials have to be kept secret, and [Newsboat
developers don't want to operate a
proxy](https://github.com/newsboat/newsboat/issues/35) needed to achieve that.

Please note that API requests to Inoreader are rate-limited, so you might have
problems reloading a lot of feeds, or doing so often. Keep this in mind when
enabling `auto-reload` or lowering `reload-time`.

With app ID and key in hand, tell Newsboat you'd like to use Inoreader:

    
    
    urls-source "inoreader"
    inoreader-app-id "INSERT_ID_HERE"
    inoreader-app-key "INSERT_KEY_HERE"

In addition, Newsboat needs to know your Inoreader username and password so
that it can authenticate with Inoreader. Note that this is NOT your login with
your Google or Facebook account. If you use one of those to login to
Inoreader, you have to create a username and password in Inoreader
_Preferences > Profile_

    
    
    inoreader-login "your-inoreader-account"
    inoreader-password "your-password"

Note that double quotes and backslashes in your password should be escaped.

See also `inoreader-passwordfile`, `inoreader-passwordeval`, and Passwords for
external APIs.

After setting these configuration values, you can start Newsboat. It will
authenticate with Inoreader and download your subscription list. If you use
"folders" in Inoreader to organize your feeds, Newsboat will make them
available via its "tags" capability: each feed is tagged with the name of the
folder in which it resides. You can select and filter feeds by tags; see
Tagging and Filter Language sections for details.

When you mark single items or complete feeds as read, Newsboat will
synchronize this information directly to Inoreader. This, of course, includes
opening articles. Toggling read articles back to "unread" is also communicated
to Inoreader.

In addition, Inoreader provides the ability to "star" and to "share" articles.
Starred articles are basically bookmarks, while shared articles are shown to
people that follow your Inoreader account. Newsboat allows the use of this
feature by mapping its powerful "flags" to the "star"/"unstar" resp.
"share"/"unshare" operations.

In order to use this mapping, all you need to do is to configure the flags
that shall be used:

    
    
    inoreader-flag-share "a"
    inoreader-flag-star "b"

After that, use these flags when you edit flags for an article, and these
articles will be starred resp. shared.

By default, Newsboat also shows Inoreader "special feeds":

  * Starred items

  * Shared items

  * Liked items

  * Saved web pages

You can disable these feeds by setting the following configuration variable:

    
    
    inoreader-show-special-feeds no

### 6.10. Miniflux

_Supported since Newsboat 2.21._

[Miniflux](https://miniflux.app) is a "minimalist and opinionated feed reader"
that is self-hostable.

Newsboat can synchronize with Miniflux installations as an alternative to the
web front-end.

To configure Miniflux support, set the urls-source option and provide the url
to the Miniflux instance to be used:

    
    
    urls-source "miniflux"
    miniflux-url "https://example.com/miniflux/"

In addition, Miniflux requires username and password for authentication:

    
    
    miniflux-login "myusername"
    miniflux-password "mypassword"

Note that double quotes and backslashes in your password should be escaped.

See also `miniflux-passwordfile`, `miniflux-passwordeval`, and Passwords for
external APIs.

When a username/password are specified, the Miniflux backend will default to
using the `basic` HTTP authentication method, since Newsboat sends extraneous
requests when trying to determine the appropriate method automatically. If
your Miniflux instance uses a special setup that doesn't function with `basic`
authentication, it may be necessary to explicitly set the `http-auth-method`
variable in the configuration.

It is also possible to specify an API token instead of the username/password
combination:

    
    
    miniflux-token "my-api-token"

See also `miniflux-tokenfile`, and `miniflux-tokeneval`.

In addition, Miniflux provides the ability to "star" articles. Starred
articles are basically bookmarks. Newsboat allows the use of this feature by
mapping its powerful "flags" to the "star"/"unstar" operations.

In order to use this mapping, all you need to do is to configure the flags
that shall be used:

    
    
    miniflux-flag-star "a"

After that, use these flags when you edit flags for an article, and these
articles will be starred.

By default a "Starred Items" feed is included in the feed list. This can be
removed with:

    
    
    miniflux-show-special-feeds "no"

Miniflux categories are converted into Newsboat tags. You can select and
filter feeds by tags; see Tagging and Filter Language for details.

### 6.11. OPML Online Subscription Mode

This mode provides one-way synchronization of subscriptions from the online
service to Newsboat. In other words, Newsboat will know what feeds you've
subscribed to, but the online service won't know what feeds you're reading in
Newsboat.

This mode works with any service that publishes your subscriptions in OPML
format.

To enable this mode, you need to set an appropriate URLs source and then tell
Newsboat where to get the OPML file(s):

    
    
    urls-source "opml"
    opml-url "https://example.com/feeds.opml" "https://example.com/more.opml"

### 6.12. Passwords for external APIs

There are a number of ways to specify a password, each represented by a
separate setting. Newsboat looks for settings in certain order, and uses the
first one that it finds. The exact order is described below.

Settings are prefixed by API names; e.g. `newsblur-password`, `feedhq-
passwordeval`. All APIs support all the settings, so examples below use
`REMOTEAPI` for prefix. Replace it with the name of the remote API you use.

The first setting Newsboat checks is `REMOTEAPI-password`. It should contain
the password in plain text.

The second setting Newsboat checks is `REMOTEAPI-passwordfile`. It should
contain a path to a file; the first line of that file should contain the
password in plain text. If the file doesn't exit, is unreadable, or its first
line is empty, Newsboat will exit with an error.

The third setting Newsboat checks is `REMOTEAPI-passwordeval`. It should
contain a command that, when executed, will print out the password to stdout.
stderr will be passed through to the terminal.

If the first line of command's output is empty, or the command fails to
execute, Newsboat will exit with an error. This is the most versatile of all
the options, because it lets you emulate every other and more; let's look at
it in more detail.

For example, a user might want to store their password in a file encrypted by
GPG. They create the file like that:

    
    
    $ gpg --encrypt --default-recipient-self --output ~/.newsboat/password.gpg

They enter their password, press `Enter`, and finish the command by pressing
`Ctrl`+`D`. Then, they specify in their Newsboat config:

    
    
    REMOTEAPI-passwordeval "gpg --decrypt ~/.newsboat/password.gpg"

Now every time they start Newsboat, GPG will be ran. It'll probably ask for
keyring password, then decrypt the file, and pass its contents to Newsboat,
which will use it to authenticate with the remote API.

Note that Newsboat will keep the password in memory the entire time Newsboat
is running. Other programs might be able to dump the memory and obtain the
password. We don't currently have any protection from that; patches are
welcome.

The user might use any other command here; for example, they could fetch the
password from GNOME keyring, KeePass, or somewhere else entirely. The
possibilities are truly endless.

If none of the aforementioned settings were found, Newsboat will ask the user
for the password using an interactive prompt. If the password that the user
enters is empty, Newsboat will give up and exit with an error.

## 7\. Advanced Features

### 7.1. Tagging

Newsboat comes with the possibility to categorize or "tag", as we call it, RSS
feeds. Every RSS feed can be assigned 0 or more tags. Within Newsboat, you can
then select to only show RSS feeds that match a certain tag. That makes it
easy to categorize your feeds in a flexible and powerful way.

Usually, the _urls_ file contains one RSS feed URL per line. To assign a tag
to an RSS feed, simply attach it as a single word, separated by blanks such as
space or tab. If the tag needs to contain spaces, you must use quotes (`"`)
around the tag (see example below). An example _urls_ file may look like this:

    
    
    https://blog.fefe.de/rss.xml?html interesting conspiracy news "cool stuff"
    https://rss.orf.at/news.xml news orf
    https://www.heise.de/newsticker/heise.rdf news interesting

When you now start Newsboat with this configuration, you can press `T` to
select a tag. When you select the tag "news", you will see all three RSS
feeds. Pressing `T` again and e.g. selecting the "conspiracy" tag, you will
only see the <https://blog.fefe.de/rss.xml?html> RSS feed. Pressing `Ctrl`+`T`
clears the current tag, and again shows all RSS feeds, regardless of their
assigned tags.

A special type of tag are tags that start with the tilde character (`~`). When
such a tag is found, the feed title is set to the tag name (excluding the `~`
character). These type of tags are ignored when any kind of "first tag"
property is used. With this feature, you can give feeds any title you want in
your feed list:

    
    
    https://rss.orf.at/news.xml "~ORF News"

Another special type of tag are tags that start with the exclamation mark
(`!`). When such a tag is found, the feed is hidden from the regular list of
feeds and its content can only be found through a query feed.

    
    
    https://rss.orf.at/news.xml ! news
    http://feeds.bbci.co.uk/news/world/rss.xml ! news
    "query:News from around the globe:tags # \"news\""

In this example, the first two feeds won't appear in the feedlist, but their
articles will still be accessible through the query feed titled "News from
around the globe". The "hidden" tags in this example don't even have names,
because their only use is to hide the feed that they're tagging.

### 7.2. Scripts and Filters (Snownews Extensions)

Newsboat contains support for Snownews extensions. The RSS feed readers
Snownews and Liferea share a common way of extending the readers with custom
scripts. Two mechanisms, namely "execurl" and "filter" type scripts, are
available and supported by Newsboat.

An "execurl" script can be any program that gets executed and whose output is
interpreted as RSS feed, while "filter" scripts are fed with the content of a
configured URL and whose output is interpreted as RSS feed.

The configuration is simple and straight-forward. Just add to your _urls_ file
configuration lines like the following ones:

    
    
    exec:~/bin/execurl-script
    filter:~/bin/filter-script:https://some.test/url

The first line shows how to add an execurl script to your configuration: start
the line with `exec:` and then immediately append the path of the script that
shall be executed. If this script requires additional parameters, simply use
quotes (see Using Double Quotes for details):

    
    
    "exec:~/bin/execurl-script param1 param2"

The second line shows how to add a filter script to your configuration: start
the line with `filter:`, then immediately append the path of the script, then
append a colon (`:`), and then append the URL of the file that shall be fed to
the script. Again, if the script requires any parameters, simply quote the
whole thing:

    
    
    "filter:~/bin/filter-script param1 param2:https://url/foobar"

In both cases, the tagging feature as described above is still available:

    
    
    exec:~/bin/execurl-script tag1 tag2 "quoted tag"
    filter:~/bin/filter-script:https://some.test/url tag3 tag4 tag5

If you need to write your own extension, see [this short
guide](https://web.archive.org/web/20090724045314/http://kiza.kcore.de/software/snownews/snowscripts/writing)
for an introduction. A collection of existing
[scripts](https://github.com/msharov/snownews/tree/de3bd8b28191c4d4bc1be18275786613bcbc0c94/docs/untested)
and
[filters](https://github.com/msharov/snownews/tree/9fb45e4cdf1cf9dea55b9af66c13a4c238809851/docs/filters)
might help, too.

Newsboat comes with an example exec script which shows one way to generate an
RSS channel. It also includes a way to see which exact arguments are passed to
the script by Newsboat. This example can be found in the _doc/examples_
subdirectory.

### 7.3. Bookmarking

This feature lets you save links from the article list, the article view, and
the URL view. The actual bookmarking is performed by a program that you
specify via the `bookmark-cmd` setting; Newsboat merely supplies the data.

To bookmark the currently selected item, press `Ctrl`+`B` (invoking the
`bookmark` operation), and Newsboat will ask you for:

  1. the URL to bookmark (already preset with the URL of the current selection);

  2. the bookmark title (in most cases preset with the title of the current selection);

  3. the bookmark description (default empty); and

  4. (since Newsboat 2.10) the title of the feed you're currently in (preset as you'd expect).

(If you find that the above preset values always work for you, enable
`bookmark-autopilot` to avoid being asked anything.)

After that, the program configured via `bookmark-cmd` is executed. It is given
four arguments, the same ones and in the same order as described above. The
program then does the actual bookmark saving, e.g. writing the bookmark into
an external file, or storing it to a del.icio.us account.

If everything goes OK, the program simply exits. In case something goes wrong,
the program writes out an error message to stdout as a single line. This error
message is then presented to the user from within Newsboat. At the moment,
Newsboat doesn't care about the exit code of the program; only its output is
used to determine success.

Some bookmarking commands are interactive, e.g. they might want you to select
a category for your bookmark, or a Mastodon account from which to share the
bookmark. Oftentimes you can specify defaults for these, but if you can't,
enable `bookmark-interactive`: it will make Newsboat relinquish the terminal
to the bookmarking program. You'll be able to make all the changes there, and
will return to Newsboat once the bookmarking program exits.

Newsboat comes with an example plugin, _doc/examples/example-bookmark-
plugin.sh_ , which implements a simple tab-separated bookmark file. You can
use that as a starting point to write your own bookmarking program.

### 7.4. Command Line

Like other text-oriented software, Newsboat contains an internal commandline
to modify configuration variables ad hoc and to run own commands. It provides
a flexible access to the functionality of Newsboat which is especially useful
for advanced users.

To start the commandline, type `:`. You will see a ":" prompt at the bottom of
the screen, similar to tools like vi(m) or mutt. You can now enter commands.
Pressing the `Enter` key executes the command (possibly giving feedback to the
user) and closes the commandline. You can cancel entering commands by pressing
the `Esc` key. The history of all the commands that you enter will be saved to
the _history.cmdline_ file, stored next to the _cache.db_ file. The backlog is
limited to 100 entries by default, but can be influenced by setting the
`history-limit` configuration variable. To disable history saving, set the
`history-limit` to `0`.

The commandline provides you with some help if you can't remember the full
names of commandline commands. By pressing the `Tab` key, Newsboat will try to
automatically complete your command. If there is more than one possible
completion, you can subsequently press the `Tab` key to cycle through all
results. If no match is found, no suggestion will be inserted into the
commandline. For the `set` command, the completion also works for
configuration variable names.

In addition, some common key combination such as `Ctrl`+`G` (to cancel input),
`Ctrl`+`K` (to delete text from the cursor position to the end of line),
`Ctrl`+`U` (to clear the whole line) and `Ctrl`+`W` (to delete the word before
the current cursor position) were added.

Please be aware that the input history of both the command line and the search
functions are saved to the filesystems, to the files _history.cmdline_ resp.
_history.search_ (stored next to the _cache.db_ file). By default, the last
100 entries are saved, but this can be configured (configuration variable
`history-limit`) and also totally disabled (by setting said variable to `0`).

Currently, the following command line commands are available:

* * *

**Syntax:** quit  
**Example:** quit  

Quit Newsboat.  

* * *

**Syntax:** q  
**Example:** quit  

Alias for quit.  

* * *

**Syntax:** save <filename>  
**Example:** save ~/important.txt  

Export the currently selected article to a plain text file. This works in the
article list and in the article view.  

* * *

**Syntax:** set <variable>[=<value>|&|!]  
**Example:** set reload-time=15  

Set configuration variable <variable> to <value>. If no value is specified,
the current value is printed out. Specifying a _!_ after the name of boolean
configuration variables toggles their values, a _&_ directly after the name of
a configuration variable of any type resets its value to the documented
default value.  

* * *

**Syntax:** tag <tagname>  
**Example:** tag news  

Only display feeds with the tag <tagname>.  

* * *

**Syntax:** goto <case-insensitive substring>  
**Example:** goto foo  

Search for a feed whose name contains the case-insensitive substring.  

* * *

**Syntax:** source <filename> […​]  
**Example:** source ~/.newsboat/colors  

Load the specified configuration files. This allows it to load alternative
configuration files or reload already loaded configuration files on-the-fly
from the filesystem.  

* * *

**Syntax:** dumpconfig <filename>  
**Example:** dumpconfig ~/.newsboat/config.saved  

Save current internal state of configuration to file, so that it can be
instantly reused as configuration file.  

* * *

**Syntax:** exec <operation>  
**Example:** exec open-all-unread-in-browser-and-mark-read  

Run a keybind operation in the current context.  

* * *

**Syntax:** number  
**Example:** 30  

Jump to the entry with the index <number> (usually seen at the left side of
the list). This currently works for the feed list, article list, tag
selection, filter selection, and dialog selection forms.  

### 7.5. Filter Language

Newsboat provides a powerful filter language that enables the user to filter
the content of many dialogs, such as the feed list or the article list. The
basic concept is that every feed and every article has a number of attributes
which can then be compared with user-supplied values, and these comparisons
and be logically AND'ed, OR'ed and grouped.

Examples for simple filter expressions are:

    
    
    unread_count > 0
    rssurl =~ "^https:"
    age between 0:10

Logically connecting and grouping such expressions looks like in the following
examples:

    
    
    ( unread_count > 0 and unread_count < 10 ) or total_count > 100
    ( author =~ "Frank" or author =~ "John" ) and ( title =~ "Linux" or title =~ "FreeBSD" )

The possibilities for combining such queries is endless, sky (actually: the
available memory) is the limit.

To filter your feeds, press `Shift`+`F` in the feed list, enter your filter
expression, and press `Enter`. To clear the filter, press `Ctrl`+`F`. To
filter the articles in the article list, press `Shift`+`F`, enter your
expression, and press `Enter`. Clearing the filter works the same as before.
Be aware that only certain attributes work in both dialogs. The table below
lists all available attributes and their context, i.e. an attribute that
belongs to a feed can only be matched in the feed list, while an attribute
that belongs to an article can only be matched in the article list.

Table 1. Available Comparison Operators Operator | Meaning  
---|---  
= / == | test for equality  
!= | test for inequality; logical negation of the = operator  
=~ | test whether [POSIX extended regular expression](https://pubs.opengroup.org/onlinepubs/9699919799.2008edition/basedefs/V1_chap09.html) matches, case-insensitively  
!~ | logical negation of the =~ operator  
< | less than  
> | greater than  
<= | less than or equal  
>= | greater than or equal  
between | within a range of integer values, where the two integer values are separated by a colon (see above for an example)  
# | contains; this operator matches if a word is contained in a list of space-separated words (useful for matching tags, see below)  
!# | contains not; the negation of the # operator  
Table 2. Available Attributes Attribute | Context | Meaning  
---|---|---  
title | article | article title  
link | article | article link  
author | article | article author  
content | article | article body  
date | article | publication date of the article  
guid | article | a unique identifier of the article  
unread | article | indicates whether the article has been read  
enclosure_url | article | the URL of an enclosure (e.g. podcast file), empty if there is no enclosure  
enclosure_type | article | the MIME type of the enclosure, empty if there is no enclosure  
flags | article | The set of flags of the article  
age | article | Number of days since the article was published  
articleindex | article | Index of an article in an article list  
feedtitle | feed, article | title of the feed  
description | feed, article | feed description  
feedlink | feed, article | link to the feed  
feeddate | feed, article | publication date of the feed  
rssurl | feed, article | RSS URL of the feed  
unread_count | feed, article | number of unread articles in the feed  
total_count | feed, article | total number of articles in the feed  
tags | feed, article | space-separated list of tags that are associated with the feed. Note that for tags that have spaces in them, it's impossible to tell where they start and end, so # and !# operators don't work for such tags.  
feedindex | feed, article | Index of a feed in the feed list  
latest_article_age | feed, article | Number of days since the most recent article in a feed was published  
  
Note that it's also possible to filter for feed attributes when you query for
article attributes. This is because every article is internally linked to the
feed from which it was downloaded.

### 7.6. Killfiles

Sometimes, a user is confronted with certain content they don't want to read,
e.g. on topics the user is not interested in or articles written by certain
people. In Usenet, such functionality within software is traditionally called
a "killfile", i.e. based on the content of this "killfile", articles that
match certain conditions do not get displayed and are not presented to the
user at all.

In Newsboat, such a "killfile" can be implemented on a per-article basis via
the configuration file. The most important configuration command for this is
`ignore-article`:

    
    
    ignore-article "https://synflood.at/blog/index.php?/feeds/index.rss2" "title =~ \"newsboat\""
    ignore-article "regex:https?://nitter.net/.*" "title =~ \"^RT by\""
    ignore-article "*" "title =~ \"Gentoo\""

It takes two parameters. The first one is either:

  * The URL of a feed.

  * A pattern prefixed with `regex:`. The pattern must be a [POSIX extended regular expression](https://pubs.opengroup.org/onlinepubs/9699919799.2008edition/basedefs/V1_chap09.html), which will be matched case-insensitive.

  * `"*"` to match any feed (asterisk is _not_ a pattern, glob or regex—we simply reserve it to mean "all feeds").

The second argument is a filter expression for an article, probably in double
quotes to preserve spaces inside. If Newsboat hits an article in the specified
RSS feed that matches the specified filter expression, then this article is
ignored and never presented to the user. The configuration itself can contain
as many `ignore-article` commands as desired.

You can also specify the way an article is ignored. There are two ways
available:

  * During download: articles are ignored when a feed is downloaded and parsed, and thus won't be written to the local cache.

  * During display: articles are downloaded and written to the local cache, but are ignored when a feed is displayed.

Both modes have their advantages and disadvantages: while the download ignore
mode saves some storage, you cannot simply "undo" the ignore by removing it
from the configuration file: if an ignored article has already vanished from a
feed, it won't reappear. On the other hand, the display ignore mode requires
some more space, but has the advantage that an ignore can be "undone" by
removing the ignore-article configuration command from the configuration.

The default ignore mode is `"download"`. You can set the `ignore-mode` in the
configuration file:

    
    
    ignore-mode "display"

### 7.7. Query Feeds

Query feeds are a mechanism of Newsboat to define custom "meta feeds" by using
Newsboat's built-in filter language. A query feed is a feed that is aggregated
from all currently downloaded articles of all feeds. To narrow down the set of
articles, the user has to specify a filter. Only articles that match this
filter are added to the query feed.

A query feed is updated whenever it is entered in the feed list. When you
change the unread flag of an article, this is reflected in the feed where the
article was originally fetched. If you want query feeds to be updated at
startup, set `prepopulate-query-feeds` to `yes`.

To define a query feed, the user has to add a line to the _urls_ file in the
following format:

    
    
    query:<name of feed>:<filter expression> [<tag> ...]

The `query:` in the beginning tells Newsboat that it's a query feed, `<name of
feed>` specifies the name under which the query feed shall be displayed in the
feed list, and `<filter expression>` is the filter expression that shall be
used. Like every other feed, a query feed can be tagged to organize it like a
regular feed.

This feature is often used to create a feed that contains all unread articles:

    
    
    "query:Unread Articles:unread = \"yes\""

Note the use of double quotes to preserve spaces in the filter expression.

If you want to combine several feeds to one single feed, a good solution is to
tag the feeds that you want to combine with one certain tag, and then create a
query feed that only displays articles from feeds with that certain tag:

    
    
    https://domain1.tld/feed.xml fun news tag1
    https://domain2.tld/?feed.rss private jokes tag1
    https://domain3.tld/feeds.rss news
    "query:tag1 Articles:tags # \"tag1\""

In this example, the feeds <https://domain1.tld/feed.xml> and
<https://domain2.tld/?feed.rss> are aggregated into the query feed named "tag1
Articles", but the feed <https://domain3.tld/feeds.rss> is not.

Basically, the possibility of what can be realized with query feeds is only
limited by what can be queried from articles and feeds with the filter
language and by your creativity.

### 7.8. Flagging Articles

To support custom categorization of articles by the user, it is possible to
flag an article. A valid flag is any character from _A_ to _Z_ and from _a_ to
_z_. Every article can be flagged with up to 52 different flags, i.e. every
letter from the Roman alphabet in upper and lower case. Flagging is easy: just
select an article in the article list, or enter the article view, and press
:`Ctrl`+`E`. This will start the flag editor. By pressing `Enter`, the new
flags are saved. You can cancel by pressing the `Esc` key.

The flags of an article can be used in every filter expression. The flags of
an article are always ordered, and when new flags are added, ordering is
immediately restored. This behaviour can also be relied upon when querying
articles via the filter language.

If an article contains one or more flags, it is marked with an "!" in the
article list. In the article view, all flags (if available) are listed.

### 7.9. Commandline Commands

Newsboat comes with a `-x` option that indicates that commands added as
arguments to the command line shall be executed. Currently, the following
commands are available:

  * `reload`: this option reloads all feeds, and quits Newsboat without printing any output. This is useful if a user wants to periodically reload all feeds without always having a running Newsboat instance, e.g. from cron.

  * `print-unread`: this option prints the number of unread articles and quits Newsboat. This is useful for users who want to integrate this number into some kind of monitoring system.

### 7.10. Format Strings

Newsboat contains a powerful format string system to make it possible for the
user to configure the format of various aspects of the application, such as
the format of entries in the feed list or in the article list.

Format strings are similar to those that are found in the `printf` function in
the C programming language. A format sequence begins with the _%_ character,
followed by optional alignment indication: positive numbers indicate that the
text that is inserted for the sequence shall be padded on the left to a total
width that is specified by the number, while negative number specify padding
on the right. Followed by the padding indication comes the actual sequence
identifier, which is usually a single letter. `%=[width][identifier]` centers
the sequence, where if w=0 the whole width of the window is used.

In addition, Newsboat provides other, more powerful sequences, such as
`%>[char]`, which indicates that the text right to the sequence will be
aligned right on the screen, and characters between the text on the left and
the text on the right will be filled by `[char]`. Another powerful format is
the conditional sequence, `%?[char]?[format 1]&[format 2]?`: if the text of
the sequence identifier `[char]` contains any non-whitespace characters, then
`[format 1]` will be evaluated and inserted, otherwise `[format 2]` will be
evaluated and inserted. The `&` and `[format 2]` are optional, i.e. if the
identifier's text is empty, then an empty string will be inserted.

The following tables show what sequence identifiers are available for which
format:

Table 3. Available Identifiers for feedlist-format Identifier | Meaning  
---|---  
d | Feed description  
i | Feed index  
l | Feed link  
L | Feed RSS URL  
n | "unread" flag field  
S | download status  
t | Feed title  
T | First tag of a feed in the URLs file  
u | "unread/total" field  
U | "unread" field  
c | "total" field  
  
While a `reload-all` operation is running, the download status indicates the
download status of a feed, which can be "to be downloaded" (indicated by "_"),
"currently downloading" (indicated by "."), successfully downloaded (indicated
by " ") and "download error" (indicated by "x").

Table 4. Available Identifiers for articlelist-format Identifier | Meaning  
---|---  
a | Article author  
D | Publication date. This can be tweaked further with datetime-format  
f | Two characters: 1) "N" if article is unread, "D" if article is deleted, a space otherwise; 2) "!" if article has flags, a space otherwise.  
n | "unread" field  
d | "deleted" field  
F | Article flags  
i | Article index  
t | Article title  
T | If the article list displays articles from different feeds, then this identifier contains the title of the feed to which the article belongs.  
L | Article length  
e | Article enclosure URL  
Table 5. Available Identifiers for selecttag-format Identifier | Meaning  
---|---  
i | Line's index in the list  
T | The tag this line corresponds to  
f | Number of unread feeds under this tag  
n | Number of unread articles in feeds tagged with this tag  
u | Number of feeds tagged with this tag  
Table 6. Available Identifiers for notify-format Identifier | Meaning  
---|---  
n | Number of unread articles  
f | Number of unread feeds  
d | Number of new unread articles (i.e. that were added through the last reload)  
D | Number of new unread feeds (i.e. that were added through the last reload)  
Table 7. Available Identifiers for podlist-format Identifier | Meaning  
---|---  
i | Download index  
d | Currently downloaded size in megabytes, displays one digit of precision  
t | Total download size in megabytes, displays one digit of precision  
p | Downloaded precentage, displays one digit of precision  
k | Download speed, displays two digit of precision, always in KB/s (does not include the "KB/s" text)  
K | Download speed, displays two digit of precision, human readable (automatically switches between KB/s, MB/s, and GB/s)  
S | Status of download, displays one of the folowing; "queued", "downloading", "ready", "canceled", "deleted", "missing", "played", "finished" or "failed"  
u | Url of the download  
F | Absolute filename of the download from the root directory (e.g. ~/downloads/podcast.mp3 -> /home/name/downloads/podcast.mp3)  
b | Basename of the download (e.g. /home/name/downloads/podcast.mp3 -> podcast.mp3)  
  
Examples:

    
    
    feedlist-format     "%4i %n %11u %t"
    articlelist-format  "%4i %f %D   %?T?|%-17T|  ?%t"
    notify-format       "%d new articles (%n unread articles, %f unread feeds)"
    podlist-format      "%4i [%-5p %%] %-12S %F"

Table 8. Available Identifiers for download-path and download-filename-format Identifier | Meaning  
---|---  
u | Filename part of the download URL. May be empty. May include [a query string](https://en.wikipedia.org/wiki/Query_string)  
n | Name of the podcast feed  
N | Name of the podcast feed. Contains the original feed's name, even when selected through a query feed  
h | Name of the podcast feed's hostname  
t | Title of the podcast episode  
e | Extension of the podcast episode  
F | Publication date of the podcast episode formatted as yyyy-mm-dd  
m | Month when podcast episode was published  
b | Abbreviated month name when podcast episode was published  
d | Day when podcast episode was published  
H | Hour when podcast episode was published  
M | Minute when podcast episode was published  
S | Second when podcast episode was published  
y | Year when podcast episode was published formatted as yy  
Y | Year when podcast episode was published formatted as yyyy  
  
#### 7.10.1. Dialog Titles

You can customize the title format of all available dialogs. Here is a list of
dialogs with their respective title format configuration variables, and a list
of available formats and their meaning. Please note that the title formats are
localized, so if you work on a different locale that is supported by Newsboat,
the actually displayed title text may vary unless you customize it.

Table 9. Dialog Title Formats Dialog | Configuration Variable | Default Value  
---|---|---  
Feed List | feedlist-title-format | 
    
    
    %N %V - %?F?Feeds&Your feeds? (%u unread, %t total)%?F? matching filter '%F'&?%?T? - tag '%T'&?  
  
Article List | articlelist-title-format | 
    
    
    %N %V - Articles in feed '%T' (%u unread, %t total)%?F? matching filter '%F'&? - %U  
  
Search Result | searchresult-title-format | 
    
    
    %N %V - Search results for '%s' (%u unread, %t total)%?F? matching filter '%F'&?  
  
File Browser | filebrowser-title-format | 
    
    
    %N %V - %?O?Open File&Save File? - %f  
  
Directory Browser | dirbrowser-title-format | 
    
    
    %N %V - %?O?Open Directory&Save File? - %f  
  
Help | help-title-format | 
    
    
    %N %V - Help  
  
Select Tag Dialog | selecttag-title-format | 
    
    
    %N %V - Select Tag  
  
Select Filter Dialog | selectfilter-title-format | 
    
    
    %N %V - Select Filter  
  
Article View | itemview-title-format | 
    
    
    %N %V - Article '%T' (%u unread, %t total)  
  
URL View | urlview-title-format | 
    
    
    %N %V - URLs  
  
Dialog List | dialogs-title-format | 
    
    
    %N %V - Dialogs  
  
Table 10. Common Title Format Identifiers Identifier | Meaning  
---|---  
N | Name of the program, i.e. "Newsboat"  
V | Program version  
Table 11. Feed List Title Format Identifiers Identifier | Meaning  
---|---  
T | Currently selected tag (empty if none selected)  
t | Number of total feeds  
u | Number of unread feeds  
U | Number of unread articles  
F | Current filter expression (empty if no filter is active)  
Table 12. Article List Title Format Identifiers Identifier | Meaning  
---|---  
T | Feed title  
U | Feed URL  
u | Number of unread articles  
t | Number of total articles  
F | Current filter expression (empty if no filter is active)  
Table 13. Search Result Title Format Identifiers Identifier | Meaning  
---|---  
s | Search phrase  
…Plus all the ones supported by articlelist-title-format (see table above)  
Table 14. File Browser Title Format Identifiers Identifier | Meaning  
---|---  
f | Current path  
O | Non-empty if file browser is in open mode, empty if in save mode  
Table 15. Directory Browser Title Format Identifiers Identifier | Meaning  
---|---  
f | Current path  
O | Non-empty if directory browser is in open mode, empty if in save mode  
Table 16. Article View Title Format Identifiers Identifier | Meaning  
---|---  
T | Article title  
F | Feed title  
u | Number of unread articles  
t | Number of total articles  
  
### 7.11. Highlighting Text

Newsboat supports the highlighting of text in the feed list, the article list
and the article view, using regular expressions to describe patterns to be
highlighted. The command syntax goes like this:

    
    
    highlight <target> <regex> <fgcolor> [<bgcolor> [<attribute> ...]]

Valid values for `<target>` are `feedlist`, `articlelist`, `article` and
`all`. When specifying `all`, the matching will be done in all three views.
The `<regex>` must be a [POSIX extended regular
expression](https://pubs.opengroup.org/onlinepubs/9699919799.2008edition/basedefs/V1_chap09.html),
which will be matched case-insensitive against the text. If multiple highlight
matches overlap, the style of the later specified highlight rule will be
applied. `<fgcolor>` and `<bgcolor>` specify the foreground color resp. the
background color of the matches. You can also specify 0 or more attributes.
You can find a list of valid colors and attributes in the
[_configuring_colors].

Examples for possible highlighting configurations are:

    
    
    highlight all "newsboat" red
    highlight article "^(Feed|Title|Author|Link|Date):" default default underline
    highlight feedlist "https?://[^ ]+" yellow red bold

Note the use of double quotes to preserve spaces in the regular expressions.

#### 7.11.1. Highlighting Articles in the Article List

In addition to generally highlighting text, there is also a specific way to
highlight articles in the article list based on whether they match a certain
filter expression. This means that you can highlight items in the article list
based on their content. This is done using the `highlight-article`
configuration command.

The syntax is similar to the `highlight` configuration command, with the
difference that there's no need to specify a target (since it only applies in
the article list), and instead of a regular expression, a filter expression is
used. After the filter expression, the colors and attributes are specified in
the same way.

Example:

    
    
    highlight-article "author =~ \"Andreas Krennmair\"" white red bold

Note the use of double quotes to preserve spaces in the filter expression.

#### 7.11.2. Highlighting Feeds in the Feed List

Similarly, feeds can be highlighted in the feed list based on whether they
match a certain filter expression. This is done using the `highlight-feed`
configuration command.

Example:

    
    
    highlight-feed "unread_count > 100" white red bold

Note the use of double quotes to preserve spaces in the filter expression.

### 7.12. Advanced Dialog Management

Newsboat supports an advanced concept of dialogs. Previously, all dialogs
(feed list, article list, article view) were internally laid out as a pure
stack. In 2.0, this changed: all dialogs are managed in a list, and the user
can jump to another, previously opened dialog from everywhere. This allows a
user to open more than one article list, more than one article view, etc., and
switch between them without closing them.

The main dialog for this feature can be reached by pressing the `V` key. This
opens the list of open dialogs. From there, the user can switch to another
dialog by selecting the appropriate entry and pressing `Enter`, or can close
open dialogs by selecting them and pressing `Ctrl`+`X`.

### 7.13. Macro Support

Bindings created with `bind-key` can only execute a single operation, like
`open` or `quit`. Macros where introduced to allow running multiple
operations. However, we now have the `bind` command which is more flexible and
also allows running multiple operations. To read more about the `bind`
command, see Key Bindings.

To execute multiple operations, one can use the `macro` command. To invoke the
macro, the user presses the `macro-prefix` (`,` by default) and then the
macro's key. It's easier to explain with some examples:

    
    
    macro k open; reload; quit  -- "enter feed to reload it"
    macro o open-in-browser; toggle-article-read "read"

Here, we define two macros. Now when the user types `,``K`, Newsboat will
enter the current feed, reload it, and go back to the feedlist. If the user
types `,``O`, Newsboat will open current article in the external browser, and
also mark it read. Note that macros can have a description which will be
displayed in the help dialog when the user presses `?`.

Macros can invoke any of Newsboat's operations. Keep in mind that some
operations only make sense in certain situations, e.g. `reload` doesn't make
sense while viewing an article. If you try to execute an operation that is not
supported by the current dialog, it will be ignored.

The macro prefix can be changed from the default `,` to another key, e.g. `+`
(if you don't unbind the default `,` you're left with two macro prefixes):

    
    
    bind-key + macro-prefix
    unbind-key ,

### 7.14. Open Links with External Commands

#### 7.14.1. Using Browser

The first step to open links outside of Newsboat is to set a default `browser`
in your config file. It can be any command that you would normally run, such
as a web browser or an executable script. For example:

    
    
    browser firefox

The browser command also takes an optional `%u` to specify at which point the
URL should be expanded, `%t` specifying where the type of the URL should be
expanded, `%T` for the title of the feed/article, and `%F` specifying where
the URL of the feed's website (or the URL of the feed itself if not available)
should be expanded. All parameters will be enclosed in single quotes, making
it unnecessary to quote them yourself. If none of the parameters are used, the
URL will be appended at the end of the command. Therefore, the previous
example is equivalent to:

    
    
    browser "firefox %u"

The following table shows the available link types for `%t`:

Table 17. Available Link Types Type | Meaning  
---|---  
feed | URL of the feed's website  
rssfeed | URL of the feed  
article | URL of the article  
link | A URL in an article  
image | An image in an article  
embed_flash | A flash embed in an article  
iframe | An iframe in an article  
video | A video in an article  
audio | Audio in an article  
unknown (bug) | An unknown link type, should not appear  
  
To open any link with your browser, the versatile `open-in-browser` operation
can be used. Its behavior is specific to each dialog.

The default keybinding for `open-in-browser` is `O`. An alternative operation,
`open-in-browser-and-mark-read` also marks the article as read when in the
article list, but doesn't work in the feed list. The default keybinding is
`Shift`+`O`.

Articles usually contain links which point to different resources and
websites. Newsboat detects those links and creates a list which can be seen at
the bottom of the article view. To easily scroll through the list and choose a
link to open, one can go to the URL view with the `U` key.

Those links can also be opened directly from the article view. Relevant
operations are `one` to `zero` (digits written as words) and `goto-url`. Keys
`1` to `0` can be used to open URL 1 to 10. To open URLs above 10, start with
the `#` key, then type the URL's number, and press `Enter`. To use `goto-url`
inside a macro, simply append the URL's number (e.g. `goto-url 11`).

#### 7.14.2. Switching Browser for Different Tasks

To manually change the browser from Newsboat internal command line, type `:set
browser` followed by the command, and press `Enter`. The variable is only set
temporarily (useful for testing), so next time Newsboat is launched, `browser`
will reset to the command specified in your config file:

    
    
    :set browser chromium

It is also possible to modify configuration variables within macros. For
example, one can temporarily modify the browser command to do something else,
such as running an image viewer from the URL view:

    
    
    macro i set browser feh; open-in-browser; set browser elinks

#### 7.14.3. Separating Browser from Newsboat

The default behavior of Newsboat when running external commands is to use the
same terminal for the new application. It is great for a "classical" workflow
i.e., when working from a virtual console without a graphical environment. On
the other hand, it might seem like a limitation if you would like to keep
using Newsboat while the command is running. A few simple tricks can be used
to work with both Newsboat and an external application at the same time. Those
are explained below.

Applications like `firefox`, if already running, will simply open a new tab
when receiving a link, then give control back to Newsboat. Because of that,
Newsboat will be unavailable for a split second, then work can resume.

Other applications without this kind of feature will usually do two things:
print messages and warnings (or in the case of interactive console
applications, overwrite Newsboat interface with their own), while also
blocking user input (which prevents controlling Newsboat). To demonstrate this
behavior, the single-tabbed `surf` browser is used:

    
    
    :set browser surf

To prevent applications from printing messages and warnings over Newsboat
interface (useful mostly for GUI apps), you may need to "redirect standard
output and error" to the `null` device:

    
    
    :set browser "surf %u >/dev/null 2>&1"

At this point, if you try to open a link, you are back to the original
terminal from which Newsboat was initially launched, but input is still
blocked. By adding the `&` character to the very end of the browser command,
the application will run separately from Newsboat, which can then be used (and
even closed) independently of the app:

    
    
    :set browser "surf %u >/dev/null 2>&1 &"

This can be simplified by using Newsboat's `open-in-browser-noninteractively`
operation. The operation runs the browser while keeping Newsboat's view on the
foreground. It does not show any of the browser's `stdout` and `stderr`
output.

    
    
    :set browser "surf %u &"
    :exec open-in-browser-noninteractively

This can also be useful if you want to run a download script in the
background. For example:

    
    
    macro d set browser "youtube-dl %u &"; open-in-browser-noninteractively; set browser elinks

For text-based console applications, it is best to first launch a terminal
emulator, which will in turn execute the remainder of the browser command.
Standard output do not need to be silenced with this technique. Here,
`alacritty` is used. Of course, you can replace it with your go-to terminal
emulator, just remember to set the "command" or "execute" option (`-e` in this
example). To open `lynx` in a dedicated terminal:

    
    
    :set browser "alacritty -e lynx %u &"

Once an application is properly detached, other apps can be launched from the
same instance of Newsboat. Each time, you can decide to either keep the same
browser, or change it to serve a different purpose.

### 7.15. Podcast Support

A podcast is a media file distributed over the internet using syndication
feeds such as RSS, for later playback on portable players or computers.
Newsboat supports downloading, saving and streaming podcasts, though an
external media player is needed for playback. This support differs a bit from
other podcast aggregators or "podcatchers" in how it is done.

Podcast content is transported in RSS feeds via special tags called
"enclosures". Newsboat recognizes these enclosures and stores the relevant
information for every podcast item it finds in an RSS feed. Since version 2.0,
it also recognizes and handles the Yahoo Media RSS extensions.

Remote APIs don't always list those "enclosures", so podcasts might be missing
from Newsboat. Such APIs are marked in the relevant section of our docs. If a
note is missing but you still don't see enclosures in Newsboat, please file an
issue and we'll get to the bottom of it!

The following sections present two different ways to handle podcasts with
Newsboat.

#### 7.15.1. Managing Audio Files with Podboat

What the user can do is to add the podcast download URL to a download queue.
Alternatively, Newsboat can be configured to automatically do that. This queue
is stored in the _queue_ file next to the _cache.db_ file.

The user can then use the download manager `podboat` to download these files
to a directory on the local filesystem. Podboat comes with the Newsboat
package, and features a look and feel very close to the one of Newsboat. It
also shares the same configuration file.

Podcasts that have been downloaded but haven't been played yet remain in the
queue but are marked as downloaded. You can remove them by purging them from
the queue with the `Shift`+`P` key. After you've played a file and close
Podboat, it will be removed from the queue. The downloaded file remains on the
filesystem unless "delete-played-files" is enabled.

A common "use case" is to configure Newsboat to automatically enqueue newly
found podcast download URLs. Then, the user reloads the podcast RSS feeds in
Newsboat, and after that, uses Podboat to view the current queue, and either
selectively download certain files or automatically download them all together
by pressing `A` within Podboat.

A macro can also be used to enqueue any of the URLs from the URLs view to
Podboat's download queue:

    
    
    macro E set browser "echo %u >> ~/.newsboat/queue"; open-in-browser; set browser elinks

#### 7.15.2. Streaming Audio Content with a Media Player

As an alternative to Podboat file management, media players such as `mpv` can
stream content directly when given a URL. Since Newsboat always assign the
enclosure link to URL 1, the operation `one` can be used to open the audio
file (beware that this operation will always open URL 1, even if no enclosure
is found). To listen to your podcast from the article view, a basic macro
would be:

    
    
    macro 1 set browser mpv; one; set browser firefox

For media players with a graphical user interface like `vlc`, console output
will typically need to be silenced with `>/dev/null 2>&1`. Also, the `&`
character at the end of the browser command will detach the media player from
Newsboat. You can then read your articles while listening to podcasts:

    
    
    macro v set browser "vlc %u >/dev/null 2>&1 &"; one; set browser firefox

With mpv, the podcast cover art is fetched automatically when using the
pseudo-gui. The `--` near the end will prevent mpv from interpreting the
following arguments as options:

    
    
    macro p set browser "mpv --player-operation-mode=pseudo-gui -- %u &"; one; set browser firefox

To use mpv's console interface instead, first launch a terminal emulator which
will in turn execute mpv. This way, Newsboat and the media player can both be
controlled with text-based interfaces, side by side:

    
    
    macro c set browser "alacritty -e mpv --vid=no -- %u &"; one; set browser firefox

If you are working without a graphical environment (e.g. from a virtual
console), you want to make sure the media player doesn't try to launch a
graphical user interface. With mpv, the `--vid=no` option can be used for this
purpose:

    
    
    macro n set browser "mpv --vid=no --"; one; set browser lynx

Another use case for this macro would be when running Newsboat on a remote
host, while logged in through a secure shell (e.g. OpenSSH). With this setup,
Newsboat will effectively serve as the controller to an ad hoc "remote media
server". Audio will be playing on the remote host.

### 7.16. Running multiple copies of Newsboat simultaneously

During development and testing, you might want to run a second copy of
Newsboat, operating with different config, URLs list or cache file. This can
be achieved by creative use of XDG environment variables. This approach is not
beautiful, but it works.

First of all, you will need to create a directory to store the data. Let's
call it _test_ :

    
    
    $ mkdir -p test/newsboat

Note that we also create a subdirectory called _newsboat_ ; this is required
to satisfy XDG specification. **ATTENTION** : if this subdirectory is absent,
Newsboat will attempt to run on your live data!

You can now create _config_ and _urls_ files inside _test/newsboat_ ; you can
also copy _cache.db_ if you don't want to start with a fresh one.

When the files are ready, you can invoke Newsboat as follows:

    
    
    $ XDG_CONFIG_HOME=test XDG_DATA_HOME=test newsboat

(This will look newsboat binary up in your PATH; if you've just built your
own, use ./newsboat instead, or provide a full path.)

By modifying the environment in which Newsboat runs you also modify
environments of all the programs that Newsboat starts; that includes filters
and external HTML renderers. If they rely on XDG_* variables, they will look
for things in test directory and might fail.

For filters, you should either copy the files they need to _test_ , or invoke
them in such a way that they don't look in XDG directories at all.

For renderers, you can work around the issue by undoing the modifications to
environment, e.g.:

    
    
    html-renderer "XDG_CONFIG_HOME=$HOME/.config XDG_DATA_HOME=$HOME/.data w3c"

As already said: not beautiful, but gets the job done.

### 7.17. Using SQLite Triggers with Newsboat

This section was written by [Elrond](mailto:elrond+newsbeuter\(at\)samba-
tng.org), originally for Newsbeuter.

SQLite, the db used by Newsboat, supports triggers. These are small snippets
of SQL that get executed inside the database by the database engine. They're
stored inside the db and the normal user (including Newsboat itself) doesn't
see them. Just the db seems to do some magic: Like changing some values when
you change another value.

So what is this good for when looking at Newsboat? Well, first off, it's a
hack. The real answer should be to use application logic (do it inside
Newsboat, not in the db). So: Don't use this, unless you know, what you're
doing, and unless you have some sort of backup.

#### 7.17.1. Example

So after the "don't use it" you still want to know, what one can do? So here's
an example.

Suppose you have a strange feed where the articles become "new" by just
changing their subject, and nothing else changes. The body is just empty, and
the URL keeps the same. This feed really exists. It's the "updated software
rss feed" of some major company and the title just contains the name of the
driver and version number. And the URL points to the download page. Newsboat
considers articles only as new, when they have a new UniqueID (this is good).
So those articles are never marked as new (unread) ever again.

So what can we do? We do some magic: We let the db test if Newsboat changes
the subject and then let itself mark the article again as unread.

  1. You need the `sqlite3` command line tool (available via `apt-get install sqlite3` on Debian) or some other tool to do direct sql on the sqlite database.

  2. Start `sqlite3` with the Newsboat db:
    
        Rivendell:~/.newsboat% sqlite3 cache.db
    SQLite version 3.4.2
    Enter ".help" for instructions
    sqlite>

  3. Create the trigger:
    
        sqlite> create trigger update_item_title update of title on rss_item
       > for each row when old.title != new.title
       > begin
       >   update rss_item set unread = 1 where rowid == new.rowid;
       > end;

  4. Leave `sqlite3` with `Ctrl`+`D` or `.quit`.

That's it. Newsboat (well, its db) now marks articles as unread when their
title changes. And nicely enough this works all inside Newsboat, no need to
restart it so that it rereads the cache, that magically modifies itself. It
just works.

### 7.18. Environment variables

`BROWSER`

    

Tells Newsboat what browser to use if there is no `browser` setting in the
config file. If this variable doesn't exist, a default of `lynx(1)` will be
used.

`CURL_CA_BUNDLE`

    

Tells Newsboat to use the specified certificate file to verify the peer. The
file may contain multiple certificates. The certificate(s) must be in PEM
format.

This option is useful if your libcurl is built without useful certificate
information, and you can't rebuild the library yourself.

`EDITOR`

    

Tells Newsboat what fallback editor to use when editing the _urls_ file via
the `edit-urls` operation and no `VISUAL` environment variable is set. If this
variable doesn't exist either, a default of `vi(1)` will be used.

`NO_PROXY`

    

Tells Newsboat to ignore `proxy` setting for certain sites.

This variable contains a comma-separated list of hostnames, domain names, and
IP addresses.

Domain names match subdomains, i.e. "example.com" also matches
"foo.example.com". Domain names that start with a dot only match subdomains,
e.g. ".example.com" matches "bar.example.com" but not "example.com" itself.

IPv6 addresses are written without square brackets, and _are matched as
strings_. Thus "::1" doesn't match "::0:1" even though this is the same
address.

`PAGER`

    

Tells Newsboat what pager to use if the `pager` setting in the config file is
explicitly set to an empty string.

`TMPDIR`

    

Tells Newsboat to use the specified directory for storing temporary files. If
this variable doesn't exist, a default of _/tmp_ will be used.

`VISUAL`

    

Tells Newsboat what editor to use when editing the _urls_ file via the `edit-
urls` operation. If this variable doesn't exist, the `EDITOR` environment
variable will be used.

`XDG_CONFIG_HOME`

    

Tells Newsboat which base directory to use for the configuration files. See
also the section on files for more information.

`XDG_DATA_HOME`

    

Tells Newsboat which base directory to use for the data files. See also the
section on files for more information.

## 8\. Feedback and security

Please report security vulnerabilities to
[security@newsboat.org](mailto:security@newsboat.org), encrypting your emails
to [OpenPGP key 4ED6CD61932B9EBE](https://newsboat.org/newsboat.pgp) if at all
possible.

Non-security issues and general questions can be discussed on [the issue
tracker](https://github.com/newsboat/newsboat/issues/) and [the mailing
list](mailto:newsboat@googlegroups.com).

You can chat with developers and fellow users on #newsboat at
[irc.libera.chat](https://libera.chat/) (also accessible [via
webchat](https://web.libera.chat/) and [via
Matrix](https://matrix.to/#/#newsboat:libera.chat)). We _do not_ have a
channel on Freenode anymore.

## Appendix A: Newsboat Configuration Commands

* * *

**Syntax:** always-display-description [yes/no]  
**Default:** no  
**Example:** always-display-description yes  

If set to `yes`, then the description will always be displayed even if e.g. a
`<content:encoded>` tag has been found.  

* * *

**Syntax:** always-download <url> [<url>…​]  
**Default:** n/a  
**Example:** always-download "https://www.n-tv.de/23.rss"  

Specifies one or more feed URLs that should always be downloaded, regardless
of their Last-Modified timestamp and ETag header. This option can be specified
multiple times.  

* * *

**Syntax:** article-sort-order <sortfield>[-<direction>]  
**Default:** date-asc  
**Example:** article-sort-order author-desc  

The <sortfield> specifies which article property shall be used for sorting.
Currently available are: `date`, `title`, `flags`, `author`, `link`, `guid`,
and `random`. The optional <direction> can be either `asc` for ascending
order, or `desc` for descending order. Note that direction does not affect the
`random` sorting. For `date`, `desc` order is the default, i.e. `date` is the
same as `date-desc`; for all others, `asc` is the default. Also, the
directions for `date` are reversed: `desc` means the newest items are first,
whereas `asc` means the oldest items are first. These inconsistencies will be
fixed in a future major version of Newsboat.  

* * *

**Syntax:** articlelist-format <format>  
**Default:** "%4i %f %D %6L %?T?|%-17T| ?%t"  
**Example:** articlelist-format "%4i %f %D %?T?|%-17T| ?%t"  

This variable defines the format of entries in the article list. See the
respective section in the documentation for more information on format
strings.  

* * *

**Syntax:** articlelist-title-format <format>  
**Default:** "%N %V - Articles in feed '%T' (%u unread, %t total)%?F? matching
filter '%F'&? - %U" (localized)  
**Example:** articlelist-title-format "Articles in feed '%T' (%u unread)"  

Format of the title in article list. See "Format Strings" section of Newsboat
manual for details on available formats.  

* * *

**Syntax:** auto-reload [yes/no]  
**Default:** no  
**Example:** auto-reload yes  

If set to `yes`, all feeds will be automatically reloaded at start up and then
continuously after a certain time has passed (see `reload-time`). See also
`refresh-on-startup` to only reload the feeds at start up, but not
continuously. Enabling `suppress-first-reload` omits the reload on start up.  

* * *

**Syntax:** bind <key-sequence> <dialog>[,<dialog>] <command-list> [--
"<binding description>"]  
**Default:** n/a  
**Example:** bind of everywhere set browser "firefox" ; open-in-browser  

Bind sequence of keys <key-sequence> to <command-list>. This means that
whenever the keys in <key-sequence> are pressed in order, then the list of
commands in <command-list> is executed (if applicable in the current dialog).
For more information see Key Bindings. Optionally, a description can be added.
If present, the description is shown in the help form. See also `unbind-key`
to remove a key binding.  

* * *

**Syntax:** bind-key <key> <operation> [<dialog>]  
**Default:** n/a  
**Example:** bind-key ^R reload-all  

Bind key <key> to <operation>. This means that whenever <key> is pressed, then
<operation> is executed (if applicable in the current dialog). For more
information see Old Style Key Bindings. See also `unbind-key` to remove a key
binding.  

* * *

**Syntax:** bookmark-autopilot [yes/no]  
**Default:** no  
**Example:** bookmark-autopilot yes  

If set to `yes`, the configured bookmark command is executed without any
further input asked from user, unless the url or the title cannot be
found/guessed.  

* * *

**Syntax:** bookmark-cmd <command>  
**Default:** n/a  
**Example:** bookmark-cmd "~/bin/delicious-bookmark.sh"  

If set, then <command> will be used as bookmarking plugin. See the
documentation on bookmarking for further information.  

* * *

**Syntax:** bookmark-interactive [yes/no]  
**Default:** no  
**Example:** bookmark-interactive yes  

If set to `yes`, then the configured bookmark command is an interactive
program.  

* * *

**Syntax:** browser <command>  
**Default:** %BROWSER, otherwise lynx  
**Example:** browser "w3m %u"  

Set the browser command to use when opening an article in the browser. If the
`BROWSER` environment variable is set, it will be used as the default browser,
otherwise lynx will be used. For more information, see Using Browser.  

* * *

**Syntax:** cache-file <path>  
**Default:** "~/.newsboat/cache.db" or "~/.local/share/cache.db" (see "Files"
section)  
**Example:** cache-file "/tmp/testcache.db"  

This configuration option sets the cache file. This is especially useful if
the filesystem of your home directory doesn't support proper locking (e.g.
NFS).  

* * *

**Syntax:** cleanup-on-quit [yes/no]  
**Default:** yes  
**Example:** cleanup-on-quit no  

If set to `yes`, then the cache gets locked and superfluous feeds and items
are removed, such as feeds that can't be found in the urls configuration file
anymore. Run `newsboat --cleanup` to do this manually. If you encounter a
warning about unreachable feeds having been found, you may see the feed urls
listed by creating a log file via the `error-log` option.  

* * *

**Syntax:** color <element> <fgcolor> <bgcolor> [<attribute> …​]  
**Default:** n/a  
**Example:** color background white black  

Set the foreground color, background color and optional attributes for a
certain element.  

* * *

**Syntax:** confirm-delete-all-articles [yes/no]  
**Default:** yes  
**Example:** confirm-delete-all-articles no  

If set to `yes`, then Newsboat will ask for confirmation whether the user
wants to delete all articles.  

* * *

**Syntax:** confirm-exit [yes/no]  
**Default:** no  
**Example:** confirm-exit yes  

If set to `yes`, then Newsboat will ask for confirmation whether the user
really wants to quit Newsboat.  

* * *

**Syntax:** confirm-mark-all-feeds-read [yes/no]  
**Default:** yes  
**Example:** confirm-mark-all-feeds-read no  

If set to `yes`, then Newsboat will ask for confirmation whether the user
wants to mark all feeds as read.  

* * *

**Syntax:** confirm-mark-feed-read [yes/no]  
**Default:** yes  
**Example:** confirm-mark-feed-read no  

If set to `yes`, then Newsboat will ask for confirmation on whether the user
wants to mark a feed as read.  

* * *

**Syntax:** cookie-cache <path>  
**Default:** n/a  
**Example:** cookie-cache "~/.newsboat/cookies.txt"  

Set a cookie cache. If set, cookies will be cached in (i.e. read from and
written to) this file, using [Netscape
format](http://www.cookiecentral.com/faq/#3.5).  

* * *

**Syntax:** datetime-format <date/time format>  
**Default:** %b %d  
**Example:** datetime-format "%D, %R"  

This format specifies the date/time format in the article list. For a detailed
documentation on most of the allowed formats, consult the manpage of
strftime(3). %L is a custom format not available in strftime which lists the
days since the article was published (e.g. "2 days ago").  

* * *

**Syntax:** define-filter <name> <filterexpr>  
**Default:** n/a  
**Example:** define-filter "all feeds with 'fun' tag" "tags # \"fun\""  

With this command, you can predefine filters, which you can later select from
a list, and which are then applied after selection. This is especially useful
for filters that you need often and you don't want to enter them every time
you need them.  

* * *

**Syntax:** delete-read-articles-on-quit [yes/no]  
**Default:** no  
**Example:** delete-read-articles-on-quit yes  

If set to `yes`, all read articles will be deleted when quiting Newsboat. This
option only applies if `cleanup-on-quit` is set to `yes` or if the `--cleanup`
argument is passed.  

* * *

**Syntax:** dialogs-title-format <format>  
**Default:** "%N %V - Dialogs" (localized)  
**Example:** dialogs-title-format "%N %V - Dialogs"  

Format of the title in dialog list. See "Format Strings" section of Newsboat
manual for details on available formats.  

* * *

**Syntax:** dirbrowser-title-format <format>  
**Default:** "%N %V - %?O?Open Directory&Save File? - %f" (localized)  
**Example:** dirbrowser-file-format "%?O?Open Directory&Save File? - %f"  

Format of the title in directory browser. See "Format Strings" section of
Newsboat manual for details on available formats.  

* * *

**Syntax:** display-article-progress [yes/no]  
**Default:** yes  
**Example:** display-article-progress no  

If set to `yes`, then a read progress (in percent) is displayed in the article
view. Otherwise, no read progress is displayed.  

* * *

**Syntax:** download-full-page [yes/no]  
**Default:** no  
**Example:** download-full-page yes  

If set to `yes`, then for all feed items with no content but with a link, the
link is downloaded and the result used as content instead. This may
significantly increase the download times of "empty" feeds.  

* * *

**Syntax:** download-retries <number>  
**Default:** 1  
**Example:** download-retries 4  

How many times Newsboat shall try to successfully download a feed before
giving up. This is an option to improve the success of downloads on slow and
shaky connections such as via a TOR proxy.  

* * *

**Syntax:** download-timeout <number>  
**Default:** 30  
**Example:** download-timeout 60  

The number of seconds Newsboat shall wait when downloading a feed before
giving up. This is an option to improve the success of downloads on slow and
shaky connections such as via a TOR proxy.  

* * *

**Syntax:** error-log <path>  
**Default:** n/a  
**Example:** error-log "~/.newsboat/error.log"  

If set, then user errors (e.g. errors regarding defunct RSS feeds) will be
logged to this file.  

* * *

**Syntax:** external-url-viewer <command>  
**Default:** n/a  
**Example:** external-url-viewer "urlview"  

If set, then `show-urls` will pipe the current article to a specific external
tool instead of using the internal URL viewer. This can be used to integrate
tools such as urlview.  

* * *

**Syntax:** feed-sort-order <sortfield>[-<direction>]  
**Default:** none  
**Example:** feed-sort-order firsttag  

The <sortfield> specifies which feed property shall be used for sorting;
currently available are: `firsttag`, `title`, `articlecount`,
`unreadarticlecount`, `lastupdated` and `none`. The optional <direction>
specifies the sort direction. `asc` specifies ascending sorting, `desc`
specifies descending sorting. `desc` is the default.  

* * *

**Syntax:** feedbin-flag-star <flag>  
**Default:** n/a  
**Example:** feedbin-flag-star "b"  

If set and Feedbin support is used, then all articles that are flagged with
the specified flag are being "starred" in Feedbin and appear in the list of
"Starred items".  

* * *

**Syntax:** feedbin-login <login>  
**Default:** n/a  
**Example:** feedbin-login "your-login"  

This variable sets your Feedbin login for Feedbin support.  

* * *

**Syntax:** feedbin-password <password>  
**Default:** n/a  
**Example:** feedbin-password "here_goesAquote:\""  

This variable sets your Feedbin password for Feedbin support. Double quotes
and backslashes within it should be escaped.  

* * *

**Syntax:** feedbin-passwordeval <command>  
**Default:** n/a  
**Example:** feedbin-passwordeval "gpg --decrypt ~/.newsboat/feedbin-
password.gpg"  

A more secure alternative to the above, is providing your password from an
external command that is evaluated during login. This can be used to read your
password from a gpg encrypted file or your system keyring.  

* * *

**Syntax:** feedbin-passwordfile <path>  
**Default:** n/a  
**Example:** feedbin-passwordfile "~/.newsboat/feedbin-pw.txt"  

Another alternative, by storing your plaintext password elsewhere in your
system.  

* * *

**Syntax:** feedbin-url <url>  
**Default:** "https://api.feedbin.com"  
**Example:** feedbin-url "https://example.com/feedbin/"  

Configures the URL where the Feedbin installation you want to use resides.  

* * *

**Syntax:** feedhq-flag-share <flag>  
**Default:** n/a  
**Example:** feedhq-flag-share "a"  

If set and FeedHQ support is used, then all articles that are flagged with the
specified flag are being "shared" in FeedHQ so that people that follow you can
see it.  

* * *

**Syntax:** feedhq-flag-star <flag>  
**Default:** n/a  
**Example:** feedhq-flag-star "b"  

If set and FeedHQ support is used, then all articles that are flagged with the
specified flag are being "starred" in FeedHQ and appear in the list of
"Starred items".  

* * *

**Syntax:** feedhq-login <login>  
**Default:** n/a  
**Example:** feedhq-login "your-login"  

This variable sets your FeedHQ login for FeedHQ support.  

* * *

**Syntax:** feedhq-min-items <number>  
**Default:** 20  
**Example:** feedhq-min-items 100  

This variable sets the number of articles that are loaded from FeedHQ per
feed.  

* * *

**Syntax:** feedhq-password <password>  
**Default:** n/a  
**Example:** feedhq-password "here_goesAquote:\""  

This variable sets your FeedHQ password for FeedHQ support. Double quotes and
backslashes within it should be escaped.  

* * *

**Syntax:** feedhq-passwordeval <command>  
**Default:** n/a  
**Example:** feedhq-passwordeval "gpg --decrypt ~/.newsboat/feedhq-
password.gpg"  

A more secure alternative to the above, is providing your password from an
external command that is evaluated during login. This can be used to read your
password from a gpg encrypted file or your system keyring.  

* * *

**Syntax:** feedhq-passwordfile <path>  
**Default:** n/a  
**Example:** feedhq-passwordfile "~/.newsboat/feedhq-pw.txt"  

Another alternative, by storing your plaintext password elsewhere in your
system.  

* * *

**Syntax:** feedhq-show-special-feeds [yes/no]  
**Default:** yes  
**Example:** feedhq-show-special-feeds "no"  

If set and FeedHQ support is used, then "special feeds" like "People you
follow" (articles shared by people you follow), "Starred items" (your starred
articles) and "Shared items" (your shared articles) appear in your
subscription list.  

* * *

**Syntax:** feedhq-url <url>  
**Default:** "https://feedhq.org/"  
**Example:** feedhq-url "https://feedhq.example.com/"  

Configures the URL where your FeedHQ instance resides.  

* * *

**Syntax:** feedlist-format <format>  
**Default:** "%4i %n %11u %t"  
**Example:** feedlist-format " %n %4i - %11u -%> %t"  

This variable defines the format of entries in the feed list. See the
respective section in the documentation for more information on format
strings.  

* * *

**Syntax:** feedlist-title-format <format>  
**Default:** "%N %V - %?F?Feeds&Your feeds? (%u unread, %t total)%?F? matching
filter '%F'&?%?T? - tag '%T'&?" (localized)  
**Example:** feedlist-title-format "Feeds (%u unread, %t total)"  

Format of the title in feed list. See "Format Strings" section of Newsboat
manual for details on available formats.  

* * *

**Syntax:** filebrowser-title-format <format>  
**Default:** "%N %V - %?O?Open File&Save File? - %f" (localized)  
**Example:** filebrowser-title-format "%?O?Open File&Save File? - %f"  

Format of the title in file browser. See "Format Strings" section of Newsboat
manual for details on available formats.  

* * *

**Syntax:** freshrss-flag-star <flag>  
**Default:** n/a  
**Example:** freshrss-flag-star "b"  

If set and FreshRSS support is used, then all articles that are flagged with
the specified flag are being "starred" in FreshRSS and appear in the list of
"Starred items".  

* * *

**Syntax:** freshrss-login <login>  
**Default:** n/a  
**Example:** freshrss-login "your-login"  

This variable sets your FreshRSS login for FreshRSS support.  

* * *

**Syntax:** freshrss-min-items <number>  
**Default:** 20  
**Example:** freshrss-min-items 100  

This variable sets the number of articles that are loaded from FreshRSS per
feed.  

* * *

**Syntax:** freshrss-password <password>  
**Default:** n/a  
**Example:** freshrss-password "here_goesAquote:\""  

This variable sets your FreshRSS password for FreshRSS support. Double quotes
and backslashes within it should be escaped.  

* * *

**Syntax:** freshrss-passwordeval <command>  
**Default:** n/a  
**Example:** freshrss-passwordeval "gpg --decrypt ~/.newsboat/freshrss-
password.gpg"  

A more secure alternative to the above, is providing your password from an
external command that is evaluated during login. This can be used to read your
password from a gpg encrypted file or your system keyring.  

* * *

**Syntax:** freshrss-passwordfile <path>  
**Default:** n/a  
**Example:** freshrss-passwordfile "~/.newsboat/freshrss-pw.txt"  

Another alternative, by storing your plaintext password elsewhere in your
system.  

* * *

**Syntax:** freshrss-show-special-feeds [yes/no]  
**Default:** yes  
**Example:** freshrss-show-special-feeds "no"  

If set and FreshRSS support is used, then a "Starred items" feed (containing
your starred/favourited articles) appears in your subscription list.  

* * *

**Syntax:** freshrss-url <url>  
**Default:** n/a  
**Example:** freshrss-url "https://freshrss.example.com/api/greader.php"  

Configures the URL for the Google Reader API endpoint of your FreshRSS
instance.  

* * *

**Syntax:** goto-first-unread [yes/no]  
**Default:** yes  
**Example:** goto-first-unread no  

If set to `yes`, then the first unread article will be selected whenever a
feed is entered.  

* * *

**Syntax:** goto-next-feed [yes/no]  
**Default:** yes  
**Example:** goto-next-feed no  

If set to `yes`, then the next-unread, prev-unread and random-unread keys will
search in other feeds for unread articles if all articles in the current feed
are read. If set to `no`, then these keys will stop in the current feed.  

* * *

**Syntax:** help-title-format <format>  
**Default:** "%N %V - Help" (localized)  
**Example:** help-title-format "%N %V - Help"  

Format of the title in help window. See "Format Strings" section of Newsboat
manual for details on available formats.  

* * *

**Syntax:** highlight <target> <regex> <fgcolor> [<bgcolor> [<attribute> …​]]  
**Default:** n/a  
**Example:** highlight all "newsboat" red  

With this command, you can highlight text parts in the feed list, the article
list and the article view.  

* * *

**Syntax:** highlight-article <filterexpr> <fgcolor> <bgcolor> [<attribute>
…​]  
**Default:** n/a  
**Example:** highlight-article "author =~ \"Andreas Krennmair\"" white red
bold  

With this command, you can highlight articles in the article list if they
match a filter expression.  

* * *

**Syntax:** highlight-feed <filterexpr> <fgcolor> <bgcolor> [<attribute> …​]  
**Default:** n/a  
**Example:** highlight-feed **unread** **›** **100** white red bold  

With this command, you can highlight feeds in the feed list if they match a
filter expression.  

* * *

**Syntax:** history-limit <number>  
**Default:** 100  
**Example:** history-limit 0  

Defines the maximum number of entries of commandline resp. search history to
be saved. To disable history saving, set it to 0.  

* * *

**Syntax:** html-renderer <command>  
**Default:** internal  
**Example:** html-renderer "w3m -dump -T text/html"  

If set to `internal`, then the internal HTML renderer will be used. Otherwise,
the specified command will be executed, the HTML to be rendered will be
written to the command's stdin, and the program's output will be displayed.
This makes it possible to use other, external programs, such as w3m, links or
lynx, to render HTML.  

* * *

**Syntax:** http-auth-method <method>  
**Default:** any  
**Example:** http-auth-method digest  

Set HTTP authentication method. Allowed values: `any`, `basic`, `digest`,
`digest_ie` (only available with libcurl 7.19.3 and newer), `gssnegotiate`,
`ntlm` and `anysafe`.  

* * *

**Syntax:** ignore-article <feed> <filterexpr>  
**Default:** n/a  
**Example:** ignore-article "*" "title =~ \"Windows\""  

If a downloaded article from <feed> matches <filterexpr>, then it is ignored
and not presented to the user. This command is further explained in the "kill
file" section below.  

* * *

**Syntax:** ignore-mode [download/display]  
**Default:** download  
**Example:** ignore-mode "display"  

This configuration option defines in what way an article is ignored (see
`ignore-article`). If set to `download`, then it is ignored in the
download/parsing phase and thus never written to the cache, if it set to
`display`, it is ignored when displaying articles but is kept in the cache.  

* * *

**Syntax:** include <path>  
**Default:** n/a  
**Example:** include "~/.newsboat/colors"  

With this command, you can include other files to be interpreted as
configuration files. This is especially useful to separate your configuration
into several files, e.g. key configuration, color configuration, …​  

* * *

**Syntax:** inoreader-app-id <string>  
**Default:** n/a  
**Example:** inoreader-app-id "123456789"  

Unique application ID issued by Inoreader. See "Inoreader" section.  

* * *

**Syntax:** inoreader-app-key <string>  
**Default:** n/a  
**Example:** inoreader-app-key "TmV3c2JvYXQgcm9ja3MgOikK"  

Application key issued by Inoreader. See "Inoreader" section.  

* * *

**Syntax:** inoreader-flag-share <flag>  
**Default:** n/a  
**Example:** inoreader-flag-share "a"  

If set and Inoreader support is used, then all articles that are flagged with
the specified flag are being "shared" in Inoreader so that people that follow
you can see it.  

* * *

**Syntax:** inoreader-flag-star <flag>  
**Default:** n/a  
**Example:** inoreader-flag-star "b"  

If set and Inoreader support is used, then all articles that are flagged with
the specified flag are being "starred" in Inoreader and appear in the list of
"Starred items".  

* * *

**Syntax:** inoreader-login <login>  
**Default:** n/a  
**Example:** inoreader-login "your-login"  

This variable sets your Inoreader login for Inoreader support.  

* * *

**Syntax:** inoreader-min-items <number>  
**Default:** 20  
**Example:** inoreader-min-items 100  

This variable sets the number of articles that are loaded from Inoreader per
feed.  

* * *

**Syntax:** inoreader-password <password>  
**Default:** n/a  
**Example:** inoreader-password "here_goesAquote:\""  

This variable sets your Inoreader password for Inoreader support. Double
quotes and backslashes within it should be escaped.  

* * *

**Syntax:** inoreader-passwordeval <command>  
**Default:** n/a  
**Example:** inoreader-passwordeval "gpg --decrypt ~/.newsboat/inoreader-
password.gpg"  

A more secure alternative to the above, is providing your password from an
external command that is evaluated during login. This can be used to read your
password from a gpg encrypted file or your system keyring.  

* * *

**Syntax:** inoreader-passwordfile <path>  
**Default:** n/a  
**Example:** inoreader-passwordfile "~/.newsboat/inoreader-pw.txt"  

Another alternative, by storing your plaintext password elsewhere in your
system.  

* * *

**Syntax:** inoreader-show-special-feeds [yes/no]  
**Default:** yes  
**Example:** inoreader-show-special-feeds "no"  

If set and Inoreader support is used, then "special feeds" like "Starred
items" (your starred articles) and "Shared items" (your shared articles)
appear in your subscription list.  

* * *

**Syntax:** itemview-title-format <format>  
**Default:** "%N %V - Article '%T' (%u unread, %t total)" (localized)  
**Example:** itemview-title-format "Article '%T'"  

Format of the title in article view. See "Format Strings" section of Newsboat
manual for details on available formats.  

* * *

**Syntax:** keep-articles-days <number>  
**Default:** 0  
**Example:** keep-articles-days 30  

If set to a number greater than 0, only articles that were published within
the last <number> days are kept, and older articles are deleted. If set to 0,
this option is not active. Note that changing this setting won't bring back
the articles that were deleted earlier; currently, there's no non-hacky way to
bring back deleted articles.  

* * *

**Syntax:** macro <macro key> <command list> [-- "<macro description>"]  
**Default:** n/a  
**Example:** macro k open; reload; quit -- "enter feed to reload it"  

With this command, you can define a macro key and specify a list of commands
that shall be executed when the macro prefix and the macro key are pressed.
Optionally, a description can be added. If present, the description is shown
in the help form.  

* * *

**Syntax:** mark-as-read-on-hover [yes/no]  
**Default:** no  
**Example:** mark-as-read-on-hover yes  

If set to `yes`, then all articles that get selected in the article list are
marked as read.  

* * *

**Syntax:** max-browser-tabs <number>  
**Default:** 10  
**Example:** max-browser-tabs 4  

Set the maximum number of articles to open in a browser when using the `open-
all-unread-in-browser` or `open-all-unread-in-browser-and-mark-read` commands.  

* * *

**Syntax:** max-download-speed <number>  
**Default:** 0  
**Example:** max-download-speed 50  

If set to a number greater than 0, the download speed per download is set to
that limit (in KB/s).  

* * *

**Syntax:** max-items <number>  
**Default:** 0  
**Example:** max-items 100  

Set the maximum number of articles a feed can contain. When the threshold is
crossed, old articles are dropped. If the number is set to 0, then all
articles are kept.  

* * *

**Syntax:** miniflux-flag-star <flag>  
**Default:** n/a  
**Example:** miniflux-flag-star "b"  

If set and Miniflux support is used, then all articles that are flagged with
the specified flag are being "starred" in Miniflux and appear in the list of
"Starred items".  

* * *

**Syntax:** miniflux-login <username>  
**Default:** n/a  
**Example:** miniflux-login "admin"  

Sets the username for use with Miniflux.  

* * *

**Syntax:** miniflux-min-items <number>  
**Default:** 100  
**Example:** miniflux-min-items 20  

This variable sets the number of articles that are loaded from Miniflux per
feed.  

* * *

**Syntax:** miniflux-password <password>  
**Default:** n/a  
**Example:** miniflux-password "here_goesAquote:\""  

Configures the password for use with Miniflux. Double quotes and backslashes
within it should be escaped.  

* * *

**Syntax:** miniflux-passwordeval <command>  
**Default:** n/a  
**Example:** miniflux-passwordeval "gpg --decrypt ~/.newsboat/miniflux-
password.gpg"  

A more secure alternative to the above, is providing your password from an
external command that is evaluated during login. This can be used to read your
password from a gpg encrypted file or your system keyring.  

* * *

**Syntax:** miniflux-passwordfile <path>  
**Default:** n/a  
**Example:** miniflux-passwordfile "~/.newsboat/miniflux-pw.txt"  

Another alternative, by storing your plaintext password elsewhere in your
system.  

* * *

**Syntax:** miniflux-show-special-feeds [yes/no]  
**Default:** yes  
**Example:** miniflux-show-special-feeds "no"  

If set and Miniflux support is used, then a "Starred items" feed (containing
your starred/favourited articles) appears in your subscription list.  

* * *

**Syntax:** miniflux-token <API Token>  
**Default:** n/a  
**Example:** miniflux-token "E-uTqU8r55KucuHz26tJbXfrZVRndwY_mZAsEfcC8Bg="  

Sets the API Token for use with Miniflux.  

* * *

**Syntax:** miniflux-tokeneval <command>  
**Default:** n/a  
**Example:** miniflux-tokeneval "gpg --decrypt ~/.newsboat/miniflux-token.gpg"  

A more secure alternative to the above, is providing your API token from an
external command that is evaluated during login. This can be used to read your
token from a gpg encrypted file or your system keyring.  

* * *

**Syntax:** miniflux-tokenfile <API Token>  
**Default:** n/a  
**Example:** miniflux-tokenfile "~/.newsboat/miniflux-token.txt"  

Another alternative, by storing your plaintext token elsewhere in your system.  

* * *

**Syntax:** miniflux-url <url>  
**Default:** n/a  
**Example:** miniflux-url "https://example.com/miniflux/"  

Configures the URL where the Miniflux installation you want to use resides.  

* * *

**Syntax:** newsblur-login <login>  
**Default:** n/a  
**Example:** newsblur-login "your-login"  

This variable sets your NewsBlur login for NewsBlur support.  

* * *

**Syntax:** newsblur-min-items <number>  
**Default:** 20  
**Example:** newsblur-min-items 100  

This variable sets the number of articles that are loaded from NewsBlur per
feed.  

* * *

**Syntax:** newsblur-password <password>  
**Default:** n/a  
**Example:** newsblur-password "here_goesAquote:\""  

This variable sets your NewsBlur password for NewsBlur support. Double quotes
and backslashes within it should be escaped.  

* * *

**Syntax:** newsblur-passwordeval <command>  
**Default:** n/a  
**Example:** newsblur-passwordeval "gpg --decrypt ~/.newsboat/newsblur-
password.gpg"  

A more secure alternative to the above, is providing your password from an
external command that is evaluated during login. This can be used to read your
password from a gpg encrypted file or your system keyring.  

* * *

**Syntax:** newsblur-passwordfile <path>  
**Default:** n/a  
**Example:** newsblur-passwordfile "~/.newsboat/newsblur-pw.txt"  

Another alternative, by storing your plaintext password elsewhere in your
system.  

* * *

**Syntax:** newsblur-url <url>  
**Default:** "https://newsblur.com"  
**Example:** newsblur-url "https://localhost"  

Configures the URL where the NewsBlur instance resides.  

* * *

**Syntax:** notify-always [yes/no]  
**Default:** no  
**Example:** notify-always yes  

If set to `no`, notifications will only be made when there are new feeds or
articles. If set to `yes`, notifications will be made regardless.  

* * *

**Syntax:** notify-beep [yes/no]  
**Default:** no  
**Example:** notify-beep yes  

If set to `yes`, then the speaker will beep on new articles.  

* * *

**Syntax:** notify-format <string>  
**Default:** "Newsboat: finished reload, %f unread feeds (%n unread articles
total)" (localized)  
**Example:** notify-format "%d new articles (%n unread articles, %f unread
feeds)"  

Format string that is used for formatting notifications.  

* * *

**Syntax:** notify-program <command>  
**Default:** n/a  
**Example:** notify-program "~/bin/my-notifier"  

If set, then the configured program will be executed if new articles arrived
(through a reload) or if `notify-always` is `yes`. The first parameter of the
called program contains the notification message. In order to pass other hard-
coded arguments to the program, write an appropriate wrapper shell script and
use it as <command> instead.  

* * *

**Syntax:** notify-screen [yes/no]  
**Default:** no  
**Example:** notify-screen yes  

If set to `yes`, then a "privacy message" will be sent to the terminal,
containing a notification message about new articles. This is especially
useful if you use terminal emulations such as GNU screen which implement
privacy messages.  

* * *

**Syntax:** notify-xterm [yes/no]  
**Default:** no  
**Example:** notify-xterm yes  

If set to `yes`, then the xterm window title will be set to a notification
message about new articles.  

* * *

**Syntax:** ocnews-flag-star <character>  
**Default:** n/a  
**Example:** ocnews-flag-star "s"  

If set and ownCloud News support is used, then all articles that are flagged
with the specified flag are being "starred" in ownCloud News.  

* * *

**Syntax:** ocnews-login <username>  
**Default:** n/a  
**Example:** ocnews-login "user"  

Sets the username to use with the ownCloud instance.  

* * *

**Syntax:** ocnews-password <password>  
**Default:** n/a  
**Example:** ocnews-password "here_goesAquote:\""  

Configures the password to use with the ownCloud instance. Double quotes and
backslashes within it should be escaped.  

* * *

**Syntax:** ocnews-passwordeval <command>  
**Default:** n/a  
**Example:** ocnews-passwordeval "gpg --decrypt ~/.newsboat/ocnews-
password.gpg"  

A more secure alternative to the above, is providing your password from an
external command that is evaluated during login. This can be used to read your
password from a gpg encrypted file or your system keyring.  

* * *

**Syntax:** ocnews-passwordfile <path>  
**Default:** n/a  
**Example:** ocnews-passwordfile "~/.newsboat/ocnews-pw.txt"  

Another alternative, by storing your plaintext password elsewhere in your
system.  

* * *

**Syntax:** ocnews-url <url>  
**Default:** n/a  
**Example:** ocnews-url "https://localhost/owncloud"  

Configures the URL where the ownCloud instance resides.  

* * *

**Syntax:** oldreader-flag-share <flag>  
**Default:** n/a  
**Example:** oldreader-flag-share "a"  

If set and The Old Reader support is used, then all articles that are flagged
with the specified flag are being "shared" in The Old Reader so that people
that follow you can see it.  

* * *

**Syntax:** oldreader-flag-star <flag>  
**Default:** n/a  
**Example:** oldreader-flag-star "b"  

If set and The Old Reader support is used, then all articles that are flagged
with the specified flag are being "starred" in The Old Reader and appear in
the list of "Starred items".  

* * *

**Syntax:** oldreader-login <login>  
**Default:** n/a  
**Example:** oldreader-login "your-login"  

This variable sets your The Old Reader login for The Older Reader support.  

* * *

**Syntax:** oldreader-min-items <number>  
**Default:** 20  
**Example:** oldreader-min-items 100  

This variable sets the number of articles that are loaded from The Old Reader
per feed.  

* * *

**Syntax:** oldreader-password <password>  
**Default:** n/a  
**Example:** oldreader-password "here_goesAquote:\""  

This variable sets your The Old Reader password for The Old Reader support.
Double quotes and backslashes within it should be escaped.  

* * *

**Syntax:** oldreader-passwordeval <command>  
**Default:** n/a  
**Example:** oldreader-passwordeval "gpg --decrypt ~/.newsboat/oldreader-
password.gpg"  

A more secure alternative to the above, is providing your password from an
external command that is evaluated during login. This can be used to read your
password from a gpg encrypted file or your system keyring.  

* * *

**Syntax:** oldreader-passwordfile <path>  
**Default:** n/a  
**Example:** oldreader-passwordfile "~/.newsboat/oldreader-pw.txt"  

Another alternative, by storing your plaintext password elsewhere in your
system.  

* * *

**Syntax:** oldreader-show-special-feeds [yes/no]  
**Default:** yes  
**Example:** oldreader-show-special-feeds "no"  

If set and The Old reader support is used, then "special feeds" like "People
you follow" (articles shared by people you follow), "Starred items" (your
starred articles) and "Shared items" (your shared articles) appear in your
subscription list.  

* * *

**Syntax:** openbrowser-and-mark-jumps-to-next-unread [yes/no]  
**Default:** no  
**Example:** openbrowser-and-mark-jumps-to-next-unread yes  

If set to `yes`, jump to the next unread item when an item is opened in the
browser and marked as read.  

* * *

**Syntax:** opml-url <url> …​  
**Default:** n/a  
**Example:** opml-url "https://host.domain.tld/blogroll.opml"
"https://example.com/anotheropmlfile.opml"  

If the OPML online subscription mode is enabled, then the list of feeds will
be taken from the OPML file found on this location. Optionally, you can
specify more than one URL. All the listed OPML URLs will then be taken into
account when loading the feed list.  

* * *

**Syntax:** pager [<command>/internal]  
**Default:** internal  
**Example:** pager "less %f"  

If set to `internal`, then the internal pager will be used. Otherwise, the
article to be displayed will be rendered to be a temporary file and then
displayed with the configured pager. If the command is set to an empty string,
the content of the `PAGER` environment variable will be used. If the command
contains a placeholder `%f`, it will be replaced with the temporary filename.  

* * *

**Syntax:** podcast-auto-enqueue [yes/no]  
**Default:** no  
**Example:** podcast-auto-enqueue yes  

If set to `yes`, then all podcast URLs that are found in articles are added to
the podcast download queue. See the respective section in the documentation
for more information on podcast support in Newsboat.  

* * *

**Syntax:** prepopulate-query-feeds [yes/no]  
**Default:** no  
**Example:** prepopulate-query-feeds yes  

If set to `yes`, then all query feeds are prepopulated with articles on
startup.  

* * *

**Syntax:** proxy <server:port>  
**Default:** n/a  
**Example:** proxy localhost:3128  

Set the proxy to use for downloading RSS feeds. (Don't forget to actually
enable the proxy with `use-proxy yes`.) Note that the `NO_PROXY` environment
variable can disable the proxy for certain sites.  

* * *

**Syntax:** proxy-auth <auth>  
**Default:** n/a  
**Example:** proxy-auth user:password  

Set the proxy authentication string.  

* * *

**Syntax:** proxy-auth-method <method>  
**Default:** any  
**Example:** proxy-auth-method ntlm  

Set proxy authentication method. Allowed values: `any`, `basic`, `digest`,
`digest_ie` (only available with libcurl 7.19.3 and newer), `gssnegotiate`,
`ntlm` and `anysafe`.  

* * *

**Syntax:** proxy-type <type>  
**Default:** http  
**Example:** proxy-type socks5  

Set proxy type. Allowed values: `http`, `socks4`, `socks4a`, `socks5` and
`socks5h`.  

* * *

**Syntax:** refresh-on-startup [yes/no]  
**Default:** no  
**Example:** refresh-on-startup yes  

If set to `yes`, then all feeds will be reloaded when Newsboat starts up. This
is equivalent to the `-r` commandline option. See also `auto-reload` to
additionally reload the feeds continuously.  

* * *

**Syntax:** reload-only-visible-feeds [yes/no]  
**Default:** no  
**Example:** reload-only-visible-feeds yes  

If set to `yes`, then manually reloading all feeds will only reload the
currently visible feeds, e.g. if a filter or a tag is set.  

* * *

**Syntax:** reload-threads <number>  
**Default:** 1  
**Example:** reload-threads 3  

The number of parallel reload threads that shall be started when all feeds are
reloaded.  

* * *

**Syntax:** reload-time <number>  
**Default:** 60  
**Example:** reload-time 120  

The number of minutes between automatic reloads.  

* * *

**Syntax:** reset-unread-on-update <url> [<url>…​]  
**Default:** n/a  
**Example:** reset-unread-on-update "https://blog.fefe.de/rss.xml?html"  

Specifies one or more feed URLs for whose articles the unread flag will be
reset if an article has been updated, i.e. its content has been changed. This
is especially useful for RSS feeds where single articles are updated after
publication, and you want to be notified of the updates. This option can be
specified multiple times.  

* * *

**Syntax:** restrict-filename [yes/no]  
**Default:** yes  
**Example:** restrict-filename no  

If set to `no`, Newsboat will not limit saved article filenames to ASCII
characters.  

* * *

**Syntax:** run-on-startup <list of operations>  
**Default:** n/a  
**Example:** run-on-startup next-unread; open; random-unread; open  

Specifies one or more Newsboat operations, separated by semicolons, which are
executed on Newsboat startup.  

* * *

**Syntax:** save-path <path-to-directory>  
**Default:** ~/  
**Example:** save-path "~/Saved Articles"  

The default path where articles shall be saved to. If an invalid path is
specified, the current directory is used.  

* * *

**Syntax:** scrolloff <number>  
**Default:** 0  
**Example:** scrolloff 5  

Keep the configured number of lines above and below the selected item in
lists. Configure a high number to keep the selected item in the center of the
screen.  

* * *

**Syntax:** search-highlight-colors <fgcolor> <bgcolor> [<attribute> …​]  
**Default:** black yellow bold  
**Example:** search-highlight-colors white black bold  

This configuration command specifies the highlighting colors when searching
for text from the article view.  

* * *

**Syntax:** searchresult-title-format <format>  
**Default:** "%N %V - Search results for '%s' (%u unread, %t total)%?F?
matching filter '%F'&?" (localized)  
**Example:** searchresult-title-format "Search result"  

Format of the title in search result. See "Format Strings" section of Newsboat
manual for details on available formats.  

* * *

**Syntax:** selectfilter-title-format <format>  
**Default:** "%N %V - Select Filter" (localized)  
**Example:** selectfilter-title-format "Select Filter"  

Format of the title in filter selection dialog. See "Format Strings" section
of Newsboat manual for details on available formats.  

* * *

**Syntax:** selecttag-format <format>  
**Default:** "%4i %T (%u)"  
**Example:** selecttag-format "[%2i] %T (%n unread articles in %f feeds, %u
feeds total)"  

Format of the lines in "Select tag" dialog. See the respective section in the
documentation for more information on format strings.  

* * *

**Syntax:** selecttag-title-format <format>  
**Default:** "%N %V - Select Tag" (localized)  
**Example:** selecttag-title-format "Select Tag"  

Format of the title in tag selection dialog. See "Format Strings" section of
Newsboat manual for details on available formats.  

* * *

**Syntax:** show-keymap-hint [yes/no]  
**Default:** yes  
**Example:** show-keymap-hint no  

If set to `no`, then the keymap hints will not be displayed. (The keymap hints
are usually at the bottom of the screen, but see `swap-title-and-hints`
setting.)  

* * *

**Syntax:** show-read-articles [yes/no]  
**Default:** yes  
**Example:** show-read-articles no  

If set to `yes`, then all articles of a feed are listed in the article list.
If set to `no`, then only unread articles are listed.  

* * *

**Syntax:** show-read-feeds [yes/no]  
**Default:** yes  
**Example:** show-read-feeds no  

If set to `yes`, then all feeds, including those without unread articles, are
listed. If set to `no`, then only feeds with one or more unread articles are
list.  

* * *

**Syntax:** show-title-bar [yes/no]  
**Default:** yes  
**Example:** show-title-bar no  

If set to `no`, then the title bar will not be displayed. (The title bar is
usually at the top of the screen, but see `swap-title-and-hints` setting.)  

* * *

**Syntax:** ssl-verifyhost [yes/no]  
**Default:** yes  
**Example:** ssl-verifyhost no  

If set to `no`, skip verification of the certificate's name against host.  

* * *

**Syntax:** ssl-verifypeer [yes/no]  
**Default:** yes  
**Example:** ssl-verifypeer no  

If set to `no`, skip verification of the peer's SSL certificate.  

* * *

**Syntax:** suppress-first-reload [yes/no]  
**Default:** no  
**Example:** suppress-first-reload yes  

If set to `yes`, then the first automatic reload will be suppressed if `auto-
reload` is set to `yes`.  

* * *

**Syntax:** swap-title-and-hints [yes/no]  
**Default:** no  
**Example:** swap-title-and-hints yes  

If set to `yes`, then the title (which is usually at the top of the screen)
and the keymap hints (usually at the bottom) will exchange places. These bars
can be hidden entirely, via the `show-keymap-hints` and `show-title-bar`
settings.  

* * *

**Syntax:** text-width <number>  
**Default:** 0  
**Example:** text-width 72  

If set to a number greater than 0, all HTML will be rendered to this maximum
line length or the terminal width (whichever is smaller). If set to 0, the
terminal width will always be used in the article view, while `pipe-to`,
`save`, and `save-all` will wrap at 80 columns instead. Does not apply when
using external renderer or viewing the source. Also note that "Link" header
and "Links" section won't be affected by it—they contain URLs which are better
not wrapped.  

* * *

**Syntax:** toggleitemread-jumps-to-next-unread [yes/no]  
**Default:** no  
**Example:** toggleitemread-jumps-to-next-unread yes  

If set to `yes`, jump to the next unread item when an item's read status is
toggled in the article list.  

* * *

**Syntax:** ttrss-flag-publish <character>  
**Default:** n/a  
**Example:** ttrss-flag-publish "b"  

If set and Tiny Tiny RSS support is used, then all articles that are flagged
with the specified flag are being marked as "published" in Tiny Tiny RSS.  

* * *

**Syntax:** ttrss-flag-star <character>  
**Default:** n/a  
**Example:** ttrss-flag-star "a"  

If set and Tiny Tiny RSS support is used, then all articles that are flagged
with the specified flag are being "starred" in Tiny Tiny RSS.  

* * *

**Syntax:** ttrss-login <username>  
**Default:** n/a  
**Example:** ttrss-login "admin"  

Sets the username for use with Tiny Tiny RSS.  

* * *

**Syntax:** ttrss-mode [multi/single]  
**Default:** multi  
**Example:** ttrss-mode "single"  

Configures the mode in which Tiny Tiny RSS is used. In single-user mode, login
and password are used for HTTP authentication, while in multi-user mode, they
are used for authenticating with Tiny Tiny RSS.  

* * *

**Syntax:** ttrss-password <password>  
**Default:** n/a  
**Example:** ttrss-password "here_goesAquote:\""  

Configures the password for use with Tiny Tiny RSS. Double quotes and
backslashes within it should be escaped.  

* * *

**Syntax:** ttrss-passwordeval <command>  
**Default:** n/a  
**Example:** ttrss-passwordeval "gpg --decrypt ~/.newsboat/ttrss-password.gpg"  

A more secure alternative to the above, is providing your password from an
external command that is evaluated during login. This can be used to read your
password from a gpg encrypted file or your system keyring.  

* * *

**Syntax:** ttrss-passwordfile <path>  
**Default:** n/a  
**Example:** ttrss-passwordfile "~/.newsboat/ttrss-pw.txt"  

Another alternative, by storing your plaintext password elsewhere in your
system.  

* * *

**Syntax:** ttrss-url <url>  
**Default:** n/a  
**Example:** ttrss-url "https://example.com/ttrss/"  

Configures the URL where the Tiny Tiny RSS installation you want to use
resides.  

* * *

**Syntax:** unbind-key <key> [<dialog>]  
**Default:** n/a  
**Example:** unbind-key R  

Unbind key <key>. This means that no operation is called when <key> is
pressed. `unbind-key` uses the syntax for special keys as specified in the
**Key** section of Old Style Key Bindings. If you provide "-a" as <key>, all
currently bound keys will become unbound. Optionally, you can specify a dialog
(for a list of available dialogs, see `bind-key` above). If you specify one,
the key binding will only be unbound for the specified dialog.  

* * *

**Syntax:** urls-source <source>  
**Default:** "local"  
**Example:** urls-source "oldreader"  

This configuration command sets the source where URLs shall be retrieved from.
By default, this is the _urls_ file. Alternatively, you can set it to `opml`,
which enables Newsboat's OPML online subscription mode, to `ttrss` which
enables Newsboat's Tiny Tiny RSS support, to `oldreader`, which enables
Newsboat's The Old Reader support, to `newsblur`, which enables NewsBlur
support, to `feedbin` for Feedbin support, to `feedhq` for FeedHQ support, to
`freshrss` for FreshRSS support, to `ocnews` for ownCloud News support, to
`inoreader` for Inoreader support, or to `miniflux` for Miniflux support.
Query feed specifications will be read from the local urls file regardless of
this setting.  

* * *

**Syntax:** urlview-title-format <format>  
**Default:** "%N %V - URLs" (localized)  
**Example:** urlview-title-format "URLs"  

Format of the title in URL view. See "Format Strings" section of Newsboat
manual for details on available formats.  

* * *

**Syntax:** use-proxy [yes/no]  
**Default:** no  
**Example:** use-proxy yes  

If set to `yes`, then the configured proxy will be used for downloading the
RSS feeds.  

* * *

**Syntax:** user-agent <string>  
**Default:** n/a  
**Example:** user-agent "Lynx/2.8.5rel.1 libwww-FM/2.14"  

If set to a non-zero-length string, this value will be used as HTTP User-Agent
header for all HTTP requests.  

* * *

**Syntax:** wrap-scroll [yes/no]  
**Default:** no  
**Example:** wrap-scroll yes  

If set to `yes`, moving down while on the last item in a list will wrap around
to the top and vice versa.  

## Appendix B: Newsboat Operations

* * *

**Operation:** open  
**Default key:** `ENTER`  

Open the currently selected feed or article.  

* * *

**Operation:** quit  
**Default key:** `Q`  

Quit the program or return to the previous dialog (depending on the context).  

* * *

**Operation:** hard-quit  
**Default key:** `Shift`+`Q`  

Quit the program without confirmation.  

* * *

**Operation:** reload  
**Default key:** `R`  

Reload the currently selected feed.  

* * *

**Operation:** reload-all  
**Default key:** `Shift`+`R`  

Reload all feeds.  

* * *

**Operation:** mark-feed-read  
**Default key:** `Shift`+`A`  

Mark all articles in the currently selected feed read.  

* * *

**Operation:** mark-all-feeds-read  
**Default key:** `Shift`+`C`  

Mark articles in all feeds read.  

* * *

**Operation:** mark-all-above-as-read  
**Default key:** n/a  

Mark all above as read.  

* * *

**Operation:** save  
**Default key:** `S`  

Export the currently selected article to a plain text file, word-wrapped
according to the `text-width` setting.  

* * *

**Operation:** save-all  
**Default key:** n/a  

Export all articles from the currently selected feed to plain text files,
word-wrapped according to the `text-width` setting.  

* * *

**Operation:** next-unread  
**Default key:** `N`  

Jump to the next unread article.  

* * *

**Operation:** prev-unread  
**Default key:** `P`  

Jump to the previous unread article.  

* * *

**Operation:** next  
**Default key:** `Shift`+`J`  

Jump to next list entry.  

* * *

**Operation:** prev  
**Default key:** `Shift`+`K`  

Jump to previous list entry.  

* * *

**Operation:** random-unread  
**Default key:** `Ctrl`+`K`  

Jump to a random unread article.  

* * *

**Operation:** open-in-browser  
**Default key:** `O`  

Use browser to open the URL associated with the current article, feed, or
entry in the URL view.  

* * *

**Operation:** open-in-browser-noninteractively  
**Default key:** n/a  

Use browser to open the URL associated with the current article, feed, or
entry in the URL view. This operation works similar to `open-in-browser`, but
the output of the browser (stdout and stderr) is not shown, and the browser
doesn't receive keyboard input. You would probably add `&` at the end of the
`browser` command to put it into background, too.  

* * *

**Operation:** open-in-browser-and-mark-read  
**Default key:** `Shift`+`O`  

Use browser to open the URL associated with the current article, or entry in
the URL view. When used in the article list, it will also mark the article as
read.  

* * *

**Operation:** open-all-unread-in-browser  
**Default key:** n/a  

Open all the unread URLs in the current feed.  

* * *

**Operation:** open-all-unread-in-browser-and-mark-read  
**Default key:** n/a  

Open all the unread URLs in the current feed and mark them as read.  

* * *

**Operation:** help  
**Default key:** `?`  

Run the help screen.  

* * *

**Operation:** toggle-source-view  
**Default key:** `Ctrl`+`U`  

Toggle between the HTML view and the source view in the article view.  

* * *

**Operation:** toggle-article-read  
**Default key:** `Shift`+`N`  

Toggle the read flag for the currently selected article, and clear the delete
flag if set.  

* * *

**Operation:** toggle-show-read-feeds  
**Default key:** `L`  

Toggle whether read feeds should be shown in the feed list.  

* * *

**Operation:** show-urls  
**Default key:** `U`  

Show all URLs in the article in a list (similar to urlview).  

* * *

**Operation:** clear-tag  
**Default key:** `Ctrl`+`T`  

Clear current tag.  

* * *

**Operation:** set-tag  
**Default key:** `T`  

Select tag.  

* * *

**Operation:** open-search  
**Default key:** `/`  

Open the search dialog. When a search is done in the article list, then the
search operation only applies to the articles of the current feed, otherwise
to all articles.  

* * *

**Operation:** goto-url  
**Default key:** `#`  

Open the URL dialog and then open a specified URL in the browser.  

* * *

**Operation:** one  
**Default key:** `1`  

Open URL 1 in the browser.  

* * *

**Operation:** two  
**Default key:** `2`  

Open URL 2 in the browser.  

* * *

**Operation:** three  
**Default key:** `3`  

Open URL 3 in the browser.  

* * *

**Operation:** four  
**Default key:** `4`  

Open URL 4 in the browser.  

* * *

**Operation:** five  
**Default key:** `5`  

Open URL 5 in the browser.  

* * *

**Operation:** six  
**Default key:** `6`  

Open URL 6 in the browser.  

* * *

**Operation:** seven  
**Default key:** `7`  

Open URL 7 in the browser.  

* * *

**Operation:** eight  
**Default key:** `8`  

Open URL 8 in the browser.  

* * *

**Operation:** nine  
**Default key:** `9`  

Open URL 9 in the browser.  

* * *

**Operation:** zero  
**Default key:** `0`  

Open URL 10 in the browser.  

* * *

**Operation:** cmd-one  
**Default key:** `1`  

Start cmdline with 1.  

* * *

**Operation:** cmd-two  
**Default key:** `2`  

Start cmdline with 2.  

* * *

**Operation:** cmd-three  
**Default key:** `3`  

Start cmdline with 3.  

* * *

**Operation:** cmd-four  
**Default key:** `4`  

Start cmdline with 4.  

* * *

**Operation:** cmd-five  
**Default key:** `5`  

Start cmdline with 5.  

* * *

**Operation:** cmd-six  
**Default key:** `6`  

Start cmdline with 6.  

* * *

**Operation:** cmd-seven  
**Default key:** `7`  

Start cmdline with 7.  

* * *

**Operation:** cmd-eight  
**Default key:** `8`  

Start cmdline with 8.  

* * *

**Operation:** cmd-nine  
**Default key:** `9`  

Start cmdline with 9.  

* * *

**Operation:** enqueue  
**Default key:** `E`  

Add the podcast download URL of the current article (if any is found) to the
podcast download queue (see the respective section in the documentation for
more information on podcast support).  

* * *

**Operation:** edit-urls  
**Default key:** `Shift`+`E`  

Edit the list of subscribed URLs. Newsboat will start the editor configured
through the `VISUAL` environment variable (if unset, `EDITOR` is used;
fallback: `vi`). When editing is finished, Newsboat will reload the URLs file.  

* * *

**Operation:** reload-urls  
**Default key:** `Ctrl`+`R`  

Reload the URLs configuration file.  

* * *

**Operation:** redraw  
**Default key:** `Ctrl`+`L`  

Redraw the screen.  

* * *

**Operation:** cmdline  
**Default key:** `:`  

Open the command line.  

* * *

**Operation:** set-filter  
**Default key:** `Shift`+`F`  

Set a filter.  

* * *

**Operation:** select-filter  
**Default key:** `F`  

Select a predefined filter.  

* * *

**Operation:** clear-filter  
**Default key:** `Ctrl`+`F`  

Clear currently set filter.  

* * *

**Operation:** bookmark  
**Default key:** `Ctrl`+`B`  

Bookmark currently selected article or URL.  

* * *

**Operation:** edit-flags  
**Default key:** `Ctrl`+`E`  

Edit the flags of the currently selected article.  

* * *

**Operation:** next-unread-feed  
**Default key:** `Ctrl`+`N`  

Go to the next feed with unread articles. This only works from the article
list.  

* * *

**Operation:** prev-unread-feed  
**Default key:** `Ctrl`+`P`  

Go to the previous feed with unread articles. This only works from the article
list.  

* * *

**Operation:** next-feed  
**Default key:** `J`  

Go to the next feed. This only works from the article list.  

* * *

**Operation:** prev-feed  
**Default key:** `K`  

Go to the previous feed. This only works from the article list.  

* * *

**Operation:** delete-article  
**Default key:** `Shift`+`D`  

Delete the currently selected article.  

* * *

**Operation:** delete-all-articles  
**Default key:** `Ctrl`+`D`  

Delete all articles in the articlelist. Note that the articlelist might
contain a subset of feed's articles (because of filters or `show-read-articles
no`), or it might contain a mix of articles from different feeds (if you're
viewing a query feed) — in either case, `delete-all-articles` affects just
those articles, not all articles of the respective feed(s).  

* * *

**Operation:** purge-deleted  
**Default key:** `$`  

Purge all articles that are marked as deleted from the article list.  

* * *

**Operation:** view-dialogs  
**Default key:** `V`  

View list of open dialogs.  

* * *

**Operation:** close-dialog  
**Default key:** `Ctrl`+`X`  

Close currently selected dialog.  

* * *

**Operation:** next-dialog  
**Default key:** `Ctrl`+`V`  

Go to next dialog.  

* * *

**Operation:** prev-dialog  
**Default key:** `Ctrl`+`G`  

Go to previous dialog.  

* * *

**Operation:** pipe-to  
**Default key:** `|`  

Pipe article to command. The text will be word-wrapped according to the `text-
width` setting.  

* * *

**Operation:** sort  
**Default key:** `G`  

Sort feeds/articles by interactively choosing the sort method.  

* * *

**Operation:** rev-sort  
**Default key:** `Shift`+`G`  

Sort feeds/articles by interactively choosing the sort method (reversed).  

* * *

**Operation:** up  
**Default key:** `UP`  

Go up one item in the list.  

* * *

**Operation:** down  
**Default key:** `DOWN`  

Go down one item in the list.  

* * *

**Operation:** pageup  
**Default key:** `PPAGE`  

Go up one page in the list.  

* * *

**Operation:** pagedown  
**Default key:** `NPAGE`  

Go down one page in the list.  

* * *

**Operation:** halfpageup  
**Default key:** n/a  

Go up half a page.  

* * *

**Operation:** halfpagedown  
**Default key:** n/a  

Go down half a page.  

* * *

**Operation:** home  
**Default key:** `HOME`  

Go to the first item in the list.  

* * *

**Operation:** end  
**Default key:** `END`  

Go to the last item in the list.  

* * *

**Operation:** macro-prefix  
**Default key:** `,`  

Initiate macro execution. The next key press selects the actual macro and runs
it.  

* * *

**Operation:** switch-focus  
**Default key:** `TAB`  

Switch focus between widgets. This is currently only applicable to the
`filebrowser` and `dirbrowser` contexts.  

* * *

**Operation:** goto-title  
**Default key:** n/a  

Go to item whose title contains the specified string (case-insensitive).  

* * *

**Operation:** prevsearchresults  
**Default key:** `Z`  

Return to previous search results (if any). This only works from
`searchresultslist`.  

* * *

**Operation:** article-feed  
**Default key:** n/a  

Go to the feed of the currently selected article.  

## Appendix C: Podboat Configuration Commands

* * *

**Syntax:** delete-played-files [yes/no]  
**Default:** no  
**Example:** delete-played-files yes  

If set to `yes`, Podboat will delete files when their corresponding queue
entry is removed (this includes "finished" and "deleted" entries as well).  

* * *

**Syntax:** download-path <path>  
**Default:** ~/  
**Example:** download-path "~/Downloads/%h/%n"  

Specifies the directory where Podboat shall download the files to. Optionally,
placeholders can be used to place downloads in a directory structure. See
"Format Strings" section of Newsboat manual for details on available formats.
This setting is applied at enqueueing time; changing it won't affect download
paths of the podcasts that were already added to the queue.  

* * *

**Syntax:** download-filename-format <string>  
**Default:** "%?u?%u&%Y-%b-%d-%H%M%S.unknown?"  
**Example:** download-filename-format "%F-%t.%e"  

Specifies how Podboat would name the files it downloads (see also `download-
path`). See "Format Strings" section of Newsboat manual for details on
available formats.  

* * *

**Syntax:** max-downloads <number>  
**Default:** 1  
**Example:** max-downloads 3  

Specifies the maximum number of parallel downloads when automatic download is
enabled.  

* * *

**Syntax:** player <player command>  
**Default:** n/a  
**Example:** player "mp3blaster"  

Specifies the player that shall be used for playback of downloaded files.  

* * *

**Syntax:** podlist-format <format>  
**Default:** "%4i [%6dMB/%6tMB] [%5p %%] [%12K] %-20S %u -> %F"  
**Example:** podlist-format "%i %u %-20S %F"  

This variable defines the format of entries in Podboat's download list. See
the respective section in the documentation for more information on format
strings.  

## Appendix D: Podboat Operations

Table 18. Available Operations in Podboat Operation | Default key | Description  
---|---|---  
quit | `Q` | Quit the program.  
hard-quit | `Shift`+`Q` | Quit the program without confirmation.  
help | `?` | Show the help screen.  
pb-download | `D` | Download the currently selected URL.  
pb-cancel | `C` | Cancel the currently selected download.  
pb-play | `P` | Start player with currently selected download.  
pb-mark-as-finished | `M` | Mark currently selected entry as finished.  
pb-delete | `Shift`+`D` | Delete the currently selected URL from the queue.  
pb-purge | `Shift`+`P` | Remove all finished and deleted downloads from the queue and load URLs that were newly added to the queue.  
pb-toggle-download-all | `A` | Toggle the "automatic download" feature where all queued URLs are downloaded one after the other. The `max-downloads` configuration option controls how many downloads are done in parallel.  
pb-increase-max-dls | `+` | Increase the `max-downloads` option by 1.  
pb-decrease-max-dls | `-` | Decrease the `max-downloads` option by 1. If the option is already 1, no further decrease is possible.  
  
## Appendix E: License

MIT License

Copyright 2006-2015 Andreas Krennmair
<[ak@newsbeuter.org](mailto:ak@newsbeuter.org)>  
Copyright 2015-2025 Alexander Batischev
<[eual.jp@gmail.com](mailto:eual.jp@gmail.com)>  
Copyright 2006-2017 Newsbeuter contributors  
Copyright 2017-2025 Newsboat contributors

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

