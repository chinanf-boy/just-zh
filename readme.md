# casey/just [![explain]][source] [![translate-svg]][translate-list]

<!-- [![size-img]][size] -->

[explain]: http://llever.com/explain.svg
[source]: https://github.com/chinanf-boy/Source-Explain
[translate-svg]: http://llever.com/translate.svg
[translate-list]: https://github.com/chinanf-boy/chinese-translate-list
[size-img]: https://packagephobia.now.sh/badge?p=Name
[size]: https://packagephobia.now.sh/result?p=Name

「 `just`是保存和运行项目的特定命令的简便方法. 」

[中文](./readme.md) | [english](https://github.com/casey/just)

---

## 校对 🀄️

<!-- doc-templite START generated -->
<!-- repo = 'casey/just' -->
<!-- commit = '1ad3f996366a515ac4124ad44e1db7bba145884c' -->
<!-- time = '2018-11-06' -->

| 翻译的原文 | 与日期        | 最新更新 | 更多                       |
| ---------- | ------------- | -------- | -------------------------- |
| [commit]   | ⏰ 2018-11-06 | ![last]  | [中文翻译][translate-list] |

[last]: https://img.shields.io/github/last-commit/casey/just.svg
[commit]: https://github.com/casey/just/tree/1ad3f996366a515ac4124ad44e1db7bba145884c

<!-- doc-templite END generated -->

### 贡献

欢迎 👏 勘误/校对/更新贡献 😊 [具体贡献请看](https://github.com/chinanf-boy/chinese-translate-list#贡献)

## 生活

[help me live , live need money 💰](https://github.com/chinanf-boy/live-need-money)

---

### 目录

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->


- [`just`](#just)
  - [Manual](#manual)
  - [Installation](#installation)
    - [Pre-built Binaries](#pre-built-binaries)
    - [Homebrew](#homebrew)
    - [Scoop](#scoop)
    - [Cargo](#cargo)
  - [Quick Start](#quick-start)
  - [Features](#features)
    - [Listing Available Recipes](#listing-available-recipes)
    - [Documentation Comments](#documentation-comments)
    - [Variables and Substitution](#variables-and-substitution)
      - [Escaping `{{`](#escaping-)
    - [Strings](#strings)
    - [Functions](#functions)
      - [System Information](#system-information)
      - [Environment Variables](#environment-variables)
      - [Invocation Directory](#invocation-directory)
      - [Dotenv Integration](#dotenv-integration)
    - [Command Evaluation Using Backticks](#command-evaluation-using-backticks)
    - [Setting Variables from the Command Line](#setting-variables-from-the-command-line)
    - [Environment Variables](#environment-variables-1)
    - [Recipe Parameters](#recipe-parameters)
    - [Writing Recipes in Other Languages](#writing-recipes-in-other-languages)
    - [Command Line Options](#command-line-options)
    - [Private Recipes](#private-recipes)
    - [Quiet Recipes](#quiet-recipes)
    - [Invoking Justfiles in Other Directories](#invoking-justfiles-in-other-directories)
  - [Frequently Asked Questions](#frequently-asked-questions)
    - [What are the idiosyncrasies of make that just avoids?](#what-are-the-idiosyncrasies-of-make-that-just-avoids)
    - [What’s the relationship between just and cargo build scripts?](#whats-the-relationship-between-just-and-cargo-build-scripts)
  - [Miscellanea](#miscellanea)
    - [Companion Tools](#companion-tools)
    - [Shell Alias](#shell-alias)
    - [Syntax Highlighting](#syntax-highlighting)
      - [Vim](#vim)
      - [Vim and Emacs](#vim-and-emacs)
      - [Visual Studio Code](#visual-studio-code)
      - [Kakoune](#kakoune)
      - [Other Editors](#other-editors)
    - [Grammar](#grammar)
    - [just.sh](#justsh)
    - [Non-Project Specific Justfile](#non-project-specific-justfile)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->


# `just`

[![crates.io version](https://img.shields.io/crates/v/just.svg)](https://crates.io/crates/just) [![build status](https://travis-ci.org/casey/just.svg?branch=master)](https://travis-ci.org/casey/just) [![chat on gitter](https://badges.gitter.im/just-because/Lobby.svg)](https://gitter.im/just-because/Lobby) [![say thanks](https://img.shields.io/badge/Say%20Thanks-!-1EAEDB.svg)](https://saythanks.io/to/casey)

`just`是保存和运行特定于项目的命令的简便方法.

命令存储在一个名为`justfile`或`Justfile`语法启发`make`:

```make
build:
    cc *.c -o main

= test everything
:doctype: book

= test everything
test-all: build
    ./test --all

= run a specific test
:doctype: book

= run a specific test
test TEST: build
    ./test --test {{TEST}}
```

然后可以运行它们.`just COMMAND`:

```sh
$ just test
cc *.c -o main
./test --all
Yay, all your tests passed!
```

`just`产生详细的错误消息并避免`make`的特性,因此调试一个 JavaScript 比调试一个 MaMo 文件更容易,也不会令人惊讶.

如果你需要帮助`just`请随时打开一个问题或让我知道[gitter](https://gitter.im/just-because/Lobby). 始终欢迎特性请求和错误报告!

## Manual

## Installation

`just`应在任何系统上合理运行`sh`包括 Linux、MACOS 和 BSD.

在 Windows 上,`just`一起工作`sh`提供的[Git for Windows](https://git-scm.com),[GitHub Desktop](https://desktop.github.com)和[Cygwin](http://www.cygwin.com).

### Pre-built Binaries

Linux、MACOS 和 Windows 的预构建二进制文件可以在[the releases page](https://github.com/casey/just/releases).

您可以使用以下命令下载 Mac OS 或 Windows 的最新二进制文件,只需替换`DESTINATION_DIRECTORY`用你想放的目录`just`:

```sh
curl -LSfs https://japaric.github.io/trust/install.sh | \
|   sh -s -- --git casey/just --to DESTINATION_DIRECTORY
```

在 Linux 上,使用:

```sh
curl -LSfs https://japaric.github.io/trust/install.sh | \
|   sh -s -- --git casey/just --target x86_64-unknown-linux-musl --to DESTINATION_DIRECTORY
```

### Homebrew

关于 MaOSOS,`just`可以安装使用[Homebrew package manager](https://brew.sh). 使用指令安装自制程序[here](https://brew.sh)然后运行:

`brew install just`

### Scoop

在 Windows 上,`just`可以安装使用[Scoop package manager](https://scoop.sh). 使用仪器安装勺子[here](https://scoop.sh/)然后运行:

```powershell
scoop install just
```

### Cargo

在 Windows、Linux 和 MACOS 上,`just`可使用货物安装,[rust language package manager](https://www.rust-lang.org). 使用说明书安装货物[here](https://www.rustup.rs)然后运行:

`cargo install just`

(您可能还需要添加`~/.cargo/bin`你的外壳`$PATH`. 如果安装后不能运行,请`export PATH="$HOME/.cargo/bin:$PATH"`在 shell 的配置文件中.

## Quick Start

见[Installation](#_installation)如何安装`just`在你的电脑上.试运行`just --version`确保安装正确.

一次`just`安装和工作,创建一个名为`justfile`在项目的根目录中有以下内容:

```make
recipe-name:
    echo 'This is a recipe!'

= this is a comment
:doctype: book

= this is a comment
another-recipe:
    @echo 'This is another recipe.'
```

当你调用`just`寻找一个`justfile`在当前目录和向上,因此您可以从项目的任何子目录调用它.

运行`just`在没有参数的情况下运行第一个配方`justfile`:

```sh
$ just
echo 'This is a recipe!'
This is a recipe!
```

一个或多个参数指定要运行的配方(S):

```sh
$ just another-recipe
This is another recipe.
```

`just`在运行之前,将每个命令打印为标准错误,这就是为什么`echo 'This is a recipe!'`打印出来了.这对于开始的线路来说是被抑制的.`@`这就是为什么`echo 'Another recipe.'`没有打印.

如果命令失败,配方将停止运行.在这里`cargo publish`将只运行如果`cargo test`成功:

```make
publish:
    cargo test
    # tests passed, time to publish!
    cargo publish
```

食谱可以依赖其他食谱.这里`test`食谱取决于`build`食谱,所以`build`将运行之前`test`:

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

没有依赖关系的配方将按照命令行上的顺序运行:

```sh
$ just build sloc
cc main.c foo.c bar.c -o main
1337 lines of code
```

依赖关系总是首先运行,即使它们在依赖于它们的配方之后传递:

```sh
$ just test build
cc main.c foo.c bar.c -o main
./test
testing... all tests passed!
```

## Features

### Listing Available Recipes

食谱可以列出`just --list`:

```sh
$ just --list
Available recipes:
  build
  test
  deploy
  lint
```

`just --summary`更简洁:

```sh
$ just --summary
build test deploy lint
```

### Documentation Comments

立即出现在配方之前的注释将出现在`just --list`:

```make
= build stuff
:doctype: book

= build stuff
build:
  ./bin/build

= test stuff
:doctype: book

= test stuff
test:
  ./bin/test
```

```sh
$ just --list
Available recipes:
    build # build stuff
    test # test stuff
```

### Variables and Substitution

变量、字符串、级联和替换使用`{{…​}}`支持:

```make
version = "0.2.7"
tardir  = "awesomesauce-" + version
tarball = tardir + ".tar.gz"

publish:
    rm -f {{tarball}}
    mkdir {{tardir}}
    cp README.md *.c {{tardir}}
    tar zcvf {{tarball}} {{tardir}}
    scp {{tarball}} me@server.com:release/
    rm -rf {{tarball}} {{tardir}}
```

#### Escaping `{{`

写一份包含`{{`使用`{{ "{{" }}`:

```make
braces:
	echo 'I {{ "{{" }}LOVE}} curly braces!'
```

无与伦比的`}}`被忽略,因此不需要转义.

另一个选择是把所有你想逃离的文本插入到插值中:

```make
braces:
	echo '{{'I {{LOVE}} curly braces!'}}'
```

### Strings

双引号字符串支持转义序列:

```make
string-with-tab             = "\t"
string-with-newline         = "\n"
string-with-carriage-return = "\r"
string-with-double-quote    = "\""
string-with-slash           = "\\"
```

```sh
$ just --evaluate
"tring-with-carriage-return = "
string-with-double-quote    = """
string-with-newline         = "
"
string-with-slash           = "\"
string-with-tab             = "     "
```

单引号字符串不识别转义序列,可能包含断线:

```make
escapes = '\t\n\r\"\\'

line-breaks = 'hello
this
is
  a
     raw
string!
'
```

```sh
$ just --evaluate
escapes = "\t\n\r\"\\"

line-breaks = "hello
this
is
  a
     raw
string!
"
```

### Functions

只提供一些内置函数,在编写菜谱时可能有用.

#### System Information

- `arch()`-指令集体系结构.可能的值是:`"aarch64"`,`"arm"`,`"asmjs"`,`"hexagon"`,`"mips"`,`"msp430"`,`"powerpc"`,`"powerpc64"`,`"s390x"`,`"sparc"`,`"wasm32"`,`"x86"`,`"x86_64"`和`"xcore"`.

- `os()`-操作系统.可能的值是:`"android"`,`"bitrig"`,`"dragonfly"`,`"emscripten"`,`"freebsd"`,`"haiku"`,`"ios"`,`"linux"`,`"macos"`,`"netbsd"`,`"openbsd"`,`"solaris"`和`"windows"`.

- `os_family()`操作系统家族;可能的价值是:`"unix"`和`"windows"`.

例如:

```make
system-info:
	@echo "This is an {{arch()}} machine".
```

```
$ just system-info
This is an x86_64 machine
```

#### Environment Variables

- `env_var(key)`-用名称检索环境变量`key`如果不存在则中止.

- `env_var_or_default(key, default)`-用名称检索环境变量`key`归来`default`如果它不存在.

#### Invocation Directory

- `invocation_directory()`-检索当前工作目录的路径,然后`just`在执行命令之前更改它(CHDIR).

例如,呼叫`rustfmt`在"当前目录"下的文件(从用户/调用方的角度),使用以下规则:

```
rustfmt:
    find {{invocation_directory()}} -name \*.rs -exec rustfmt {} \;
```

或者,如果您的命令需要从当前目录运行,您可以使用(例如):

```
build:
    cd {{invocation_directory()}}; ./some_script_that_needs_to_be_run_from_here
```

#### Dotenv Integration

`just`将从名为文件的环境加载环境变量`.env`. 此文件可以位于同一个目录中,作为您的 Javafile 或父目录.这些变量是环境变量,而不是`just`变量等必须使用`$VARIABLE_NAME`食谱和底盘.

例如,如果你`.env`文件包含:

```
= a comment, will be ignored
:doctype: book

= a comment, will be ignored
DATABASE_ADDRESS=localhost:6379
SERVER_PORT=1337
```

你的 JavaScript 包含:

```make
serve:
  @echo "Starting server with database $DATABASE_ADDRESS on port $SERVER_PORT..."
  ./server --database $DATABASE_ADDRESS --port $SERVER_PORT
```

`just serve`意志产出:

```sh
$ just serve
Starting server with database localhost:6379 on port 1337...
./server --database $DATABASE_ADDRESS --port $SERVER_PORT
```

### Command Evaluation Using Backticks

后台可以用来存储命令的结果:

```make
| localhost = `dumpinterfaces | cut -d: -f2 | sed 's/\/.*//' | sed 's/ //g'`
|===

serve:
    ./serve {{localhost}} 8080
```

### Setting Variables from the Command Line

变量可以从命令行重写.

```make
os = "linux"

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

窗体的任意数量的参数`NAME=VALUE`可以在食谱之前通过:

```sh
$ just os=plan9
./build plan9
./test --test plan9
```

或者你可以使用`--set`旗帜:

```sh
$ just --set os bsd
./build bsd
./test --test bsd
```

### Environment Variables

与前缀有关的作业`export`关键字将作为环境变量导出到配方中:

```make
export RUST_BACKTRACE = "1"

test:
    # will print a stack trace if it crashes
    cargo test
```

### Recipe Parameters

食谱可能有参数.这里的食谱`build`有一个参数叫做`target`:

```make
build target:
    @echo 'Building {{target}}...'
    cd {{target}} && make
```

其他配方可能不依赖于配方的参数.

为了传递论点,把它们放在食谱名称后面:

```sh
$ just build my-awesome-project
Building my-awesome-project...
cd my-awesome-project && make
```

参数可能具有默认值:

```make
test target tests='all':
    @echo 'Testing {{target}}:{{tests}}...'
    ./test --tests {{tests}} {{target}}
```

可以省略具有默认值的参数:

```sh
$ just test server
Testing server:all...
./test --tests all server
```

或提供:

```sh
$ just test server unit
Testing server:unit...
./test --tests unit server
```

配方的最后一个参数可以是变量,用 A 表示.`+`在参数名称之前:

```make
backup +FILES:
  scp {{FILES}} me@server.com:
```

变量参数接受一个或多个参数,并扩展到包含由空间分隔的那些参数的字符串:

```sh
$ just backup FAQ.md GRAMMAR.md
scp FAQ.md GRAMMAR.md me@server.com:
FAQ.md                  100% 1831     1.8KB/s   00:00
GRAMMAR.md              100% 1666     1.6KB/s   00:00
```

具有默认参数的变量参数将接受零个或多个参数:

```make
commit MESSAGE +FLAGS='':
  git commit {{FLAGS}} -m "{{MESSAGE}}"
```

`{{…​}}`替换可能需要引用,如果它们包含空格.例如,如果你有以下配方:

```make
search QUERY:
    lynx https://www.google.com/?q={{QUERY}}
```

你的类型是:

```sh
$ just search "cat toupee"
```

只会运行命令`lynx [https://www.google.com/?q=cat](https://www.google.com/?q=cat) toupee`将被解析`sh`作为`lynx`,`[https://www.google.com/?q=cat](https://www.google.com/?q=cat)`和`toupee`不是故意的`lynx`和`[https://www.google.com/?q=cat](https://www.google.com/?q=cat) toupee`.

你可以通过添加引文来修正这个问题:

```make
search QUERY:
    lynx 'https://www.google.com/?q={{QUERY}}'
```

### Writing Recipes in Other Languages

从 A 开始的食谱`#!`作为脚本执行,所以你可以用其他语言编写菜谱:

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

### Command Line Options

`just`支持许多有用的命令行选项,用于列表、倾倒和调试配方和变量:

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

跑`just --help`查看所有选项.

### Private Recipes

名称以 A 开头的食谱`_`省略`just --list`:

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

从`just --summary`:

```sh
$ just --summary
test
```

这对于有用的食谱来说是有用的,它只是用来作为其他菜谱的依赖.

### Quiet Recipes

食谱名称可以用"@"前缀,以在每行之前反转"@"的含义:

```make
@quiet:
  echo hello
  echo goodbye
  @# all done!
```

现在,只有用"@"开头的台词会回响:

```sh
$ j quiet
hello
goodbye
= all done!
:doctype: book

= all done!
```

### Invoking Justfiles in Other Directories

如果第一个参数传递给`just`包含一个`/`然后发生以下情况:

1.  争论最终破裂了.`/`.

2.  最后一部分`/`被视为目录.只会开始在那里搜索 JavaScript,而不是在当前目录中搜索.

3.  最后一个斜杠之后的部分被当作一个普通的参数,或者如果它是空的则被忽略.

这看起来有点奇怪,但是如果您希望在子目录中的 JavaScript 中运行命令,这是很有用的.

例如,如果您在包含子目录名的目录中`foo`,其中包含一个带有配方的 JavaScript`build`这也是默认配方,以下都是等价的:

```sh
$ (cd foo && just build)
$ just foo/build
$ just foo/
```

## Frequently Asked Questions

### What are the idiosyncrasies of make that just avoids?

make 有一些混淆或复杂的行为,或者使它不适合用作一般的指挥者.

一个例子是,有时制作不会在配方中运行命令.例如,如果有一个文件叫`test`下面的 Mag 文件运行它:

```make
test:
  ./test
```

使意志实际上拒绝运行它:

```sh
$ make test
make: `test' is up to date.
```

造见食谱`test`并假定它产生一个名为`test`. 然后,该文件存在,因此假定配方不需要运行.

公平地说,当使用 make 作为构建系统时,这种行为是可取的,但是当使用它作为命令运行程序时,则不是这样.

其他一些例子包括必须理解两者之间的区别.`=`和`:=`赋值,如果您弄乱了生成文件,可以使用的混淆错误消息必须使用.`$$`编写使用环境变量的配方,以及不同口味的配方之间的不相容性.

### What’s the relationship between just and cargo build scripts?

[Cargo build scripts](http://doc.crates.io/build-script.html)有一个非常具体的用途,这是控制货物如何建立你的锈项目.这可能包括将标志添加到`rustc`调用,建立外部依赖,或运行某种类型的代码步.

`just`另一方面,是作为开发的一部分运行的所有其他杂项命令.比如在不同的配置中运行测试、链接代码、将构建构件推送到服务器、删除临时文件等等.

而且,虽然`just`写在锈迹中,它可以被使用,而不管你的项目使用的语言或构建系统.

## Miscellanea

### Companion Tools

很好搭配的工具`just`包括:

- [`watchexec`](https://github.com/mattgreen/watchexec)-一个简单的工具,它监视路径并在检测到修改时运行命令.

### Shell Alias

为了闪电般的命令运行,把`alias j=just`在 shell 的配置文件中.

### Syntax Highlighting

`justfile`语法足够接近`make`您可能希望告诉编辑器使用语法语法高亮显示.

#### Vim

对于 VIM,您可以将以下内容放入`~/.vim/filetype.vim`:

```vimscript
if exists("did_load_filetypes")
  finish
endif

augroup filetypedetect
  au BufNewFile,BufRead Justfile,justfile setf make
augroup END
```

#### Vim and Emacs

在 A 中包括以下内容`justfile`在 VIM 和 Emacs 中启用语法高亮显示:

```
= Local Variables:
:doctype: book

= Local Variables:
= mode: makefile
:doctype: book

= mode: makefile
= End:
:doctype: book

= End:
= vim: set ft=make :
:doctype: book

= vim: set ft=make :
```

#### Visual Studio Code

VS 代码的扩展[skellock](https://github.com/skellock)是[available here](https://marketplace.visualstudio.com/items?itemName=skellock.just). ([repository](https://github.com/skellock/vscode-just))

您可以通过运行命令从命令行安装它:

```
code --install-extension skellock.just
```

#### Kakoune

卡库尼支座`justfile`语法高亮出框,感谢 TeddyDD.

#### Other Editors

请随时给我发送必要的命令,使语法高亮工作在您的编辑器的选择,以便我可以在这里包括他们.

### Grammar

JavaScript 的非规范语法可以在[GRAMMAR.md](GRAMMAR.md).

### just.sh

以前`just`是一个花哨的锈程序,它是一个小小的外壳脚本`make`. 您可以在旧版本中找到[extras/just.sh](extras/just.sh).

### Non-Project Specific Justfile

如果你想要一些命令在任何地方都可用,把它们放进去.`~/.justfile`并将下列内容添加到 shell 初始化文件中:

```sh
alias .j='just --justfile ~/.justfile --working-directory ~'
```

或者,如果你宁愿他们运行在当前目录:

```sh
alias .j='just --justfile ~/.justfile --working-directory .'
```

我敢肯定没有人真正使用这个功能,但它在那里.

γ\\\_(ツ)\_/¯

## 进一步漫步

我个人觉得写一本书很有用.`贾斯文`几乎每一个项目,无论大小.

在一个有多个贡献者的大型项目中,拥有一个包含所有命令的文件来处理项目是非常有用的.

可能需要测试、构建、lint、部署等不同的命令,将它们全部放在一个地方很有用,并且减少了告诉人们要运行哪些命令以及如何键入命令的时间.

而且,有了一个易于放置命令的地方,您很可能会想到其他有用的东西,这些东西是项目集体智慧的一部分,但是它们没有写在任何地方

像修订控制工作流程的某些部分所需的神秘命令一样,安装所有项目的依赖项,或者您可能需要传递给构建系统的所有随机标记.

食谱的一些想法:

-   部署/发布项目

-   发布模式与调试模式的构建

-   运行调试模式或启用日志记录

-   复杂的GIT工作流

-   更新依赖关系

-   运行不同的测试集,例如快速测试和慢测试,或者用冗长的输出来运行它们.

-   任何复杂的命令集,只要你能记住它们,你就应该写在某个地方.

即使对于小型的个人项目,能够按名称记住命令,而不是^反向搜索shell历史记录也是很好的,并且能够使用神秘的构建系统进入用随机语言编写的旧项目,并且知道您需要执行的所有命令,这对于您来说是巨大的好处.做任何你需要做的事`justfile`,如果你输入`只是`可能会发生一些有用(或至少有趣!)的事情.

有关食谱的建议,请查看[这个项目的`justfile`](justfile)或者一些`justfile`小号[在野外](https://github.com/search?utf8=%E2%9C%93&q=filename%3Ajustfile).

无论如何,我认为这是关于这个令人难以置信的冗长的自述文件.

我希望你喜欢用`只是`并在您的所有计算工作中找到巨大的成功和满足感!

😸
