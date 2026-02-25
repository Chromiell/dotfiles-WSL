alias fastfetch="fastfetch -c ~/.config/fastfetch/fastfetch.jsonc"

if [[ -f /usr/bin/fastfetch ]]; then
    fastfetch
fi

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ~/.zshrc file for zsh interactive shells.
# see /usr/share/doc/zsh/examples/zshrc for examples

setopt autocd              # change directory just by typing its name
#setopt correct            # auto correct mistakes
setopt interactivecomments # allow comments in interactive mode
setopt magicequalsubst     # enable filename expansion for arguments of the form ‘anything=expression’
setopt nonomatch           # hide error message if there is no match for the pattern
setopt notify              # report the status of background jobs immediately
setopt numericglobsort     # sort filenames numerically when it makes sense
setopt promptsubst         # enable command substitution in prompt
setopt globdots            # lets files beginning with a . be matched without explicitly specifying the dot

# Declare global variable
typeset -g _EXECUTION_TIME_ _CMD_START_TIME

WORDCHARS=${WORDCHARS//\/} # Don't consider certain characters part of the word

# hide EOL sign ('%')
PROMPT_EOL_MARK=""

# configure key keybindings
bindkey -e                                        # emacs key bindings
bindkey ' ' magic-space                           # do history expansion on space
bindkey '^U' backward-kill-line                   # ctrl + U
bindkey '^[[3;5~' kill-word                       # ctrl + Supr
bindkey '^[[3~' delete-char                       # delete
bindkey '^[[1;5C' forward-word                    # ctrl + ->
bindkey '^[[1;5D' backward-word                   # ctrl + <-
bindkey '^[[5~' beginning-of-buffer-or-history    # page up
bindkey '^[[6~' end-of-buffer-or-history          # page down
bindkey '^[[H' beginning-of-line                  # home
bindkey '^[[F' end-of-line                        # end
bindkey '^Z' undo                                 # ctrl + z undo last action

# enable completion features
autoload -Uz compinit
compinit -d ~/.cache/zcompdump
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' rehash true
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

# History configurations
HISTFILE=~/.zhistory
HISTSIZE=10000
SAVEHIST=10000
setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups       # ignore duplicated commands history list
setopt hist_ignore_space      # ignore commands that start with space
setopt hist_verify            # show command with history expansion to user before running it
#setopt share_history         # share command history data

# force zsh to show the complete history
alias history="history 0"

# configure `time` format
TIMEFMT=$'\nreal\t%E\nuser\t%U\nsys\t%S\ncpu\t%P'

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
        # We have color support; assume it's compliant with Ecma-48
        # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
        # a case would tend to support setf rather than setaf.)
        color_prompt=yes
    else
        color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    # override default virtualenv indicator in prompt
    VIRTUAL_ENV_DISABLE_PROMPT=1

    # enable syntax-highlighting
    if [ -f ~/.config/zsh-config/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ] && [ "$color_prompt" = yes ]; then
       . ~/.config/zsh-config/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
        ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)
        ZSH_HIGHLIGHT_STYLES[default]=none
        ZSH_HIGHLIGHT_STYLES[unknown-token]=fg=red,bold
        ZSH_HIGHLIGHT_STYLES[reserved-word]=fg=cyan,bold
        ZSH_HIGHLIGHT_STYLES[suffix-alias]=fg=green,underline
        ZSH_HIGHLIGHT_STYLES[global-alias]=fg=magenta
        ZSH_HIGHLIGHT_STYLES[precommand]=fg=green,underline
        ZSH_HIGHLIGHT_STYLES[commandseparator]=fg=blue,bold
        ZSH_HIGHLIGHT_STYLES[autodirectory]=fg=green,underline
        ZSH_HIGHLIGHT_STYLES[path]=underline
        ZSH_HIGHLIGHT_STYLES[path_pathseparator]=
        ZSH_HIGHLIGHT_STYLES[path_prefix_pathseparator]=
        ZSH_HIGHLIGHT_STYLES[globbing]=fg=blue,bold
        ZSH_HIGHLIGHT_STYLES[history-expansion]=fg=blue,bold
        ZSH_HIGHLIGHT_STYLES[command-substitution]=none
        ZSH_HIGHLIGHT_STYLES[command-substitution-delimiter]=fg=magenta
        ZSH_HIGHLIGHT_STYLES[process-substitution]=none
        ZSH_HIGHLIGHT_STYLES[process-substitution-delimiter]=fg=magenta
        ZSH_HIGHLIGHT_STYLES[single-hyphen-option]=fg=magenta
        ZSH_HIGHLIGHT_STYLES[double-hyphen-option]=fg=magenta
        ZSH_HIGHLIGHT_STYLES[back-quoted-argument]=none
        ZSH_HIGHLIGHT_STYLES[back-quoted-argument-delimiter]=fg=blue,bold
        ZSH_HIGHLIGHT_STYLES[single-quoted-argument]=fg=yellow
        ZSH_HIGHLIGHT_STYLES[double-quoted-argument]=fg=yellow
        ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument]=fg=yellow
        ZSH_HIGHLIGHT_STYLES[rc-quote]=fg=magenta
        ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]=fg=magenta
        ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]=fg=magenta
        ZSH_HIGHLIGHT_STYLES[back-dollar-quoted-argument]=fg=magenta
        ZSH_HIGHLIGHT_STYLES[assign]=none
        ZSH_HIGHLIGHT_STYLES[redirection]=fg=blue,bold
        ZSH_HIGHLIGHT_STYLES[comment]=fg=black,bold
        ZSH_HIGHLIGHT_STYLES[named-fd]=none
        ZSH_HIGHLIGHT_STYLES[numeric-fd]=none
        ZSH_HIGHLIGHT_STYLES[arg0]=fg=green
        ZSH_HIGHLIGHT_STYLES[bracket-error]=fg=red,bold
        ZSH_HIGHLIGHT_STYLES[bracket-level-1]=fg=blue,bold
        ZSH_HIGHLIGHT_STYLES[bracket-level-2]=fg=green,bold
        ZSH_HIGHLIGHT_STYLES[bracket-level-3]=fg=magenta,bold
        ZSH_HIGHLIGHT_STYLES[bracket-level-4]=fg=yellow,bold
        ZSH_HIGHLIGHT_STYLES[bracket-level-5]=fg=cyan,bold
        ZSH_HIGHLIGHT_STYLES[cursor-matchingbracket]=standout
    fi
else
    PROMPT='${debian_chroot:+($debian_chroot)}%n@%m:%~%# '
fi

unset color_prompt force_color_prompt

# enable color support of ls, less and man, and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    export LS_COLORS="$LS_COLORS:ow=30;44:" # fix ls color for folders with 777 permissions

    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
    alias diff='diff --color=auto'
    alias ip='ip --color=auto'

    export LESS_TERMCAP_mb=$'\E[1;31m'     # begin blink
    export LESS_TERMCAP_md=$'\E[1;36m'     # begin bold
    export LESS_TERMCAP_me=$'\E[0m'        # reset bold/blink
    export LESS_TERMCAP_so=$'\E[01;33m'    # begin reverse video
    export LESS_TERMCAP_se=$'\E[0m'        # reset reverse video
    export LESS_TERMCAP_us=$'\E[1;32m'     # begin underline
    export LESS_TERMCAP_ue=$'\E[0m'        # reset underline

    # Take advantage of $LS_COLORS for completion as well
    zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
    zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
fi

# enable auto-suggestions based on the history
if [ -f ~/.config/zsh-config/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
    . ~/.config/zsh-config/zsh-autosuggestions/zsh-autosuggestions.zsh
    # change suggestion color
    ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#999'
fi

# enable command-not-found if installed
if [ -f /etc/zsh_command_not_found ]; then
    . /etc/zsh_command_not_found
fi

#Inizio importazione manjaro-zsh-configuration
## Options section
setopt correct                                                  # Auto correct mistakes
setopt extendedglob                                             # Extended globbing. Allows using regular expressions with *
setopt nocaseglob                                               # Case insensitive globbing
setopt rcexpandparam                                            # Array expension with parameters
setopt nocheckjobs                                              # Don't warn about running processes when exiting
setopt numericglobsort                                          # Sort filenames numerically when it makes sense
setopt nobeep                                                   # No beep
setopt appendhistory                                            # Immediately append history instead of overwriting
setopt histignorealldups                                        # If a new command is a duplicate, remove the older one
setopt autocd                                                   # if only directory path is entered, cd there.
setopt inc_append_history                                       # save commands are added to the history immediately, otherwise only when shell exits.
setopt histignorespace                                          # Don't save commands that start with space

zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'       # Case insensitive tab completion
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"         # Colored completion (different colors for dirs/files/etc)
zstyle ':completion:*' rehash true                              # automatically find new executables in path
# Speed up completions
zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache
#export EDITOR=/usr/bin/nano
#export VISUAL=/usr/bin/nano
WORDCHARS=${WORDCHARS//\/[&.;]}                                 # Don't consider certain characters part of the word


## Keybindings section
bindkey -e
bindkey '^[[7~' beginning-of-line                               # Home key
bindkey '^[[H' beginning-of-line                                # Home key
if [[ "${terminfo[khome]}" != "" ]]; then
  bindkey "${terminfo[khome]}" beginning-of-line                # [Home] - Go to beginning of line
fi
bindkey '^[[8~' end-of-line                                     # End key
bindkey '^[[F' end-of-line                                     # End key
if [[ "${terminfo[kend]}" != "" ]]; then
  bindkey "${terminfo[kend]}" end-of-line                       # [End] - Go to end of line
fi
bindkey '^[[2~' overwrite-mode                                  # Insert key
bindkey '^[[3~' delete-char                                     # Delete key
bindkey '^[[C'  forward-char                                    # Right key
bindkey '^[[D'  backward-char                                   # Left key
bindkey '^[[5~' history-beginning-search-backward               # Page up key
bindkey '^[[6~' history-beginning-search-forward                # Page down key

# Navigate words with ctrl+arrow keys
bindkey '^[Oc' forward-word                                     #
bindkey '^[Od' backward-word                                    #
bindkey '^[[1;5D' backward-word                                 #
bindkey '^[[1;5C' forward-word                                  #
bindkey '^H' backward-kill-word                                 # delete previous word with ctrl+backspace
bindkey '^[[Z' undo                                             # Shift+tab undo last action

## Alias section
alias cp="cp -i"                                                # Confirm before overwriting something
alias df='df -h'                                                # Human-readable sizes
alias free='free -m'                                            # Show sizes in MB
alias gitu='git add . && git commit && git push'

# Theming section
autoload -U compinit colors zcalc
compinit -d
colors

# Color man pages
export LESS_TERMCAP_mb=$'\E[01;32m'
export LESS_TERMCAP_md=$'\E[01;32m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;47;34m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;36m'
export LESS=-R


## Plugins section: Enable fish style features
# Use syntax highlighting
#source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.config/zsh-config/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# Use history substring search
#source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
source ~/.config/zsh-config/zsh-history-substring-search/zsh-history-substring-search.zsh
# bind UP and DOWN arrow keys to history substring search
zmodload zsh/terminfo
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# Offer to install missing package if command is not found
if [[ -r /usr/share/zsh/functions/command-not-found.zsh ]]; then
    source /usr/share/zsh/functions/command-not-found.zsh
    export PKGFILE_PROMPT_INSTALL_MISSING=1
fi

# Set terminal window and tab/icon title
#
# usage: title short_tab_title [long_window_title]
#
# See: http://www.faqs.org/docs/Linux-mini/Xterm-Title.html#ss3.1
# Fully supports screen and probably most modern xterm and rxvt
# (In screen, only short_tab_title is used)
function title {
  emulate -L zsh
  setopt prompt_subst

  [[ "$EMACS" == *term* ]] && return

  # if $2 is unset use $1 as default
  # if it is set and empty, leave it as is
  : ${2=$1}

  case "$TERM" in
    xterm*|putty*|rxvt*|konsole*|ansi|mlterm*|alacritty|st*)
      print -Pn "\e]2;${2:q}\a" # set window name
      print -Pn "\e]1;${1:q}\a" # set tab name
      ;;
    screen*|tmux*)
      print -Pn "\ek${1:q}\e\\" # set screen hardstatus
      ;;
    *)
    # Try to use terminfo to set the title
    # If the feature is available set title
    if [[ -n "$terminfo[fsl]" ]] && [[ -n "$terminfo[tsl]" ]]; then
      echoti tsl
      print -Pn "$1"
      echoti fsl
    fi
      ;;
  esac
}

ZSH_THEME_TERM_TAB_TITLE_IDLE="%15<..<%~%<<" #15 char left truncated PWD
ZSH_THEME_TERM_TITLE_IDLE="%n@%m:%~"

autoload -U add-zsh-hook

# File and Dir colors for ls and other outputs
export LS_OPTIONS='--color=always'
eval "$(dircolors -b)"
alias ls='ls $LS_OPTIONS'
alias fd='fdfind'
#Fine importazione manjaro-zsh-configuration

# Detect external pager program (prefer external `batcat`, then `bat`, else `less`)
if whence -p batcat >/dev/null 2>&1; then
    _PAGER_PROG=batcat
elif whence -p bat >/dev/null 2>&1; then
    _PAGER_PROG=bat
else
    _PAGER_PROG=less
fi

#Custom functions
# Extracts any archive(s) (if unp isn't installed)
extract() {
    for archive in "$@"; do
        if [ -f "$archive" ]; then
            case $archive in
            *.tar.bz2) tar xvjf $archive ;;
            *.tar.gz) tar xvzf $archive ;;
            *.tar.xz) tar xvJf $archive ;;
            *.bz2) bunzip2 $archive ;;
            *.rar) rar x $archive ;;
            *.gz) gunzip $archive ;;
            *.tar) tar xvf $archive ;;
            *.tbz2) tar xvjf $archive ;;
            *.tgz) tar xvzf $archive ;;
            *.zip) unzip $archive ;;
            *.Z) uncompress $archive ;;
            *.7z) 7z x $archive ;;
            *) echo "don't know how to extract '$archive'..." ;;
            esac
        else
            echo "'$archive' is not a valid file!"
        fi
    done
}

# Searches for text in all files in the current folder
# Usage: ftext <pattern> [file]
ftext() {
    if [[ -z "$1" ]]; then
        echo "Usage: ftext <pattern> [file]"
        return 1
    fi

    # If a second argument is provided and is a regular file, search only that file
    if [[ -n "$2" ]]; then
        if [[ ! -f "$2" ]]; then
            echo "File '$2' not found" >&2
            return 1
        fi

        case "${_PAGER_PROG}" in
            batcat)
                grep -iIHn --color=always -- "$1" "$2" | batcat --style=plain
                ;;
            bat)
                grep -iIHn --color=always -- "$1" "$2" | bat --style=plain
                ;;
            *)
                grep -iIHn --color=always -- "$1" "$2" | less
                ;;
        esac
        return $?
    fi

    # Otherwise, search all regular files in the current directory (non-recursive)
    case "${_PAGER_PROG}" in
        batcat)
            find . -maxdepth 1 -type f -print0 | xargs -0 -r grep -iIHn --color=always -- "$1" | batcat --style=plain
            ;;
        bat)
            find . -maxdepth 1 -type f -print0 | xargs -0 -r grep -iIHn --color=always -- "$1" | bat --style=plain
            ;;
        *)
            find . -maxdepth 1 -type f -print0 | xargs -0 -r grep -iIHn --color=always -- "$1" | less
            ;;
    esac
}

# Searches for text in all files in the current folder recursively
frtext() {
    # -i case-insensitive
    # -I ignore binary files
    # -H causes filename to be printed
    # -r recursive search
    # -n causes line number to be printed
    # optional: -F treat search term as a literal, not a regular expression
    # optional: -l only print filenames and not the matching lines ex. grep -irl "$1" *
    case "${_PAGER_PROG}" in
        batcat)
            grep -iIHRn --color=always "$1" . | batcat --style=plain
            ;;
        bat)
            grep -iIHRn --color=always "$1" . | bat --style=plain
            ;;
        *)
            grep -iIHRn --color=always "$1" . | less
            ;;
    esac
}

# Searches for a specific filename only in the current directory
ffile() {
    case "${_PAGER_PROG}" in
        batcat)
            find . -maxdepth 1 -iname "*$1*" 2>/dev/null | grep -i --color=always "$1" | batcat --style=plain
            ;;
        bat)
            find . -maxdepth 1 -iname "*$1*" 2>/dev/null | grep -i --color=always "$1" | bat --style=plain
            ;;
        *)
            find . -maxdepth 1 -iname "*$1*" 2>/dev/null | grep -i --color=always "$1" | less
            ;;
    esac
}

# Searches for a specific filename in the current directory and subdirectories
frfile() {
    case "${_PAGER_PROG}" in
        batcat)
            find . -iname "*$1*" 2>/dev/null | grep -i --color=always "$1" | batcat --style=plain
            ;;
        bat)
            find . -iname "*$1*" 2>/dev/null | grep -i --color=always "$1" | bat --style=plain
            ;;
        *)
            find . -iname "*$1*" 2>/dev/null | grep -i --color=always "$1" | less
            ;;
    esac
}

# Copy file with a progress bar
cpp() {
    rsync -avh --progress "$1" "$2"
}

# List Directories Types and icons
ld() {
    if (( $# )); then
        eza -d --group-directories-first --icons=auto "$@"
    else
        eza -D --group-directories-first --icons=auto
    fi
}

# List All Directories Types and icons
lad() {
    if (( $# )); then
        eza -ad --group-directories-first --icons=auto "$@"
    else
        eza -aD --group-directories-first --icons=auto
    fi
}

# Long Listing of Directories first Types and icons
lld() {
    if (( $# )); then
        eza -alhgd --group-directories-first --icons=auto "$@"
    else
        eza -alhgD --group-directories-first --icons=auto
    fi
}

# Long Listing of Directories with their subdirectories, with Types and icons
lltd() {
    if (( $# )); then
        eza -alhgTd --group-directories-first --icons=auto "$@"
    else
        eza -alhgTD --group-directories-first --icons=auto
    fi
}

# Long Listing of Directories, with total size and icons
llld() {
    if (( $# )); then
        eza -alhgd --group-directories-first --total-size --icons=auto "$@"
    else
        eza -alhgD --group-directories-first --total-size --icons=auto
    fi
}

# Long Listing of Directories with their subdirectories, with Types, total size and icons
llltd() {
    if (( $# )); then
        eza -alhgTd --group-directories-first --total-size --icons=auto "$@"
    else
        eza -alhgTD --group-directories-first --total-size --icons=auto
    fi
}

# Rewrite man command to use batcat instead of less
man() {
    case "${_PAGER_PROG}" in
        batcat)
            command man "$@" | col -bx | batcat --language=man --style=plain
            ;;
        bat)
            command man "$@" | col -bx | bat --language=man --style=plain
            ;;
        *)
            command man "$@" | col -bx | less
            ;;
    esac
}

# Create a file of the appropriate size
mkfile() {
    # Defaults
    local force=0
    local raw=0
    local printable=1
    local mkdirp=0
    local size_str=""
    local outfile=""

    # Parse flags
    while [[ "$1" == -* ]]; do
        case "$1" in
            -f) force=1 ;;
            -r) raw=1; printable=0 ;;   # raw bytes from urandom
            -p) mkdirp=1 ;;             # create parent dirs
            --) shift; break ;;
            *)  echo "Unknown option: $1"; return 1 ;;
        esac
        shift
    done

    # Remaining args: size + filename
    if [[ $# -ne 2 ]]; then
        echo "Usage: mkfile [-f] [-r] [-p] <size> <filename>"
        echo "  -f   overwrite existing file"
        echo "  -r   raw bytes (no printable filtering)"
        echo "  -p   create parent directories"
        return 1
    fi

    size_str="$1"
    outfile="$2"

    # Validate size format: number + unit
    if [[ ! "$size_str" =~ ^([0-9]+)([KkMmGgTt]|KiB|MiB|GiB|TiB)?$ ]]; then
        echo "Error: size must be like 100M, 1G, 50K, 500, 100MiB, 1GiB"
        return 1
    fi

    local num="${match[1]}"
    local unit="${match[2]}"

    # Convert to bytes
    local size_bytes
    case "$unit" in
        K|k)      size_bytes=$(( num * 1024 )) ;;
        M|m)      size_bytes=$(( num * 1024 * 1024 )) ;;
        G|g)      size_bytes=$(( num * 1024 * 1024 * 1024 )) ;;
        T|t)      size_bytes=$(( num * 1024 * 1024 * 1024 * 1024 )) ;;
        KiB)      size_bytes=$(( num * 1024 )) ;;
        MiB)      size_bytes=$(( num * 1024 * 1024 )) ;;
        GiB)      size_bytes=$(( num * 1024 * 1024 * 1024 )) ;;
        TiB)      size_bytes=$(( num * 1024 * 1024 * 1024 * 1024 )) ;;
        "")       size_bytes=$num ;;
    esac

    # Zero-size → touch
    if (( size_bytes == 0 )); then
        if [[ -e "$outfile" && $force -eq 0 ]]; then
            echo "Error: '$outfile' exists. Use -f to overwrite."
            return 1
        fi
        [[ $mkdirp -eq 1 ]] && mkdir -p -- "$(dirname -- "$outfile")"
        touch "$outfile"
        return 0
    fi

    # Safety: prevent overwriting unless -f
    if [[ -e "$outfile" && $force -eq 0 ]]; then
        echo "Error: '$outfile' exists. Use -f to overwrite."
        return 1
    fi

    # Create parent directories if requested
    if [[ $mkdirp -eq 1 ]]; then
        mkdir -p -- "$(dirname -- "$outfile")"
    fi

    # Choose data source
    local cmd
    if (( raw == 1 )); then
        cmd="cat /dev/urandom"
    else
        cmd="tr -dc '[:alnum:]' < /dev/urandom"
    fi

    # Progress indicator for large files
    local start_time=$SECONDS
    echo "Creating file '$outfile' (${size_bytes} bytes)..."

    # Use pv if available for progress
    if command -v pv >/dev/null 2>&1; then
        eval "$cmd" | pv -s "$size_bytes" | head -c "$size_bytes" > "$outfile"
    else
        # Fallback: no progress bar
        eval "$cmd" | head -c "$size_bytes" > "$outfile"
    fi

    local elapsed=$(( SECONDS - start_time ))
    echo "Done in ${elapsed}s"
}

export GEMINI_MODEL="gemini-3-pro"
export EDITOR="micro"

source <(fzf --zsh)

# some more ls aliases
#alias ll='ls -l'
alias l='eza --group-directories-first --icons=auto'
alias la='eza -a --group-directories-first --icons=auto'
alias ll="eza -alhg --group-directories-first --icons=auto"
alias llt="eza -alhgT --group-directories-first --icons=auto"
alias lll="eza -alhg --group-directories-first --total-size --icons=auto"
alias lllt="eza -alhgT --group-directories-first --total-size --icons=auto"
alias ff="fzf --style full --border --padding 1,2 --border-label ' FuzzyFind ' --input-label ' Input ' --header-label ' File Type ' --preview '~/.config/fzf/fzf-preview.sh {}' --bind 'result:transform-list-label: if [[ -z $FZF_QUERY ]]; then echo \" $FZF_MATCH_COUNT items \" else echo \" $FZF_MATCH_COUNT matches for [$FZF_QUERY] \" fi' --bind 'focus:transform-preview-label:[[ -n {} ]] && printf \" Previewing [%s] \" {}' --bind 'focus:+transform-header:file --brief {} || echo \"No file selected\"' --bind 'ctrl-r:change-list-label( Reloading the list )+reload(sleep 2; git ls-files)' --color 'border:#aaaaaa,label:#cccccc' --color 'preview-border:#9999cc,preview-label:#ccccff' --color 'list-border:#669966,list-label:#99cc99' --color 'input-border:#996666,input-label:#ffcccc' --color 'header-border:#6699cc,header-label:#99ccff'"
alias "cd.."="cd .."
alias subl="/mnt/c/Program\ Files/Sublime\ Text/sublime_text.exe"

if whence -p batcat >/dev/null 2>&1; then
    alias bat="batcat --paging=never"
    alias batcatt="batcat --style=plain"
    alias batt="batcat -pp"
elif whence -p bat >/dev/null 2>&1; then
    alias bat="bat --paging=never"
    alias batcatt="bat --style=plain"
    alias batcat="bat"
    alias batt="bat -pp"
fi

source ~/.config/zsh-config/powerlevel10k/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.config/zsh-config/powerlevel10k/.p10k.zsh.
[[ ! -f ~/.config/zsh-config/powerlevel10k/.p10k.zsh ]] || source ~/.config/zsh-config/powerlevel10k/.p10k.zsh

# Required by VSCode's agents terminal integration with Zsh
[[ "$TERM_PROGRAM" == "vscode" ]] && . "$(code --locate-shell-integration-path zsh)"

# Load any additional configuration options for the specific user
[[ ! -f ~/.zshadditions ]] || source ~/.zshadditions
