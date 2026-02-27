---
title: My Basic Shell Setup
date: '2021-01-03 15:24:40'
layout: post
categories:
- Computers
tags: []
author: mlilback
---
I started using *nix and programming in the early nineties. There were no helpers around, so I manually learned to do everything by hand. Same with HTML, or anything else on the Internet[^1]. 

Up until this weekend, I was using bash with profile lines dating back close to 30 years[^2]. My .bash_profile was a hot mess of stuff that I didn't understand.

Now that I've updated them all, I want to document my config files so future me (and interested others) can understand them.

## The files

I'd always hated the distinction between `.bashrc` and `.bash_profile`, and had the first just source the second. While switching to zsh, I decided to follow expected patterns.

Now I'm using `.zshenv` for environment variables, and `.zshrc` for interactive shells. This document will also cover what was in `.exrc`, as this was the first file I setup on any *nix system[^3].

To start with, I'm using [Oh My Zsh](https://ohmyz.sh/) because it makes zsh configuration easy and powerful.

### .zshenv

{% highlight zsh linenos %}
export LC_TYPE=en_US.UTF-8
export LANG=en_US.UTF-8
export GOPATH=$HOME/.go
export LESS=-eqFXMwn4
{% endhighlight %}

* lines 1-2 tell programs to use english utf-8 encoding

* line 3 tells the go tools to use a hidden directory. Default is to make a directory `~/go` which I do not want cluttering up my home

* line 4 sets options for LESS:

	| e | automatically when read EOF for second time (so space at EOF will exit) |
	| q | minimize ringing of the terminal bell |
	| F | scroll forward reading additional content (ala `tail -f`) |
	| X | disables termcap support, so page-up/down scroll the terminal buffer, not the less buffer |
	| M | prompt shows file name, location in file, and percent shown so far |
	| w | highlights first line after scroll to help keep your place|
	| n | don't show line numbers |
	| 4 | # characters to scroll horizontally |
	{: .defs}
{: .detail}

### .zshrc

{% highlight zsh linenos %}
ZSH_THEME="aussiegeek"

plugins=(git colored-man-pages copydir copyfile dash docker kubectl mvn per-directory-history safe-paste)

# copydir copies path to clipboard
# copyfile copies contents of specified file to clipboard
# safe-paste prevents a paste from actually executing what was pasted so you can always review
# docker, kubectl, mvn all offer autocomplete support

source $ZSH/oh-my-zsh.sh

alias dcurl="curl --unix-socket /var/run/docker.sock"

export CLASSPATH="/usr/local/antlr.jar:$CLASSPATH"
alias antlr4="java -Xmx500M org.antlr.v4.Tool"
alias grun="java -Xmx500M org.antlr.v4.gui.TestRig"

for envenv ('plenv' 'rbenv' 'nodenv' 'swiftenv'); 
  do
    if which $envenv > /dev/null; then eval "$($envenv init -)"; fi
done

# allow docker autocompletion so (docker -it <TAB>) will work
zstyle ':completion:*:*:docker:*' option-stacking yes
zstyle ':completion:*:*:docker-*:*' option-stacking yes
{% endhighlight %}

* line 1: the [theme](https://github.com/ohmyzsh/ohmyzsh/wiki/Themes) I picked

* line 3: the [plugins](https://github.com/ohmyzsh/ohmyzsh/wiki/Plugins) I'm using. There is a performance penalty at plugin load time, but I'm fine with the delay from these on my iMac.

	| [git](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/git) | Using to show the branch I'm on. No plan to use the aliases. |
	| [colored-man-pages](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/colored-man-pages) | makes man pages much easier to read |
	| [copydir](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/copydir) | alias to copy `pwd` to the clipboard | 
	| [copyfile](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/copyfile) | alias to copy specified file contents to clipboard | 
	| [dash](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/dash) | Lets me query [Dash](https://kapeli.com/dash) from the command line e.g. `dash swift:string` | 
	| [docker](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/docker) | forget the aliases, autocomplete for image/container names makes all these changes worthwhile | 
	| [kubectl]((https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/kubectl)) | same rational as docker, especially since there are so many subcommands | 
	| [mvn]((https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/mvn)) | once again, autocompletion for java development | 
	| [per-directory-history](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/per-directory-history) | I rarely need autocomplete outside the directory I used it in | 
	| [safe-paste](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/safe-paste) | when you paste to the command line, the command will not execute always giving you the chance to edit it | 
	{: .defs}

* line 10: include [Oh My Zsh](https://ohmyz.sh/) 

* line 12: I've spent a lot of time testing rest calls to the docker API, and this is how to do it

* lines 14-16: enable use of [ANTLR](https://www.antlr.org) code generation

* lines 18-21: I use tool wrappers to manage what version of the runtime environment I'm using. If installed, [Perl](https://github.com/tokuhirom/plenv), [Ruby](https://github.com/rbenv/rbenv), [Node/JavaScript](https://github.com/nodenv/nodenv), and [Swift](https://github.com/kylef/swiftenv) the ability to specify exactly what version to use. I wouldn't develop in any of these languages without this. 

* lines 23-25: required so docker plugin will autocomplete argument values and container/image names
{: .detail}


[^1]: If it was available in the nineties, I probably worked with it. (e.g. sendmail, bind, httpd, cgi-lib.pl, miniSQL before Monty started work on MySQL, building a complicated website on an IRIX server in Brazil using the country's shared 56K connection)

[^2]: I started with ksh, quickly moved to zsh for autocompletion and command history (and was available on the compsci servers).

[^3]: To adjust vi tabspaces=4.
