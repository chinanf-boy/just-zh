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

## 校对 ✅

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

<details>

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->


- [`just`](#just)
  - [使用手册](#%E4%BD%BF%E7%94%A8%E6%89%8B%E5%86%8C)
  - [安装](#%E5%AE%89%E8%A3%85)
    - [预先构建的 二进制文件](#%E9%A2%84%E5%85%88%E6%9E%84%E5%BB%BA%E7%9A%84-%E4%BA%8C%E8%BF%9B%E5%88%B6%E6%96%87%E4%BB%B6)
    - [Homebrew](#homebrew)
    - [Scoop](#scoop)
    - [Cargo](#cargo)
  - [让我们快速开始](#%E8%AE%A9%E6%88%91%E4%BB%AC%E5%BF%AB%E9%80%9F%E5%BC%80%E5%A7%8B)
  - [特性](#%E7%89%B9%E6%80%A7)
    - [列出可用的配方](#%E5%88%97%E5%87%BA%E5%8F%AF%E7%94%A8%E7%9A%84%E9%85%8D%E6%96%B9)
    - [文档注释](#%E6%96%87%E6%A1%A3%E6%B3%A8%E9%87%8A)
    - [变量和替代](#%E5%8F%98%E9%87%8F%E5%92%8C%E6%9B%BF%E4%BB%A3)
      - [转义 `{{`](#%E8%BD%AC%E4%B9%89-)
    - [Strings](#strings)
    - [函数](#%E5%87%BD%E6%95%B0)
      - [系统信息](#%E7%B3%BB%E7%BB%9F%E4%BF%A1%E6%81%AF)
      - [环境变量](#%E7%8E%AF%E5%A2%83%E5%8F%98%E9%87%8F)
      - [调用 目录](#%E8%B0%83%E7%94%A8-%E7%9B%AE%E5%BD%95)
      - [Dotenv 集成](#dotenv-%E9%9B%86%E6%88%90)
    - [执行命令可使用反引号](#%E6%89%A7%E8%A1%8C%E5%91%BD%E4%BB%A4%E5%8F%AF%E4%BD%BF%E7%94%A8%E5%8F%8D%E5%BC%95%E5%8F%B7)
    - [使用命令行工具，设置变量](#%E4%BD%BF%E7%94%A8%E5%91%BD%E4%BB%A4%E8%A1%8C%E5%B7%A5%E5%85%B7%E8%AE%BE%E7%BD%AE%E5%8F%98%E9%87%8F)
    - [环境变量](#%E7%8E%AF%E5%A2%83%E5%8F%98%E9%87%8F-1)
    - [配方 参数](#%E9%85%8D%E6%96%B9-%E5%8F%82%E6%95%B0)
    - [用其他语言来写配方](#%E7%94%A8%E5%85%B6%E4%BB%96%E8%AF%AD%E8%A8%80%E6%9D%A5%E5%86%99%E9%85%8D%E6%96%B9)
    - [命令行选项](#%E5%91%BD%E4%BB%A4%E8%A1%8C%E9%80%89%E9%A1%B9)
    - [私有配方](#%E7%A7%81%E6%9C%89%E9%85%8D%E6%96%B9)
    - [安静配方](#%E5%AE%89%E9%9D%99%E9%85%8D%E6%96%B9)
    - [在其他目录调用 Justfiles](#%E5%9C%A8%E5%85%B6%E4%BB%96%E7%9B%AE%E5%BD%95%E8%B0%83%E7%94%A8-justfiles)
  - [FAQ](#faq)
    - [make 的什么特性，just 避免了？](#make-%E7%9A%84%E4%BB%80%E4%B9%88%E7%89%B9%E6%80%A7just-%E9%81%BF%E5%85%8D%E4%BA%86)
    - [just 和 cargo build 脚本有一腿吗?](#just-%E5%92%8C-cargo-build-%E8%84%9A%E6%9C%AC%E6%9C%89%E4%B8%80%E8%85%BF%E5%90%97)
  - [杂记(炸鸡?)](#%E6%9D%82%E8%AE%B0%E7%82%B8%E9%B8%A1)
    - [搭配工具](#%E6%90%AD%E9%85%8D%E5%B7%A5%E5%85%B7)
    - [Shell Alias(别名)](#shell-alias%E5%88%AB%E5%90%8D)
    - [语法 高亮](#%E8%AF%AD%E6%B3%95-%E9%AB%98%E4%BA%AE)
      - [Vim](#vim)
      - [Vim 和 Emacs](#vim-%E5%92%8C-emacs)
      - [Visual Studio Code](#visual-studio-code)
      - [Kakoune](#kakoune)
      - [其他编辑器](#%E5%85%B6%E4%BB%96%E7%BC%96%E8%BE%91%E5%99%A8)
    - [语法](#%E8%AF%AD%E6%B3%95)
    - [just.sh](#justsh)
    - [无定向项目的 Justfile](#%E6%97%A0%E5%AE%9A%E5%90%91%E9%A1%B9%E7%9B%AE%E7%9A%84-justfile)
  - [进一步漫谈](#%E8%BF%9B%E4%B8%80%E6%AD%A5%E6%BC%AB%E8%B0%88)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

</details>

<br>

# `just`

[![crates.io version](https://img.shields.io/crates/v/just.svg)](https://crates.io/crates/just) [![build status](https://travis-ci.org/casey/just.svg?branch=master)](https://travis-ci.org/casey/just) [![chat on gitter](https://badges.gitter.im/just-because/Lobby.svg)](https://gitter.im/just-because/Lobby) [![say thanks](https://img.shields.io/badge/Say%20Thanks-!-1EAEDB.svg)](https://saythanks.io/to/casey)

`just`是保存和运行项目的特定命令的简便方法。

命令存储在一个名为`justfile`或`Justfile`，语法启发`make`:

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

然后可以使用`just <COMMAND>`运行它们:

```sh
$ just test
cc *.c -o main
./test --all
Yay, all your tests passed!
```

> 有些困惑，没事，下面就帮你理清一切

`just`产生详细的错误消息,并避免`make`的特性,因此调试一个 justfile 比调试一个 markfile 文件更容易,也更少惊吓.

如果你需要帮助`just`，请随时打开一个问题或让我知道[gitter](https://gitter.im/just-because/Lobby). 始终欢迎功能请求和错误报告!

## 使用手册

## 安装

`just`应该能在合理`sh`的任何系统上运行，包括 Linux、MACOS 和 BSD.

在 Windows 上,`just`能与由[Git for Windows](https://git-scm.com),[GitHub Desktop](https://desktop.github.com)和[Cygwin](http://www.cygwin.com)提供的`sh`一起工作。

### 预先构建的 二进制文件

Linux、MacOS 和 Windows 的预构建二进制文件在[ releases 页面](https://github.com/casey/just/releases)。

您可以使用以下命令，下载 Mac OS 或 Windows 的最新二进制文件,只需替换`DESTINATION_DIRECTORY`成你想放置`just`的目录:

```sh
curl -LSfs https://japaric.github.io/trust/install.sh | \
  sh -s -- --git casey/just --to DESTINATION_DIRECTORY
```

在 Linux 上,使用:

```sh
curl -LSfs https://japaric.github.io/trust/install.sh | \
  sh -s -- --git casey/just --target x86_64-unknown-linux-musl --to DESTINATION_DIRECTORY
```

### Homebrew

关于 MacOS,`just`可以使用[Homebrew 包管理器](https://brew.sh)安装。 若还没有 Homebrew 可使用[这里](https://brew.sh)指令安装然后运行:

```
brew install just
```

### Scoop

在 Windows 上,`just`可以使用[Scoop 包管理器](https://scoop.sh)安装。 若还没有 Scoop 可使用[这里](https://scoop.sh/)指令安装然后运行:

```powershell
scoop install just
```

### Cargo

在 Windows、Linux 和 MACOS 上,`just`可使用 Cargo 安装, 它是[rust 语言 包管理器](https://www.rust-lang.org). 可使用[这里](https://www.rustup.rs)的说明书安装 Cargo，然后运行:

```
cargo install just
```

(您可能还需要添加`~/.cargo/bin`到你的`$PATH`。 如果安装后不能运行,请在 shell 配置文件中运行`export PATH="$HOME/.cargo/bin:$PATH"`)或环境变量的设置

## 让我们快速开始

在[安装](#_installation)章节中安装了`just`后。试运行`just --version`确保安装正确.

一旦`just`成功安装和工作, 在项目的根目录中，创建一个名为`justfile`的文件，具有以下内容:

```make
recipe-name:
    echo 'This is a recipe!'


# 这是一个注释
another-recipe:
    @echo 'This is another recipe.'
```

当你调用`just`，它会在当前目录和向上层目录，寻找一个`justfile`,因此您可以在项目的任何子目录调用它(它就是那么方便)。

若在没有参数的情况下运行`just`，那当你选择运行`justfile`的第一个配方(`recipe`/或者叫‘食谱’也行，反正听上去都好吃):

```sh
$ just
echo 'This is a recipe!'
This is a recipe!
```

一个或多个参数，就会指定要运行的配方(们):

```sh
$ just another-recipe
This is another recipe.
```

`just`会在运行真正命令之前,将每个命令打印到标准错误(stderr)，这就是为什么`echo 'This is a recipe!'`会被打印。当然你可以使用`@`作为行开头，这样会抑制打印。`echo 'Another recipe.'`也就没有打印。

如果命令失败,配方将停止运行。下面的`cargo publish`只在`cargo test`成功后运行:

```make
publish:
    cargo test
    # tests passed, time to publish!
    cargo publish
```

配方可以依赖其他配方。这里`test`配方依赖`build`配方,所以`build`会在`test`之前运行:

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

若是没有依赖关系的配方，将按照命令行上的顺序运行:

```sh
$ just build sloc
cc main.c foo.c bar.c -o main
1337 lines of code
```

依赖关系，总是先运行,即使它们(`build`)在依赖于它们的配方(`test`)之后传递:

```sh
$ just test build
cc main.c foo.c bar.c -o main
./test
testing... all tests passed!
```

## 特性

### 列出可用的配方

`just --list`可以列出配方:

```sh
$ just --list
Available recipes:
  build
  test
  deploy
  lint
```

`just --summary`则更简洁:

```sh
$ just --summary
build test deploy lint
```

### 文档注释

`just --list`会让配方之前的相近注释，出现:

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

### 变量和替代

变量、字符串、级联和替换，都通过使用`{{…​}}`支持:

```make
version # "0.2.7"
tardir  # "awesomesauce-" + version
tarball # tardir + ".tar.gz"

publish:
    rm -f {{tarball}}
    mkdir {{tardir}}
    cp README.md *.c {{tardir}}
    tar zcvf {{tarball}} {{tardir}}
    scp {{tarball}} me@server.com:release/
    rm -rf {{tarball}} {{tardir}}
```

#### 转义 `{{`

写一份包含`{{`的配方，要使用`{{ "{{" }}`:

```make
braces:
	echo 'I {{ "{{" }}LOVE}} curly braces!'
```

(上面 LOVE 旁边的，未闭合的`}}`会忽略,因此不需要转义).

另一个选择是把所有你想转义的文本，插入到插槽(`{{中}}`)中:

```make
braces:
	echo '{{'I {{LOVE}} curly braces!'}}'
```

### Strings

双引号字符串支持转义序列:

```make
string-with-tab             # "\t"
string-with-newline         # "\n"
string-with-carriage-return # "\r"
string-with-double-quote    # "\""
string-with-slash           # "\\"
```

```sh
$ just --evaluate
"tring-with-carriage-return # "
string-with-double-quote    # """
string-with-newline         # "
"
string-with-slash           # "\"
string-with-tab             # "     "
```

单引号字符串不识别转义序列,可能包含空格行:

```make
escapes # '\t\n\r\"\\'

line-breaks # 'hello
this
is
  a
     raw
string!
'
```

```sh
$ just --evaluate
escapes # "\t\n\r\"\\"

line-breaks # "hello
this
is
  a
     raw
string!
"
```

### 函数

只提供一些内置函数,在编写配方时可能有用.

#### 系统信息

- `arch()`- 系统指令体系结构，可能的值是:`"aarch64"`,`"arm"`,`"asmjs"`,`"hexagon"`,`"mips"`,`"msp430"`,`"powerpc"`,`"powerpc64"`,`"s390x"`,`"sparc"`,`"wasm32"`,`"x86"`,`"x86_64"`和`"xcore"`.

- `os()`- 操作系统，可能的值是:`"android"`,`"bitrig"`,`"dragonfly"`,`"emscripten"`,`"freebsd"`,`"haiku"`,`"ios"`,`"linux"`,`"macos"`,`"netbsd"`,`"openbsd"`,`"solaris"`和`"windows"`.

- `os_family()`操作系统家族; 可能的价值是:`"unix"`和`"windows"`.

例如:

```make
system-info:
	@echo "This is an {{arch()}} machine".
```

```
$ just system-info
This is an x86_64 machine
```

#### 环境变量

- `env_var(key)`-用名称`key`检索环境变量，如果不存在会中止.

- `env_var_or_default(key, default)`-用名称`key`检索环境变量，如果它不存在则返回`default`值.

#### 调用 目录

- `invocation_directory()` - 检索当前工作目录的路径, 在`just`执行命令更改它(用 chdir)之前。

例如,调用`rustfmt`只作用于"当前目录"下的文件(从用户/调用方的角度),使用以下规则:

```
rustfmt:
    find {{invocation_directory()}} -name \*.rs -exec rustfmt {} \;
```

或者,如果您的命令需要从当前目录运行,您可以使用(例如):

```
build:
    cd {{invocation_directory()}}; ./some_script_that_needs_to_be_run_from_here
```

#### Dotenv 集成

`just`将从名为`.env`文件中，加载环境变量。 此文件可以与您的 justfile 位于同一个目录中, 或是父目录。这些变量都是环境变量, 因不是`just`变量，所以在配方和反引号中必须要使用`$VARIABLE_NAME`获取。

例如,如果你`.env`文件包含:

```
# 注释，会被忽略
DATABASE_ADDRESS=localhost:6379
SERVER_PORT=1337
```

你的 justfile 包含:

```make
serve:
  @echo "Starting server with database $DATABASE_ADDRESS on port $SERVER_PORT..."
  ./server --database $DATABASE_ADDRESS --port $SERVER_PORT
```

`just serve`会输出:

```sh
$ just serve
Starting server with database localhost:6379 on port 1337...
./server --database $DATABASE_ADDRESS --port $SERVER_PORT
```

### 执行命令可使用反引号

反引号可用来存储命令的结果:

```make
localhost = `dumpinterfaces | cut -d: -f2 | sed 's/\/.*//' | sed 's/ //g'`

serve:
    ./serve {{localhost}} 8080
```

### 使用命令行工具，设置变量

变量可以通过命令行重写.

```make
os # "linux"

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

在配方之前的任意数量参数，可用过`NAME=VALUE`设置:

```sh
$ just os=plan9
./build plan9
./test --test plan9
```

或者你可以使用`--set`:

```sh
$ just --set os bsd
./build bsd
./test --test bsd
```

### 环境变量

`export`关键字会将作为环境变量，导入到配方中:

```make
export RUST_BACKTRACE # "1"

test:
    # will print a stack trace if it crashes
    cargo test
```

### 配方 参数

配方可能有参数。这里的`build`配方有一个参数叫做`target`:

```make
build target:
    @echo 'Building {{target}}...'
    cd {{target}} && make
```

其他配方可能不依赖带有参数的配方.

为了传递参数,把它们放在配方名称后面:

```sh
$ just build my-awesome-project
Building my-awesome-project...
cd my-awesome-project && make
```

参数也可具有默认值:

```make
test target tests='all':
    @echo 'Testing {{target}}:{{tests}}...'
    ./test --tests {{tests}} {{target}}
```

可以省略，具有默认值的参数:

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

配方的最后一个参数可以是变量。这在参数名称之前，用`+`表示:

```make
backup +FILES:
  scp {{FILES}} me@server.com:
```

变量参数接受一个或多个参数,并由包含空格分隔的参数字符串，扩展:

```sh
$ just backup FAQ.md GRAMMAR.md
scp FAQ.md GRAMMAR.md me@server.com:
FAQ.md                  100% 1831     1.8KB/s   00:00
GRAMMAR.md              100% 1666     1.6KB/s   00:00
```

具有默认参数的变量参数，可接受零个或多个参数:

```make
commit MESSAGE +FLAGS='':
  git commit {{FLAGS}} -m "{{MESSAGE}}"
```

`{{…​}}`替换可能需要引号,如果它们包含空格。例如,如果你有以下配方:

```make
search QUERY:
    lynx https://www.google.com/?q={{QUERY}}
```

你的类型是:

```sh
$ just search "cat toupee"
```

`Just`会运行命令`lynx [https://www.google.com/?q=cat](https://www.google.com/?q=cat) toupee`，将被`sh`解析为`lynx`,`[https://www.google.com/?q=cat](https://www.google.com/?q=cat)`和`toupee`，而不是你想的`lynx`和`[https://www.google.com/?q=cat](https://www.google.com/?q=cat) toupee`.

你可以通过添加引号来修正这个问题:

```make
search QUERY:
    lynx 'https://www.google.com/?q={{QUERY}}'
```

<!-- HERE -->

### 用其他语言来写配方

以一个`#!`开始的配方会作为脚本执行,所以你可以用其他语言编写:

```make
polyglot: python js perl sh ruby

python:
    #!/usr/bin/env python3
    print('Hello from python!')

js:
    #!/usr/bin/env node
    console.log('Greetings from justfile!')

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
Greetings from justfile!
Larry Wall says Hi!
Yo from a shell script!
Hello from ruby!
```

### 命令行选项

`just`支持许多有用的命令行选项,用于列表，倒腾和调试配方和变量:

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

运行`just --help`查看所有选项.

### 私有配方

名称以一个`_`开头的配方，`just --list`会省略:

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

`just --summary`也是:

```sh
$ just --summary
test
```

这对于配方帮手来说是有用的,因为它们只是用来作为其他配方的依赖.

### 安静配方

配方名称可以用"@"前缀,在每行之前反转"@"的含义:

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
# all done!
```

### 在其他目录调用 Justfiles

如果第一个参数传递给`just`包含一个`/`，那会发生以下情况:

1.  参数以最后一个`/`，拆分.

2.  拆分后的，前半部分被视为目录。`just`会开始在那里搜索 justfile,而不是在当前目录中搜索.

3.  后部分被当作一个普通的参数,或者，若它是空的，则被忽略.

这看起来有点奇怪,但是如果您希望运行子目录中的 justfile 中的命令,这是很有用的.

例如,如果您在包含名为`foo`子目录,其中包含一个带有`build`(也是默认配方)配方的 justfile,以下每条命令都是相等的:

```sh
$ (cd foo && just build)
$ just foo/build
$ just foo/
```

## FAQ

### make 的什么特性，just 避免了？

make 有一些混淆或复杂的行为,或者说，使它不适合用作一般的命令运行器.

一个例子是,有时 make 不会在配方中运行命令。例如,如果有一个文件叫`test`，例子如下且运行它:

```make
test:
  ./test
```

Make 实际上，会拒绝运行它:

```sh
$ make test
make: `test' is up to date.
```

Make 发觉这个`test`配方，并假定它产生一个名为`test`的文件。 然后, 该文件已存在,因此假定配方不需要运行。

公平地说,当使用 make 作为构建系统时，这种行为是可取的,但是当使用它作为命令运行程序时,则不是那么回事。

其他一些例子，包括必须理解`=`和`:=`赋值两者之间的区别，如果您(搞混)弄乱了 makefile, 混乱的错误消息就会，哼!。不得不使用`$$`编写使用环境变量的配方,以及不同口味的配方之间的不相容性.

### just 和 cargo build 脚本有一腿吗?

[Cargo build 脚本](http://doc.crates.io/build-script.html)有一个非常具体的用途,这是控制 Cargo , 正确建立你的 Rust 项目。这可能包括将命令行参数添加到`rustc`中调用,建立外部依赖,或运行某种代码生成步骤.

`just`，则控制另一方面,是开发过程中部分，需要运行的所有其他杂项命令。比如在不同的配置中运行测试、链接代码、将构建工件推送到服务器、删除临时文件等等.

而且,虽然`just`写于 Rust 语言,但它可以被使用在许多地方,而不在意你的项目使用的语言或构建系统.

## 杂记(炸鸡?)

> 好'译'名

### 搭配工具

与`just`很好搭配的工具，包括:

- [`watchexec`](https://github.com/mattgreen/watchexec)-一个简单的工具,它监视路径，并在检测到修改时，运行命令.

### Shell Alias(别名)

为了闪电般的命令运行,把`alias j=just`放在 shell 的配置文件中.

### 语法 高亮

`justfile`语法足够接近`make`，您可能希望告诉编辑器使用 make 语法高亮显示。

#### Vim

对于 Vim,您可以将以下内容放入`~/.vim/filetype.vim`:

```vimscript
if exists("did_load_filetypes")
  finish
endif

augroup filetypedetect
  au BufNewFile,BufRead Justfile,justfile setf make
augroup END
```

#### Vim 和 Emacs

在一个`justfile`中包括以下内容，能在 Vim 和 Emacs 中启用语法高亮显示:

```
# Local Variables:
# mode: makefile
# End:
# vim: set ft=make :
```

#### Visual Studio Code

VS 代码的[skellock](https://github.com/skellock)扩展是[可用的哦](https://marketplace.visualstudio.com/items?itemName=skellock.just). ([github 库](https://github.com/skellock/vscode-just))

您可以通过运行命令安装它:

```
code --install-extension skellock.just
```

#### Kakoune

Kakoune 支持`justfile`语法高亮出笼啦,感谢 TeddyDD.

#### 其他编辑器

请随时给我发送必要的命令,使语法高亮工作在您的编辑器的选择,以便我可以在这里包括他们.

### 语法

justfile 的非规范语法可以在[GRAMMAR.md](GRAMMAR.zh.md).

### just.sh

以前的`just`是一个花哨的 Rust 程序,它是一个小小的 shell 脚本,其调用`make`. 您可以在中[extras/just.sh](extras/just.sh)找到旧版本。

### 无定向项目的 Justfile

如果你想要一些命令在任何地方都可用,把它们放进去.`~/.justfile`，并将下列内容添加到 shell 初始化文件中:

```sh
alias .j='just --justfile ~/.justfile --working-directory ~'
```

或者,如果你宁愿他们运行在当前目录:

```sh
alias .j='just --justfile ~/.justfile --working-directory .'
```

我敢肯定没有人真正使用这个功能,但它在那里.

¯\\\_(ツ)\_/¯

## 进一步漫谈

我个人觉得写了`justfile`很有用，它几乎用到每一个项目,无论大小.

在一个有多个贡献者的大型项目中,拥有一个包含所有命令的文件来处理项目是非常有用的.

可能需要测试、构建、lint、部署等不同的命令,将它们全部放在一个地方很有用,并且减少了告诉人们要运行哪些命令，以及如何键入命令的时间.

而且,有了一个易于放置命令的地方,您很可能会想到其他有用的，项目集体智慧的部分东西，但智慧被集中在一起，没有到处扔，像：神秘命令需要修订控制工作流程的某些部分一样；安装所有项目的依赖项，或者您可能需要传递给构建系统的所有随机参数.

配方的一些想法:

- 部署/发布项目

- 发布模式与调试模式的构建

- 运行调试模式或启用日志记录

- 复杂的 git 工作流

- 更新依赖关系

- 运行不同的测试集,例如快速测试和完整测试,或者用详细的输出来运行它们.

- 任何复杂的命令集,如果只是为了能够记得它们,你就应该写在某个地方(当然是 justfile 啦).

即使对于小型的个人项目,能够按名称记住命令也是很好的，而不是`^反向搜索` shell 历史记录。也许在神秘(莫名其妙)的构建系统，使用未知语言编写的旧项目, 若是使用`just`，那`justfile`可是会知道您需要执行，还是想要的所有命令,这对于您来说是巨大的好处。如果你输入`just`可能会发生一些有用(或至少有趣!)的事情.

有关配方的建议,请查看[这个项目的`justfile`](justfile)或者一些`justfile`[野花](https://github.com/search?utf8=%E2%9C%93&q=filename%3Ajustfile).

无论如何,这是我认为的赞，且详细的 README 文件.

我希望你喜欢用`just`，并在您的所有计算体系工作中找到巨大的成功和满足感!

😸
