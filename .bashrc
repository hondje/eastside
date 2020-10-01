###############################################################################
#		                    Tomm's ~/.bashrc          					      #
###############################################################################
# ~/.bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PS1='[\u@\h \W]\$ '


###############################################################################
#		                    shopt and set shell       					      #
###############################################################################
# 
shopt -s autocd         # if I forget to put cd before a path, it'll cd anyways
shopt -s cdable_vars    # Pass a variable to cd with a path inside
# 
shopt -s cdspell        # Minor typos are ignored
shopt -s dirspell       # Minor typos are ignored
# 
# shopt -s checkhash      # Check that a cmd found in hashtable actually exists
# shopt -s checkjobs      # have to exit and then exit again if jobs are in bg
# 
# shopt -s checkwinsize   # Help SIGWINCH out
# shopt -s direxpand      # replace dir name in readline buffer
# 
# shopt -s huponexit      # Send SIGHUP to all jobs if login leaves
shopt -s nocasematch    # Not so case-sensitive, are we?
# 
# # GLOBS! 
# shopt -s dotglob        # HIDDEN
shopt -s extglob        # EXTRASPECIAL
# shopt -s failglob       
shopt -s globstar       # USE **
shopt -s nocaseglob     # Case-insensitive globbing
# shopt -s nullglob       # patterns w/out match expand to nullstr

# HISTORY 
shopt -s histappend     # Append, don't clobber the damn history!!
shopt -s histreedit     # Try failed hist expansion again
shopt -s histverify     # This one is why !! needs <CR>
shopt -s cmdhist        # Save multi-line commands in same history entry
shopt -s lithist        # save with \n instead of ; when possible

# Disable completion when the input buffer is empty.  i.e. Hitting tab
# and waiting a long time for bash to expand all of $PATH.
shopt -s no_empty_cmd_completion

shopt -s hostcomplete

###############################################################################
#		                   ALIASES                   					      #
###############################################################################

###     Alias to be lazy with options
alias sudo='sudo '
alias vb="vim ~/.bashrc"
alias vbb="source ~/.bashrc"
alias vba="vim ~/.bash_alias"

alias lslxc='lxc list -c ns46,volatile.eth0.hwaddr:MAC,config:image.os,devices:eth0.parent:ETHP | xcolorize red STOPPED green RUNNING fawn "[[:digit:]]+\.[[:digit:]]+\.[[:digit:]]+\.[[:digit:]]+" fawn "(eth.)" darkcyan "(\-|\+|\|)" pink "(NAME|STATE|IPV4|DISTRO|IPV6|MAC|IMAGE OS|ETHP)" red "[[:alnum:]]+\:[[:alnum:]]+\:[[:alnum:]]+\:[[:alnum:]]+\:[[:alnum:]]+\:[[:alnum:]]+\:[[:alnum:]]+\:[[:alnum:]]+"'

###############################################################################
#                                 LESS                                        #
###############################################################################

# export LESSOPEN="| /usr/bin/source-highlight-esc.sh %s"
# export LESS='-i -N -w  -z-4 -g -e -M -X -F -R -P%t?f%f \
# :stdin .?pb%pb\%:?lbLine %lb:?bbByte %bb:-...'
export LESSOPEN="| /usr/share/source-highlight/src-hilite-lesspipe.sh %s"
export LESS=' -R '
export LESS_TERMCAP_mb=$'\E[1;31m'     # begin bold
export LESS_TERMCAP_md=$'\E[1;36m'     # begin blink
export LESS_TERMCAP_me=$'\E[0m'        # reset bold/blink
export LESS_TERMCAP_so=$'\E[01;44;33m' # begin reverse video
export LESS_TERMCAP_se=$'\E[0m'        # reset reverse video
export LESS_TERMCAP_us=$'\E[1;32m'     # begin underline
export LESS_TERMCAP_ue=$'\E[0m'        # reset underline


###############################################################################
#                               ENVIRONMENT                                   #
###############################################################################


# export FIGNORE="" 

#  Set LS_COLORS just incase
#  eval "$(dircolors -b)"
export LS_COLORS="$(vivid generate molokai)"

export HH_CONFIG=hicolor
export HSTR_CONFIG="hicolor,help-on-opposite-side,raw-history-view,no-confirm,warning"

export PATH=$PATH:/home/hondje/.local/bin
export PATH=$PATH:/home/hondje/.cargo/bin

export EDITOR="vim"
export PAGER="less"
export BROWSER="firefox"
export VISUAL="$EDITOR"
export SYSTEMD_EDITOR="nano --syntax=sh -l -m -i -T4"
# export SYSTEMD_EDITOR="$EDITOR"
export SYSTEMD_PAGER="less"
export SYSTEMD_LESS="FRSXMK"
export SYSTEMD_COLORS="true"
export SYSTEMD_LOG_COLOR="true"
export IGNOREEOF="2"
stty stop ""
export S_COLORS="always"
export PROMPT_DIRTRIM=2                         # Trim long paths in prompt

export WG_HIDE_KEYS="never"

# Save each command to the history file as it's executed.  
export PROMPT_COMMAND='history -a'
# export PROMPT_COMMAND="history -a; history -n; ${PROMPT_COMMAND}"
export HISTCONTROL=erasedups:ignoreboth
export HISTFILESIZE=20000
export HISTSIZE=20000
export HISTIGNORE="&:[ ]*:exit:ls:bg:fg:history:clear"

if [[ $- =~ .*i.* ]]; then
    bind '"\C-r": "\C-a hh -- \C-j"';
    bind Space:magic-space;
fi

run-help() { help "$READLINE_LINE" 2>/dev/null || man "$READLINE_LINE"; }
bind -m vi-insert -x '"\eh": run-help'
bind -m emacs -x '"\eh": run-help'
###############################################################################
#                                                                      aic
###############################################################################
function hhh() {

cat <<-EOF
----------------------------------------------------
ctrl-e              toggle regex
ctrl-t              toggle case sensitive
ctrl-/,ctrl-7       rotate view
ctrl-f              add current selection to favs
ctrl-l              make pattern lower/upper case
ctrl-r, up, down
ctrl-n, ctrl-p      navigate history
ctrl-j, ctrl-k
tab,right           choose+readline
left                choose+edit
enter               choose and run
del                 remove sel from hist
ctrl-u,ctrl-w       del pattern and try again
ctrl-x              write changes and exit
ctrl-g              exit
----------------------------------------------------
EOF
}

###############################################################################
#                               Source?                                       #
###############################################################################
if [ "$TERM" = linux ]; then
	setfont	Uni3-TerminusBold20x10.psf.gz
fi

#     source /usr/bin/liquidprompt
# else
#     source /usr/bin/liquidprompt
#     source <( kitty + complete setup bash )
# fi

[ -r /usr/share/bash-completion/bash_completion   ] && . /usr/share/bash-completion/bash_completion
# source /usr/share/bash-completion/completions/lxd complete -F __lxc_complete lxc

[[ $- = *i* ]] && source ~/.bash_alias
# [[ $- = *i* ]] && source /usr/bin/liquidprompt
# source /usr/share/liquidprompt/liquidprompt
#!/bin/bash
# Simple colorize for bash by means of sed
#
# Copyright 2008-2015 by Andreas Schamanek <andreas@schamanek.net>
#
# 2017 - Modified from mycolorize into a shell function 
#     by Ignacio Nunez Hernanz <nacho _a_t_ ownyourbits _d_o_t_ com>
#
# GPL licensed (see end of file) * Use at your own risk!
#
# Usage examples:
#   tail -f somemaillog | xcolorize white '^From: .*' bell
#   tail -f somemaillog | xcolorize white '^From: \/.*' green 'Folder: .*'
#   tail -f somemaillog | xcolorize --unbuffered white '^From: .*'
#
# Notes:
#   Regular expressions need to be suitable for _sed --regexp-extended_
#   Slashes / need no escaping (we use ^A as delimiter).
#   \/ splits the coloring (similar to procmailrc. Matches behind get color.
#   Even "white '(for|to) \/(her|him).*$'" works :) Surprisingly ;)
#   To color the string '\/' use the regular expression '\\()/'.
#   If the 1st argument is -u or --unbuffered, _sed_ will be run so.

# For the colors see tput(1) and terminfo(5), or e.g.
# https://wiki.archlinux.org/index.php/Color_Bash_Prompt
# and http://stackoverflow.com/a/20983251/196133

function xcolorize()
{
  local bold=$(tput bold)                         # make colors bold/bright
  local normal=$'\e[0m'                           # (works better sometimes)

  local red="$bold$(tput setaf 1)"                # bright red text
  local green=$(tput setaf 2)                     # dim green text
  local fawn=$(tput setaf 3); beige="$fawn"       # dark yellow text
  local yellow="$bold$fawn"                       # bright yellow text
  local darkblue=$(tput setaf 4)                  # dim blue text
  local blue="$bold$darkblue"                     # bright blue text
  local purple=$(tput setaf 5); magenta="$purple" # magenta text
  local pink="$bold$purple"                       # bright magenta text
  local darkcyan=$(tput setaf 6)                  # dim cyan text
  local cyan="$bold$darkcyan"                     # bright cyan text
  local gray=$(tput setaf 7)                      # dim white text
  local darkgray="$bold"$(tput setaf 0)           # bold black = dark gray text
  local white="$bold$gray"                        # bright white text

  local bell=$(tput bel)                          # bell/beep
  local y=0

  # Make output unbuffered? (Pass argument -u|--unbuffered to _sed_.)
  if [ "/$1/" = '/-u/' -o "/$1/" = '/--unbuffered/' ] ; then
    local UNBUFFERED='-u'; shift
  else
    local UNBUFFERED=""
  fi

  # produce separator character ^A (for _sed_)
  local A=$(echo | tr '\012' '\001')

  # compile all rules given at command line to 1 set of rules for SED
  while [ "/$1/" != '//' ] ; do
    local c1=''; local re='';  local beep=''
    c1=$1 ; re="$2" ; shift 2 || break
    # if a beep is requested in the optional 3rd parameter set $beep
    [ "/$1/" != '//' ] && [[ ( "$1" = 'bell' || "$1" = 'beep' ) ]] \
      && beep=$bell && shift
    # if the regular expression includes \/ we split the substitution
    if [ "/${re/*\\\/*/}/" = '//' ] ; then
      # we need to count "("s before the \/ (=$left)
      local left="${re%\\/*}"; local leftlength=${#left}
      # first we count "\("
      local dummy=${left//\\(}; escdgroups=$(( (leftlength-${#dummy})/2 ))
      # now "(" (and we add 2 for the groups used for ($re) in $sedrules)
      local dummy=${left//(}; groupcnt=$((leftlength-${#dummy}-escdgroups+2))
      # replace \/ with )( so below we get (left-re)(right-re)
      re="${re/\\\//)(}"
      local sedrules="$sedrules;s$A($re)$A\1${!c1}\\$groupcnt$beep$normal${A}g"
      sedrules="${sedrules}I"   # add case insensitive
    else
      local sedrules="$sedrules;s$A($re)$A${!c1}\1$beep$normal${A}g"
      sedrules="${sedrules}I"   # add case insensitive
    fi
    # limit parsing of arguments
    (( y++ && y>888 )) && { echo "$0: too many arguments" >&2; return 1; }
  done

  # call sed to do the main job
  sed $UNBUFFERED --regexp-extended -e "$sedrules"

  return
}

# Colorize your standard output using xcolorize with a grep-like usage
#
# Copyleft 2017 by Ignacio Nunez Hernanz <nacho _a_t_ ownyourbits _d_o_t_ com>
# GPL licensed (see end of file) * Use at your own risk!
#
# Usage piping from stdin:
#   mount | xcol mnt "sda." "sdb." cgroup tmpfs proc
#
# Usage reading from a file:
#   xcol pae fpu vme mhz sse2 cache cores /proc/cpuinfo
#
# Notes:
#   It supports sed compatible regular expressions
function xcol()
{
  local bold=$(tput bold)                         # make colors bold/bright
  local red="$bold$(tput setaf 1)"                # bright red text
  local green=$(tput setaf 2)                     # dim green text
  local fawn=$(tput setaf 3); beige="$fawn"       # dark yellow text
  local yellow="$bold$fawn"                       # bright yellow text
  local darkblue=$(tput setaf 4)                  # dim blue text
  local blue="$bold$darkblue"                     # bright blue text
  local purple=$(tput setaf 5); magenta="$purple" # magenta text
  local pink="$bold$purple"                       # bright magenta text
  local darkcyan=$(tput setaf 6)                  # dim cyan text
  local cyan="$bold$darkcyan"                     # bright cyan text
  local gray=$(tput setaf 7)                      # dim white text
  local darkgray="$bold"$(tput setaf 0)           # bold black = dark gray text
  local white="$bold$gray"                        # bright white text

  local COLS=( white yellow red cyan gray purple pink fawn )

  [ -t 0 ] && local STDIN=0 || local STDIN=1

  if [[ $STDIN == 0 ]]; then 
    local ARGVS=${@: 1 : $#-1 }                   # all arguments except last one
    local FILE=${@: -1}                           # last argument is the file name
  else
    local ARGVS=$@;
  fi

  local IDX=1                                     # rotate colors in a cycle
  for arg in ${ARGVS[@]}; do
    local ARGS=( ${ARGS[@]} ${COLS[$IDX]} $arg )
    IDX=$(( IDX + 1 )) 
    [[ $IDX == ${#COLS[@]} ]] && IDX=1
  done
  [[ $STDIN == 1 ]] && {
    xcolorize --unbuffered ${ARGS[@]}
    } || {
    cat $FILE | xcolorize --unbuffered ${ARGS[@]}
  }
}
# License
#
# This script is free software; you can redistribute it and/or modify it
# under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This script is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this script; if not, write to the
# Free Software Foundation, Inc., 59 Temple Place, Suite 330,
# Boston, MA  02111-1307  USA

# HSTR configuration - add this to ~/.bashrc
alias hh=hstr                    # hh to be alias for hstr
export HSTR_CONFIG=hicolor       # get more colors
shopt -s histappend              # append new history items to .bash_history
export HISTCONTROL=ignorespace   # leading space hides commands from history
export HISTFILESIZE=10000        # increase history file size (default is 500)
export HISTSIZE=${HISTFILESIZE}  # increase history size (default is 500)
# ensure synchronization between bash memory and history file
export PROMPT_COMMAND="history -a; history -n; ${PROMPT_COMMAND}"
# if this is interactive shell, then bind hstr to Ctrl-r (for Vi mode check doc)
if [[ $- =~ .*i.* ]]; then bind '"\C-r": "\C-a hstr -- \C-j"'; fi
# if this is interactive shell, then bind 'kill last command' to Ctrl-x k
if [[ $- =~ .*i.* ]]; then bind '"\C-xk": "\C-a hstr -k \C-j"'; fi

alias git-pull-all="find . -maxdepth 3 -name .git -type d | rev | cut -c 6- | rev | xargs -I {} git -C {} pull"

## # Only load liquidprompt in interactive shells, not from a script or from scp
## # echo $- | grep -q i 2>/dev/null && . /usr/share/liquidprompt/liquidprompt
## 
## # Powerline
## if [ -f 'which powerline-daemon' ]; then
## powerline-daemon -q
## POWERLINE_BASH_CONTINUATION=1
## POWERLINE_BASH_SELECT=1
## fi
## if [ -f /usr/share/powerline/bindings/bash/powerline.sh ]; then
## source /usr/share/powerline/bindings/bash/powerline.sh
## fi
## 
## # Only load liquidprompt in interactive shells, not from a script or from scp
## # echo $- | grep -q i 2>/dev/null && . /usr/share/liquidprompt/liquidprompt

eval "$(starship init bash)"
