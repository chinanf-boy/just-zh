![crates.io version](https://img.shields.io/crates/v/just.svg) ![build
status](https://travis-ci.org/casey/just.svg?branch=master) ![chat on
gitter](https://badges.gitter.im/just-because/Lobby.svg) ![say
thanks](https://img.shields.io/badge/Say%20Thanks-!-1EAEDB.svg)

`just` is a handy way to save and run project-specific commands.

(非官方中文文档,[这里](https://github.com/chinanf-boy/just-zh),快看过来\!)

Commands are stored in a file called `justfile` with syntax inspired by
`make`:

```make
build:
    cc *.c -o main

# test everything
test-all: build
    ./test --all

# run a specific test
test TEST: build
    ./test --test {{TEST}}
```

You can then run them with `just COMMAND`:

```sh
$ just test-all
cc *.c -o main
./test --all
Yay, all your tests passed!
```

`just` produces detailed error messages and avoids `make`’s
idiosyncrasies, so debugging a justfile is easier and less surprising
than debugging a makefile.

If you need help with `just` please feel free to open an issue or let me
know on [gitter](https://gitter.im/just-because/Lobby). Feature requests
and bug reports are always welcome\!

**Manual**

# Installation

`just` should run on any system with a reasonable `sh`, including Linux,
MacOS, and the BSDs.

On Windows, `just` works with the `sh` provided by [Git for
Windows](https://git-scm.com), [GitHub
Desktop](https://desktop.github.com), and
[Cygwin](http://www.cygwin.com).

## Pre-built Binaries

Pre-built binaries for Linux, MacOS, and Windows can be found on [the
releases page](https://github.com/casey/just/releases).

You can use the following command to download the latest binary for
MacOS or Windows, just replace `DESTINATION_DIRECTORY` with the
directory where you’d like to put `just`:

```sh
curl -LSfs https://japaric.github.io/trust/install.sh | \
  sh -s -- --git casey/just --to DESTINATION_DIRECTORY
```

On Linux, use:

```sh
curl -LSfs https://japaric.github.io/trust/install.sh | \
  sh -s -- --git casey/just --target x86_64-unknown-linux-musl --to DESTINATION_DIRECTORY
```

## Homebrew

On MacOS, `just` can be installed using the [Homebrew package
manager](https://brew.sh). Install Homebrew using the instructions
[here](https://brew.sh), then run:

`brew install just`

## Scoop

On Windows, `just` can be installed using the [Scoop package
manager](https://scoop.sh). Install Scoop using the instructions
[here](https://scoop.sh/), then run:

```powershell
scoop install just
```

## Arch Linux

On Arch Linux, `just` is packaged as
[just](https://aur.archlinux.org/packages/just/) in AUR, the [Arch User
Repository](https://aur.archlinux.org). Several tools are available to
install packages from AUR, including [yay](https://github.com/Jguer/yay)
and [yaourt](https://github.com/archlinuxfr/yaourt).

## Void Linux

On Void Linux, `just` can be installed with:

```sh
sudo xbps-install -S just
```

## Nix

On NixOS, Linux, and MacOS, `just` can be installed using the [Nix
package manager](https://nixos.org/nix/). Install
[Nix](https://nixos.org/nix/download.html) or
[NixOS](https://nixos.org/nixos/download.html), then run:

```sh
nix-env -i just
```

## Cargo

On Windows, Linux, and macOS, `just` can be installed using Cargo, the
[rust language package manager](https://www.rust-lang.org). Install
Cargo using the instructions [here](https://www.rustup.rs), then run:

`cargo install just`

(You might also need to add `~/.cargo/bin` to your shell’s `$PATH`. If
you can’t run just after installing it, put `export
PATH="$HOME/.cargo/bin:$PATH"` in your shell’s configuration file.)

# Quick Start

See [Installation](#_installation) for how to install `just` on your
computer. Try running `just --version` to make sure that it’s installed
correctly.

Once `just` is installed and working, create a file named `justfile` in
the root of your project with the following contents:

```make
recipe-name:
    echo 'This is a recipe!'

# this is a comment
another-recipe:
    @echo 'This is another recipe.'
```

When you invoke `just` it looks for file `justfile` in the current
directory and upwards, so you can invoke it from any subdirectory of
your project.

The search for a `justfile` is case insensitive, so any case, like
`Justfile`, `JUSTFILE`, or `JuStFiLe`, will work.

Running `just` with no arguments runs the first recipe in the
`justfile`:

```sh
$ just
echo 'This is a recipe!'
This is a recipe!
```

One or more arguments specify the recipe(s) to run:

```sh
$ just another-recipe
This is another recipe.
```

`just` prints each command to standard error before running it, which is
why `echo 'This is a recipe!'` was printed. This is suppressed for lines
starting with `@`, which is why `echo 'Another recipe.'` was not
printed.

Recipes stop running if a command fails. Here `cargo publish` will only
run if `cargo test` succeeds:

```make
publish:
    cargo test
    # tests passed, time to publish!
    cargo publish
```

Recipes can depend on other recipes. Here the `test` recipe depends on
the `build` recipe, so `build` will run before `test`:

```make
build:
    cc main.c foo.c bar.c -o main

test: build
    ./test

sloc:
    @echo "`wc -l *.c` lines of code"
```

```sh
$ just test
cc main.c foo.c bar.c -o main
./test
testing... all tests passed!
```

Recipes without dependencies will run in the order they’re given on the
command line:

```sh
$ just build sloc
cc main.c foo.c bar.c -o main
1337 lines of code
```

Dependencies will always run first, even if they are passed after a
recipe that depends on them:

```sh
$ just test build
cc main.c foo.c bar.c -o main
./test
testing... all tests passed!
```

# Features

## Listing Available Recipes

Recipes can be listed with `just --list` :

```sh
$ just --list
Available recipes:
  build
  test
  deploy
  lint
```

`just --summary` is more concise:

```sh
$ just --summary
build test deploy lint
```

## Aliases

Aliases allow recipes to be invoked with alternative names:

```make
alias b := build

build:
  echo 'Building!'
```

```sh
$ just b
build
echo 'Building!'
Building!
```

## Documentation Comments

Comments immediately preceding a recipe will appear in `just --list`:

```make
# build stuff
build:
  ./bin/build

# test stuff
test:
  ./bin/test
```

```sh
$ just --list
Available recipes:
    build # build stuff
    test # test stuff
```

## Variables and Substitution

Variables, strings, concatenation, and substitution using `{{…​}}` are
supported:

```make
version := "0.2.7"
tardir  := "awesomesauce-" + version
tarball := tardir + ".tar.gz"

publish:
    rm -f {{tarball}}
    mkdir {{tardir}}
    cp README.md *.c {{tardir}}
    tar zcvf {{tarball}} {{tardir}}
    scp {{tarball}} me@server.com:release/
    rm -rf {{tarball}} {{tardir}}
```

### Escaping `{{`

To write a recipe containing `{{`, use `{{ "{{" }}`:

```make
braces:
    echo 'I {{ "{{" }}LOVE}} curly braces!'
```

(An unmatched `}}` is ignored, so it doesn’t need to be escaped.)

Another option is to put all the text you’d like to escape inside of an
interpolation:

```make
braces:
    echo '{{'I {{LOVE}} curly braces!'}}'
```

## Strings

Double-quoted strings support escape sequences:

```make
string-with-tab             := "\t"
string-with-newline         := "\n"
string-with-carriage-return := "\r"
string-with-double-quote    := "\""
string-with-slash           := "\\"
```

```sh
$ just --evaluate
"tring-with-carriage-return := "
string-with-double-quote    := """
string-with-newline         := "
"
string-with-slash           := "\"
string-with-tab             := "     "
```

Single-quoted strings do not recognize escape sequences and may contain
line breaks:

```make
escapes := '\t\n\r\"\\'

line-breaks := 'hello
this
is
  a
     raw
string!
'
```

```sh
$ just --evaluate
escapes := "\t\n\r\"\\"

line-breaks := "hello
this
is
  a
     raw
string!
"
```

## Functions

Just provides a few built-in functions that might be useful when writing
recipes.

### System Information

  - `arch()` – Instruction set architecture. Possible values are:
    `"aarch64"`, `"arm"`, `"asmjs"`, `"hexagon"`, `"mips"`, `"msp430"`,
    `"powerpc"`, `"powerpc64"`, `"s390x"`, `"sparc"`, `"wasm32"`,
    `"x86"`, `"x86_64"`, and `"xcore"`.

  - `os()` – Operating system. Possible values are: `"android"`,
    `"bitrig"`, `"dragonfly"`, `"emscripten"`, `"freebsd"`, `"haiku"`,
    `"ios"`, `"linux"`, `"macos"`, `"netbsd"`, `"openbsd"`, `"solaris"`,
    and `"windows"`.

  - `os_family()` – Operating system family; possible values are:
    `"unix"` and `"windows"`.

For example:

```make
system-info:
    @echo "This is an {{arch()}} machine".
```

    $ just system-info
    This is an x86_64 machine

### Environment Variables

  - `env_var(key)` – Retrieves the environment variable with name `key`,
    aborting if it is not present.

  - `env_var_or_default(key, default)` – Retrieves the environment
    variable with name `key`, returning `default` if it is not present.

### Invocation Directory

  - `invocation_directory()` - Retrieves the path of the current working
    directory, before `just` changed it (chdir’d) prior to executing
    commands.

For example, to call `rustfmt` on files just under the "current
directory" (from the user/invoker’s perspective), use the following
rule:

    rustfmt:
        find {{invocation_directory()}} -name \*.rs -exec rustfmt {} \;

Alternatively, if your command needs to be run from the current
directory, you could use (e.g.):

    build:
        cd {{invocation_directory()}}; ./some_script_that_needs_to_be_run_from_here

### Dotenv Integration

`just` will load environment variables from a file named `.env`. This
file can be located in the same directory as your justfile or in a
parent directory. These variables are environment variables, not `just`
variables, and so must be accessed using `$VARIABLE_NAME` in recipes and
backticks.

For example, if your `.env` file contains:

    # a comment, will be ignored
    DATABASE_ADDRESS=localhost:6379
    SERVER_PORT=1337

And your justfile contains:

```make
serve:
  @echo "Starting server with database $DATABASE_ADDRESS on port $SERVER_PORT..."
  ./server --database $DATABASE_ADDRESS --port $SERVER_PORT
```

`just serve` will output:

```sh
$ just serve
Starting server with database localhost:6379 on port 1337...
./server --database $DATABASE_ADDRESS --port $SERVER_PORT
```

## Command Evaluation Using Backticks

Backticks can be used to store the result of
commands:

```make
localhost := `dumpinterfaces | cut -d: -f2 | sed 's/\/.*//' | sed 's/ //g'`

serve:
    ./serve {{localhost}} 8080
```

## Setting Variables from the Command Line

Variables can be overridden from the command line.

```make
os := "linux"

test: build
    ./test --test {{os}}

build:
    ./build {{os}}
```

```sh
$ just
./build linux
./test --test linux
```

Any number of arguments of the form `NAME=VALUE` can be passed before
recipes:

```sh
$ just os=plan9
./build plan9
./test --test plan9
```

Or you can use the `--set` flag:

```sh
$ just --set os bsd
./build bsd
./test --test bsd
```

## Environment Variables

Assignments prefixed with the `export` keyword will be exported to
recipes as environment variables:

```make
export RUST_BACKTRACE := "1"

test:
    # will print a stack trace if it crashes
    cargo test
```

## Recipe Parameters

Recipes may have parameters. Here recipe `build` has a parameter called
`target`:

```make
build target:
    @echo 'Building {{target}}...'
    cd {{target}} && make
```

Other recipes may not depend on a recipe with parameters.

To pass arguments, put them after the recipe name:

```sh
$ just build my-awesome-project
Building my-awesome-project...
cd my-awesome-project && make
```

Parameters may have default values:

```make
default := 'all'

test target tests=default:
    @echo 'Testing {{target}}:{{tests}}...'
    ./test --tests {{tests}} {{target}}
```

Parameters with default values may be omitted:

```sh
$ just test server
Testing server:all...
./test --tests all server
```

Or supplied:

```sh
$ just test server unit
Testing server:unit...
./test --tests unit server
```

Default values may be arbitrary expressions, but concatenations must be
parenthesized:

```make
arch := "wasm"

test triple=(arch + "-unknown-unknown"):
  ./test {{triple}}
```

The last parameter of a recipe may be variadic, indicated with a `+`
before the argument name:

```make
backup +FILES:
  scp {{FILES}} me@server.com:
```

Variadic parameters accept one or more arguments and expand to a string
containing those arguments separated by spaces:

```sh
$ just backup FAQ.md GRAMMAR.md
scp FAQ.md GRAMMAR.md me@server.com:
FAQ.md                  100% 1831     1.8KB/s   00:00
GRAMMAR.md              100% 1666     1.6KB/s   00:00
```

A variadic parameter with a default argument will accept zero or more
arguments:

```make
commit MESSAGE +FLAGS='':
  git commit {{FLAGS}} -m "{{MESSAGE}}"
```

`{{…​}}` substitutions may need to be quoted if they contains spaces.
For example, if you have the following recipe:

```make
search QUERY:
    lynx https://www.google.com/?q={{QUERY}}
```

And you type:

```sh
$ just search "cat toupee"
```

Just will run the command `lynx https://www.google.com/?q=cat toupee`,
which will get parsed by `sh` as `lynx`,
`https://www.google.com/?q=cat`, and `toupee`, and not the intended
`lynx` and `https://www.google.com/?q=cat toupee`.

You can fix this by adding quotes:

```make
search QUERY:
    lynx 'https://www.google.com/?q={{QUERY}}'
```

## Writing Recipes in Other Languages

Recipes that start with a `#!` are executed as scripts, so you can write
recipes in other languages:

```make
polyglot: python js perl sh ruby

python:
    #!/usr/bin/env python3
    print('Hello from python!')

js:
    #!/usr/bin/env node
    console.log('Greetings from JavaScript!')

perl:
    #!/usr/bin/env perl
    print "Larry Wall says Hi!\n";

sh:
    #!/usr/bin/env sh
    hello='Yo'
    echo "$hello from a shell script!"

ruby:
    #!/usr/bin/env ruby
    puts "Hello from ruby!"
```

```sh
$ just polyglot
Hello from python!
Greetings from JavaScript!
Larry Wall says Hi!
Yo from a shell script!
Hello from ruby!
```

## Multi-line Constructs

Recipes without an initial shebang are evaluated and run line-by-line,
which means that multi-line constructs probably won’t do what you want.

For example, with the following justfile:

    conditional:
        if true; then
            echo 'True!'
        fi

The extra leading whitespace before the second line of the `conditional`
recipe will produce a parse error:

    $ just conditional
    error: Recipe line has extra leading whitespace
      |
    3 |         echo 'True!'
      |     ^^^^^^^^^^^^^^^^

To work around this, you can write conditionals on one line, escape
newlines with slashes, or add a shebang to your recipe. Some examples of
multi-line constructs are provided for reference.

### `if` statements

```make
conditional:
    if true; then echo 'True!'; fi
```

```make
conditional:
    if true; then \
        echo 'True!'; \
    fi
```

```make
conditional:
    #!/usr/bin/env sh
    if true; then
        echo 'True!'
    fi
```

### `for` loops

```make
for:
    for file in `ls .`; do echo $file; done
```

```make
for:
    for file in `ls .`; do \
        echo $file; \
    done
```

```make
for:
    #!/usr/bin/env sh
    for file in `ls .`; do
        echo $file
    done
```

### `while` loops

```make
while:
    while `server-is-dead`; do ping -c 1 server; done
```

```make
while:
    while `server-is-dead`; do \
        ping -c 1 server; \
    done
```

```make
while:
    #!/usr/bin/env sh
    while `server-is-dead`; do
        do ping -c 1 server
    done
```

## Command Line Options

`just` supports a number of useful command line options for listing,
dumping, and debugging recipes and variable:

```sh
$ just --list
Available recipes:
  js
  perl
  polyglot
  python
  ruby
$ just --show perl
perl:
    #!/usr/bin/env perl
    print "Larry Wall says Hi!\n";
$ just --show polyglot
polyglot: python js perl sh ruby
```

Run `just --help` to see all the options.

## Private Recipes

Recipes and aliases whose name starts with a `_` are omitted from `just
--list`:

```make
test: _test-helper
  ./bin/test

_test-helper:
  ./bin/super-secret-test-helper-stuff
```

```sh
$ just --list
Available recipes:
  test
```

And from `just --summary`:

```sh
$ just --summary
test
```

This is useful for helper recipes which are only meant to be used as
dependencies of other recipes.

## Quiet Recipes

A recipe name may be prefixed with '@' to invert the meaning of '@'
before each line:

```make
@quiet:
  echo hello
  echo goodbye
  @# all done!
```

Now only the lines starting with '@' will be echoed:

```sh
$ j quiet
hello
goodbye
# all done!
```

## Invoking Justfiles in Other Directories

If the first argument passed to `just` contains a `/`, then the
following occurs:

1.  The argument is split at the last `/`.

2.  The part before the last `/` is treated as a directory. Just will
    start its search for the justfile there, instead of in the current
    directory.

3.  The part after the last slash is treated as a normal argument, or
    ignored if it is empty.

This may seem a little strange, but it’s useful if you wish to run a
command in a justfile that is in a subdirectory.

For example, if you are in a directory which contains a subdirectory
named `foo`, which contains a justfile with the recipe `build`, which is
also the default recipe, the following are all equivalent:

```sh
$ (cd foo && just build)
$ just foo/build
$ just foo/
```

## Just Scripts

By adding a shebang line to the top of a justfile and making it
executable, `just` can be used as an interpreter for scripts:

```sh
$ cat > script <<EOF
#!/usr/bin/env just --justfile

foo:
  echo foo
EOF
$ chmod +x script
$ ./script foo
echo foo
foo
```

When a script with a shebang is executed, the system supplies the path
to the script as an argument to the command in the shebang. So, with a
shebang of `#!/usr/bin/env just --justfile`, the command will be
`/usr/bin/env just --justfile PATH_TO_SCRIPT`.

With the above shebang, `just` will change its working directory to the
location of the script. If you’d rather leave the working directory
unchanged, use `#!/usr/bin/env just --working-directory . --justfile`.

# Miscellanea

## Companion Tools

Tools that pair nicely with `just` include:

  - [`watchexec`](https://github.com/mattgreen/watchexec) — a simple
    tool that watches a path and runs a command whenever it detects
    modifications.

## Shell Alias

For lightning-fast command running, put `alias j=just` in your shell’s
configuration file.

## Syntax Highlighting

`justfile` syntax is close enough to `make` that you may want to tell
your editor to use make syntax highlighting for just.

### Vim

For vim, you can put the following in `~/.vim/filetype.vim`:

```vimscript
if exists("did_load_filetypes")
  finish
endif

augroup filetypedetect
  au BufNewFile,BufRead justfile setf make
augroup END
```

### Vim and Emacs

Include the following in a `justfile` to enable syntax highlighting in
vim and emacs:

    # Local Variables:
    # mode: makefile
    # End:
    # vim: set ft=make :

### Visual Studio Code

An extension for VS Code by [skellock](https://github.com/skellock) is
[available
here](https://marketplace.visualstudio.com/items?itemName=skellock.just).
([repository](https://github.com/skellock/vscode-just))

You can install it from the command line by running:

    code --install-extension skellock.just

### Kakoune

Kakoune supports `justfile` syntax highlighting out of the box, thanks
to TeddyDD.

### Other Editors

Feel free to send me the commands necessary to get syntax highlighting
working in your editor of choice so that I may include them here.

## Grammar

A non-normative grammar of justfiles can be found in
[GRAMMAR.md](GRAMMAR.md).

## just.sh

Before `just` was a fancy rust program it was a tiny shell script that
called `make`. You can find the old version in
[extras/just.sh](extras/just.sh).

## Non-Project Specific Justfile

If you want some commands to be available everywhere, put them in
`~/.justfile` and add the following to your shell’s initialization file:

```sh
alias .j='just --justfile ~/.justfile --working-directory ~'
```

Or, if you’d rather they run in the current directory:

```sh
alias .j='just --justfile ~/.justfile --working-directory .'
```

I’m pretty sure that nobody actually uses this feature, but it’s there.

¯\\\_(ツ)\_/¯

# Contributing

`just` welcomes your contributions\! `just` is released under the
maximally permissive
[CC0](https://creativecommons.org/publicdomain/zero/1.0/legalcode.txt)
public domain dedication and fallback license, so your changes must also
released under this license.

## Janus

[Janus](https://github.com/casey/janus) is a tool that collects and
analyzes justfiles, and can determine if a new version of `just` breaks
or changes the interpretation of existing justfiles.

Before merging a particularly large or gruesome change, Janus should be
run to make sure that nothing breaks. Don’t worry about running Janus
yourself, Casey will happily run it for you on changes that need it.

# Frequently Asked Questions

## What are the idiosyncrasies of Make that Just avoids?

Make has some behaviors which are confusing, complicated, or make it
unsuitable for use as a general command runner.

One example is that under some circumstances, Make won’t actually run
the commands in a recipe. For example, if you have a file called `test`
and the following makefile:

```make
test:
  ./test
```

Make will refuse to run your tests:

```sh
$ make test
make: `test' is up to date.
```

Make assumes that the `test` recipe produces a file called `test`. Since
this file exists and the recipe has no other dependencies, Make thinks
that it doesn’t have anything to do and exits.

To be fair, this behavior is desirable when using Make as a build
system, but not when using it as a command runner. You can disable this
behavior for specific targets using Make’s built-in [`.PHONY` target
name](https://www.gnu.org/software/make/manual/html_node/Phony-Targets.html),
but the syntax is verbose and can be hard to remember. The explicit list
of phony targets, written separately from the recipe definitions, also
introduces the risk of accidentally defining a new non-phony target. In
`just`, all recipes are treated as if they were phony.

Other examples of Make’s idiosyncrasies include the difference between
`=` and `:=` in assignments, the confusing error messages that are
produced if you mess up your makefile, needing `$$` to use environment
variables in recipes, and incompatibilities between different flavors of
Make.

## What’s the relationship between just and cargo build scripts?

[Cargo build scripts](http://doc.crates.io/build-script.html) have a
pretty specific use, which is to control how cargo builds your rust
project. This might include adding flags to `rustc` invocations,
building an external dependency, or running some kind of codegen step.

`just`, on the other hand, is for all the other miscellaneous commands
you might run as part of development. Things like running tests in
different configurations, linting your code, pushing build artifacts to
a server, removing temporary files, and the like.

Also, although `just` is written in rust, it can be used regardless of
the language or build system your project uses.

# Further Ramblings

I personally find it very useful to write a `justfile` for almost every
project, big or small.

On a big project with multiple contributors, it’s very useful to have a
file with all the commands needed to work on the project close at hand.

There are probably different commands to test, build, lint, deploy, and
the like, and having them all in one place is useful and cuts down on
the time you have to spend telling people which commands to run and how
to type them.

And, with an easy place to put commands, it’s likely that you’ll come up
with other useful things which are part of the project’s collective
wisdom, but which aren’t written down anywhere, like the arcane commands
needed for some part of your revision control workflow, install all your
project’s dependencies, or all the random flags you might need to pass
to the build system.

Some ideas for recipes:

  - Deploying/publishing the project

  - Building in release mode vs debug mode

  - Running in debug mode or with logging enabled

  - Complex git workflows

  - Updating dependencies

  - Running different sets of tests, for example fast tests vs slow
    tests, or running them with verbose output

  - Any complex set of commands that you really should write down
    somewhere, if only to be able to remember them

Even for small, personal projects it’s nice to be able to remember
commands by name instead of ^Reverse searching your shell history, and
it’s a huge boon to be able to go into an old project written in a
random language with a mysterious build system and know that all the
commands you need to do whatever you need to do are in the `justfile`,
and that if you type `just` something useful (or at least interesting\!)
will probably happen.

For ideas for recipes, check out [this project’s `justfile`](justfile),
or some of the `justfile`​s [out in the
wild](https://github.com/search?utf8=%E2%9C%93&q=filename%3Ajustfile).

Anyways, I think that’s about it for this incredibly long-winded README.

I hope you enjoy using `just` and find great success and satisfaction in
all your computational endeavors\!

😸
