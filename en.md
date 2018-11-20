# [](#just)`just`

[![crates.io version](https://camo.githubusercontent.com/fd67b76a797be1191b71d1ae45eac93eb6060118/68747470733a2f2f696d672e736869656c64732e696f2f6372617465732f762f6a7573742e737667)](https://crates.io/crates/just) [![build status](https://camo.githubusercontent.com/095856e65c31c3997e2e669148a5acfbbf595131/68747470733a2f2f7472617669732d63692e6f72672f63617365792f6a7573742e7376673f6272616e63683d6d6173746572)](https://travis-ci.org/casey/just) [![chat on gitter](https://camo.githubusercontent.com/24475b651d82dbe0a8d3835ad158e7a153dbbc24/68747470733a2f2f6261646765732e6769747465722e696d2f6a7573742d626563617573652f4c6f6262792e737667)](https://gitter.im/just-because/Lobby) [![say thanks](https://camo.githubusercontent.com/0c9f6dc1c6a604b58d3c56bc5d7624e44f7eee2b/68747470733a2f2f696d672e736869656c64732e696f2f62616467652f5361792532305468616e6b732d212d3145414544422e737667)](https://saythanks.io/to/casey)

`just` is a handy way to save and run project-specific commands.

Commands are stored in a file called `justfile` or `Justfile` with syntax inspired by `make`:

build:
    cc \*.c -o main

# test everything
test-all: build
    ./test --all

# run a specific test
test TEST: build
    ./test --test {{TEST}}

You can then run them with `just COMMAND`:

$ just test
cc \*.c -o main
./test --all
Yay, all your tests passed!

`just` produces detailed error messages and avoids `make`’s idiosyncrasies, so debugging a justfile is easier and less surprising than debugging a makefile.

If you need help with `just` please feel free to open an issue or let me know on [gitter](https://gitter.im/just-because/Lobby). Feature requests and bug reports are always welcome!

## [](#manual)Manual

*   [Installation](#installation)
    *   [Pre-built Binaries](#pre-built-binaries)
    *   [Homebrew](#homebrew)
    *   [Scoop](#scoop)
    *   [Cargo](#cargo)
*   [Quick Start](#quick-start)
*   [Features](#features)
    *   [Listing Available Recipes](#listing-available-recipes)
    *   [Documentation Comments](#documentation-comments)
    *   [Variables and Substitution](#variables-and-substitution)
    *   [Strings](#strings)
    *   [Functions](#functions)
    *   [Command Evaluation Using Backticks](#command-evaluation-using-backticks)
    *   [Setting Variables from the Command Line](#setting-variables-from-the-command-line)
    *   [Environment Variables](#environment-variables-1)
    *   [Recipe Parameters](#recipe-parameters)
    *   [Writing Recipes in Other Languages](#writing-recipes-in-other-languages)
    *   [Command Line Options](#command-line-options)
    *   [Private Recipes](#private-recipes)
    *   [Quiet Recipes](#quiet-recipes)
    *   [Invoking Justfiles in Other Directories](#invoking-justfiles-in-other-directories)
*   [Frequently Asked Questions](#frequently-asked-questions)
    *   [What are the idiosyncrasies of make that just avoids?](#what-are-the-idiosyncrasies-of-make-that-just-avoids)
    *   [What’s the relationship between just and cargo build scripts?](#what-s-the-relationship-between-just-and-cargo-build-scripts)
*   [Miscellanea](#miscellanea)
    *   [Companion Tools](#companion-tools)
    *   [Shell Alias](#shell-alias)
    *   [Syntax Highlighting](#syntax-highlighting)
    *   [Grammar](#grammar)
    *   [just.sh](#just-sh)
    *   [Non-Project Specific Justfile](#non-project-specific-justfile)
*   [Further Ramblings](#further-ramblings)

## [](#installation)Installation

`just` should run on any system with a reasonable `sh`, including Linux, MacOS, and the BSDs.

On Windows, `just` works with the `sh` provided by [Git for Windows](https://git-scm.com), [GitHub Desktop](https://desktop.github.com), and [Cygwin](http://www.cygwin.com).

### built-binaries)Pre-built Binaries

Pre-built binaries for Linux, MacOS, and Windows can be found on [the releases page](https://github.com/casey/just/releases).

You can use the following command to download the latest binary for MacOS or Windows, just replace `DESTINATION_DIRECTORY` with the directory where you’d like to put `just`:

curl -LSfs https://japaric.github.io/trust/install.sh | \\
  sh -s -- --git casey/just --to DESTINATION\_DIRECTORY

On Linux, use:

curl -LSfs https://japaric.github.io/trust/install.sh | \\
  sh -s -- --git casey/just --target x86\_64-unknown-linux-musl --to DESTINATION\_DIRECTORY

### Homebrew

On MacOS, `just` can be installed using the [Homebrew package manager](https://brew.sh). Install Homebrew using the instructions [here](https://brew.sh), then run:

`brew install just`

### Scoop

On Windows, `just` can be installed using the [Scoop package manager](https://scoop.sh). Install Scoop using the instractions [here](https://scoop.sh/), then run:

scoop install just

### Cargo

On Windows, Linux, and macOS, `just` can be installed using Cargo, the [rust language package manager](https://www.rust-lang.org). Install Cargo using the instructions [here](https://www.rustup.rs), then run:

`cargo install just`

(You might also need to add `~/.cargo/bin` to your shell’s `$PATH`. If you can’t run just after installing it, put `export PATH="$HOME/.cargo/bin:$PATH"` in your shell’s configuration file.)

## [](#quick-start)Quick Start

See [Installation](#installation) for how to install `just` on your computer. Try running `just --version` to make sure that it’s installed correctly.

Once `just` is installed and working, create a file named `justfile` in the root of your project with the following contents:

recipe-name:
    echo 'This is a recipe!'

# this is a comment
another-recipe:
    @echo 'This is another recipe.'

When you invoke `just` it looks for a `justfile` in the current directory and upwards, so you can invoke it from any subdirectory of your project.

Running `just` with no arguments runs the first recipe in the `justfile`:

$ just
echo 'This is a recipe!'
This is a recipe!

One or more arguments specify the recipe(s) to run:

$ just another-recipe
This is another recipe.

`just` prints each command to standard error before running it, which is why `echo 'This is a recipe!'` was printed. This is suppressed for lines starting with `@`, which is why `echo 'Another recipe.'` was not printed.

Recipes stop running if a command fails. Here `cargo publish` will only run if `cargo test` succeeds:

publish:
    cargo test
    # tests passed, time to publish!
    cargo publish

Recipes can depend on other recipes. Here the `test` recipe depends on the `build` recipe, so `build` will run before `test`:

build:
    cc main.c foo.c bar.c -o main

test: build
    ./test

sloc:
    @echo "\`wc -l \*.c\` lines of code"

$ just test
cc main.c foo.c bar.c -o main
./test
testing... all tests passed!

Recipes without dependencies will run in the order they’re given on the command line:

$ just build sloc
cc main.c foo.c bar.c -o main
1337 lines of code

Dependencies will always run first, even if they are passed after a recipe that depends on them:

$ just test build
cc main.c foo.c bar.c -o main
./test
testing... all tests passed!

## [](#features)Features

### available-recipes)Listing Available Recipes

Recipes can be listed with `just --list` :

$ just --list
Available recipes:
  build
  test
  deploy
  lint

`just --summary` is more concise:

$ just --summary
build test deploy lint

### comments)Documentation Comments

Comments immediately preceding a recipe will appear in `just --list`:

# build stuff
build:
  ./bin/build

# test stuff
test:
  ./bin/test

$ just --list
Available recipes:
    build # build stuff
    test # test stuff

### and-substitution)Variables and Substitution

Variables, strings, concatenation, and substitution using `{{…​}}` are supported:

version = "0.2.7"
tardir  = "awesomesauce-" + version
tarball = tardir + ".tar.gz"

publish:
    rm -f {{tarball}}
    mkdir {{tardir}}
    cp README.md \*.c {{tardir}}
    tar zcvf {{tarball}} {{tardir}}
    scp {{tarball}} me@server.com:release/
    rm -rf {{tarball}} {{tardir}}

#### )Escaping `{{`

To write a recipe containing `{{`, use `{{ "{{" }}`:

braces:
	echo 'I {{ "{{" }}LOVE}} curly braces!'

(An unmatched `}}` is ignored, so it doesn’t need to be escaped.)

Another option is to put all the text you’d like to escape inside of an interpolation:

braces:
	echo '{{'I {{LOVE}} curly braces!'}}'

### Strings

Double-quoted strings support escape sequences:

string-with-tab             = "\\t"
string-with-newline         = "\\n"
string-with-carriage-return = "\\r"
string-with-double-quote    = "\\""
string-with-slash           = "\\\\"

$ just --evaluate
"tring-with-carriage-return = "
string-with-double-quote    = """
string-with-newline         = "
"
string-with-slash           = "\\"
string-with-tab             = "     "

Single-quoted strings do not recognize escape sequences and may contain line breaks:

escapes = '\\t\\n\\r\\"\\\\'

line-breaks = 'hello
this
is
  a
     raw
string!
'

$ just --evaluate
escapes = "\\t\\n\\r\\"\\\\"

line-breaks = "hello
this
is
 a
 raw
string!
"

### Functions

Just provides a few built-in functions that might be useful when writing recipes.

#### information)System Information

*   `arch()` – Instruction set architecture. Possible values are: `"aarch64"`, `"arm"`, `"asmjs"`, `"hexagon"`, `"mips"`, `"msp430"`, `"powerpc"`, `"powerpc64"`, `"s390x"`, `"sparc"`, `"wasm32"`, `"x86"`, `"x86_64"`, and `"xcore"`.
    
*   `os()` – Operating system. Possible values are: `"android"`, `"bitrig"`, `"dragonfly"`, `"emscripten"`, `"freebsd"`, `"haiku"`, `"ios"`, `"linux"`, `"macos"`, `"netbsd"`, `"openbsd"`, `"solaris"`, and `"windows"`.
    
*   `os_family()` – Operating system family; possible values are: `"unix"` and `"windows"`.
    

For example:

system-info:
	@echo "This is an {{arch()}} machine".

```
$ just system-info
This is an x86_64 machine
```

#### variables)Environment Variables

*   `env_var(key)` – Retrieves the environment variable with name `key`, aborting if it is not present.
    
*   `env_var_or_default(key, default)` – Retrieves the environment variable with name `key`, returning `default` if it is not present.
    

#### directory)Invocation Directory

*   `invocation_directory()` - Retrieves the path of the current working directory, before `just` changed it (chdir’d) prior to executing commands.
    

For example, to call `rustfmt` on files just under the "current directory" (from the user/invoker’s perspective), use the following rule:

```
rustfmt:
    find {{invocation_directory()}} -name \*.rs -exec rustfmt {} \;
```

Alternatively, if your command needs to be run from the current directory, you could use (e.g.):

```
build:
    cd {{invocation_directory()}}; ./some_script_that_needs_to_be_run_from_here
```

#### integration)Dotenv Integration

`just` will load environment variables from a file named `.env`. This file can be located in the same directory as your justfile or in a parent directory. These variables are environment variables, not `just` variables, and so must be accessed using `$VARIABLE_NAME` in recipes and backticks.

For example, if your `.env` file contains:

```
# a comment, will be ignored
DATABASE_ADDRESS=localhost:6379
SERVER_PORT=1337
```

And your justfile contains:

serve:
  @echo "Starting server with database $DATABASE\_ADDRESS on port $SERVER\_PORT..."
  ./server --database $DATABASE\_ADDRESS --port $SERVER\_PORT

`just serve` will output:

$ just serve
Starting server with database localhost:6379 on port 1337...
./server --database $DATABASE\_ADDRESS --port $SERVER\_PORT

### evaluation-using-backticks)Command Evaluation Using Backticks

Backticks can be used to store the result of commands:

localhost = \`dumpinterfaces | cut -d: -f2 | sed 's/\\/.\*//' | sed 's/ //g'\`

serve:
    ./serve {{localhost}} 8080

### variables-from-the-command-line)Setting Variables from the Command Line

Variables can be overridden from the command line.

os = "linux"

test: build
    ./test --test {{os}}

build:
    ./build {{os}}

$ just
./build linux
./test --test linux

Any number of arguments of the form `NAME=VALUE` can be passed before recipes:

$ just os=plan9
./build plan9
./test --test plan9

Or you can use the `--set` flag:

$ just --set os bsd
./build bsd
./test --test bsd

### variables-1)Environment Variables

Assignments prefixed with the `export` keyword will be exported to recipes as environment variables:

export RUST\_BACKTRACE = "1"

test:
    # will print a stack trace if it crashes
    cargo test

### parameters)Recipe Parameters

Recipes may have parameters. Here recipe `build` has a parameter called `target`:

build target:
    @echo 'Building {{target}}...'
    cd {{target}} && make

Other recipes may not depend on a recipe with parameters.

To pass arguments, put them after the recipe name:

$ just build my-awesome-project
Building my-awesome-project...
cd my-awesome-project && make

Parameters may have default values:

test target tests='all':
    @echo 'Testing {{target}}:{{tests}}...'
    ./test --tests {{tests}} {{target}}

Parameters with default values may be omitted:

$ just test server
Testing server:all...
./test --tests all server

Or supplied:

$ just test server unit
Testing server:unit...
./test --tests unit server

The last parameter of a recipe may be variadic, indicated with a `+` before the argument name:

backup +FILES:
  scp {{FILES}} me@server.com:

Variadic parameters accept one or more arguments and expand to a string containing those arguments separated by spaces:

$ just backup FAQ.md GRAMMAR.md
scp FAQ.md GRAMMAR.md me@server.com:
FAQ.md                  100% 1831     1.8KB/s   00:00
GRAMMAR.md              100% 1666     1.6KB/s   00:00

A variadic parameter with a default argument will accept zero or more arguments:

commit MESSAGE +FLAGS='':
  git commit {{FLAGS}} -m "{{MESSAGE}}"

`{{…​}}` substitutions may need to be quoted if they contains spaces. For example, if you have the following recipe:

search QUERY:
    lynx https://www.google.com/?q={{QUERY}}

And you type:

$ just search "cat toupee"

Just will run the command `lynx [google.com/?q=cat](https://www.google.com/?q=cat) toupee`, which will get parsed by `sh` as `lynx`, `[google.com/?q=cat](https://www.google.com/?q=cat)`, and `toupee`, and not the intended `lynx` and `[google.com/?q=cat](https://www.google.com/?q=cat) toupee`.

You can fix this by adding quotes:

search QUERY:
    lynx 'https://www.google.com/?q={{QUERY}}'

### recipes-in-other-languages)Writing Recipes in Other Languages

Recipes that start with a `#!` are executed as scripts, so you can write recipes in other languages:

polyglot: python js perl sh ruby

python:
    #!/usr/bin/env python3
    print('Hello from python!')

js:
    #!/usr/bin/env node
    console.log('Greetings from JavaScript!')

perl:
    #!/usr/bin/env perl
    print "Larry Wall says Hi!\\n";

sh:
    #!/usr/bin/env sh
    hello\='Yo'
    echo "$hello from a shell script!"

ruby:
    #!/usr/bin/env ruby
    puts "Hello from ruby!"

$ just polyglot
Hello from python!
Greetings from JavaScript!
Larry Wall says Hi!
Yo from a shell script!
Hello from ruby!

### line-options)Command Line Options

`just` supports a number of useful command line options for listing, dumping, and debugging recipes and variable:

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
    print "Larry Wall says Hi!\\n";
$ just --show polyglot
polyglot: python js perl sh ruby

Run `just --help` to see all the options.

### recipes)Private Recipes

Recipes whose name starts with a `_` are omitted from `just --list`:

test: \_test-helper
  ./bin/test

\_test-helper:
  ./bin/super-secret-test-helper-stuff

$ just --list
Available recipes:
  test

And from `just --summary`:

$ just --summary
test

This is useful for helper recipes which are only meant to be used as dependencies of other recipes.

### recipes)Quiet Recipes

A recipe name may be prefixed with '@' to invert the meaning of '@' before each line:

@quiet:
  echo hello
  echo goodbye
  @# all done!

Now only the lines starting with '@' will be echoed:

$ j quiet
hello
goodbye
# all done!

### justfiles-in-other-directories)Invoking Justfiles in Other Directories

If the first argument passed to `just` contains a `/`, then the following occurs:

1.  The argument is split at the last `/`.
    
2.  The part before the last `/` is treated as a directory. Just will start its search for the justfile there, instead of in the current directory.
    
3.  The part after the last slash is treated as a normal argument, or ignored if it is empty.
    

This may seem a little strange, but it’s useful if you wish to run a command in a justfile that is in a subdirectory.

For example, if you are in a directory which contains a subdirectory named `foo`, which contains a justfile with the recipe `build`, which is also the default recipe, the following are all equivalent:

$ (cd foo && just build)
$ just foo/build
$ just foo/

## [](#frequently-asked-questions)Frequently Asked Questions

### are-the-idiosyncrasies-of-make-that-just-avoids)What are the idiosyncrasies of make that just avoids?

Make has some behaviors which are either confusing, complicated, or make it unsuitable for use as a general command runner.

One example is that sometimes make won’t run the commands in a recipe. For example, if you have a file called `test` and the the following makefile that runs it:

test:
  ./test

Make will actually refuse to run it:

$ make test
make: \`test' is up to date.

Make sees the recipe `test` and assumes that it produces a file called `test`. It then sees that this file exists and thus assumes that the recipe doesn’t need to be run.

To be fair, this behavior is desirable when using make as a build system, but not when using it as a command runner.

Some other examples include having to understand the difference between `=` and `:=` assignment, the confusing error messages that can be produced if you mess up your makefile, having to use `$$` to write recipes that use environment variables, and incompatibilites between different flavors of make.

### the-relationship-between-just-and-cargo-build-scripts)What’s the relationship between just and cargo build scripts?

[Cargo build scripts](http://doc.crates.io/build-script.html) have a pretty specific use, which is to control how cargo builds your rust project. This might include adding flags to `rustc` invocations, building an external dependency, or running some kind of codegen step.

`just`, on the other hand, is for all the other miscellaneous commands you might run as part of development. Things like running tests in different configurations, linting your code, pushing build artifacts to a server, removing temporary files, and the like.

Also, although `just` is written in rust, it can be used regardless of the language or build system your project uses.

## [](#miscellanea)Miscellanea

### tools)Companion Tools

Tools that pair nicely with `just` include:

*   [`watchexec`](https://github.com/mattgreen/watchexec) — a simple tool that watches a path and runs a command whenever it detects modifications.
    

### alias)Shell Alias

For lightning-fast command running, put `alias j=just` in your shell’s configuration file.

### highlighting)Syntax Highlighting

`justfile` syntax is close enough to `make` that you may want to tell your editor to use make syntax highlighting for just.

#### Vim

For vim, you can put the following in `~/.vim/filetype.vim`:

```
if exists("did_load_filetypes")
  finish
endif

augroup filetypedetect
  au BufNewFile,BufRead Justfile,justfile setf make
augroup END
```

#### and-emacs)Vim and Emacs

Include the following in a `justfile` to enable syntax highlighting in vim and emacs:

```
# Local Variables:
# mode: makefile
# End:
# vim: set ft=make :
```

#### studio-code)Visual Studio Code

An extension for VS Code by [skellock](https://github.com/skellock) is [available here](https://marketplace.visualstudio.com/items?itemName=skellock.just). ([repository](https://github.com/skellock/vscode-just))

You can install it from the command line by running:

```
code --install-extension skellock.just
```

#### Kakoune

Kakoune supports `justfile` syntax highlighting out of the box, thanks to TeddyDD.

#### editors)Other Editors

Feel free to send me the commands necessary to get syntax highlighting working in your editor of choice so that I may include them here.

### Grammar

A non-normative grammar of justfiles can be found in [GRAMMAR.md](/casey/just/blob/master/GRAMMAR.md).

### just.sh

Before `just` was a fancy rust program it was a tiny shell script that called `make`. You can find the old version in [extras/just.sh](/casey/just/blob/master/extras/just.sh).

### project-specific-justfile)Non-Project Specific Justfile

If you want some commands to be available everwhere, put them in `~/.justfile` and add the following to your shell’s initialization file:

alias .j='just --justfile ~/.justfile --working-directory ~'

Or, if you’d rather they run in the current directory:

alias .j='just --justfile ~/.justfile --working-directory .'

I’m pretty sure that nobody actually uses this feature, but it’s there.

¯\\\_(ツ)\_/¯

## [](#further-ramblings)Further Ramblings

I personally find it very useful to write a `justfile` for almost every project, big or small.

On a big project with multiple contributors, it’s very useful to have a file with all the commands needed to work on the project close at hand.

There are probably different commands to test, build, lint, deploy, and the like, and having them all in one place is useful and cuts down on the time you have to spend telling people which commands to run and how to type them.

And, with an easy place to put commands, it’s likely that you’ll come up with other useful things which are part of the project’s collective wisdom, but which aren’t written down anywhere, like the arcane commands needed for some part of your revision control workflow, install all your project’s dependencies, or all the random flags you might need to pass to the build system.

Some ideas for recipes:

*   Deploying/publishing the project
    
*   Building in release mode vs debug mode
    
*   Running in debug mode or with logging enabled
    
*   Complex git workflows
    
*   Updating dependencies
    
*   Running different sets of tests, for example fast tests vs slow tests, or running them with verbose output
    
*   Any complex set of commands that you really should write down somewhere, if only to be able to remember them
    

Even for small, personal projects it’s nice to be able to remember commands by name instead of ^Reverse searching your shell history, and it’s a huge boon to be able to go into an old project written in a random language with a mysterious build system and know that all the commands you need to do whatever you need to do are in the `justfile`, and that if you type `just` something useful (or at least interesting!) will probably happen.

For ideas for recipes, check out [this project’s `justfile`](/casey/just/blob/master/justfile), or some of the `justfile`​s [out in the wild](https://github.com/search?utf8=%E2%9C%93&q=filename%3Ajustfile).

Anyways, I think that’s about it for this incredibly long-winded README.

I hope you enjoy using `just` and find great success and satisfaction in all your computational endeavors!

😸