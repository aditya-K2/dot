autoload -U colors && colors

# Enable this for profiling
# E_ZPROF="true"

! [[ -z $E_ZPROF ]] && zmodload zsh/zprof

setopt HIST_SAVE_NO_DUPS

HISTSIZE=100000
SAVEHIST=100000
HISTORY_DIR="$HOME/.cache/zsh/"
HISTFILE=$HISTORY_DIR/history
_FZF_HEIGHT_=7
_FZF_OPTIONS_="--border=none --info=hidden --color=light --reverse"

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
# Include hidden files.
_comp_options+=(globdots)

# vi mode
bindkey -v

source "$HOME/env.sh"
source "$HOME/alias.sh"

#-(Create files/folders that don't exist but are required )-------------------

# Z script
Z_SH_PATH="$HOME/z.sh"
Z_SH_LINK="https://raw.githubusercontent.com/rupa/z/master/z.sh"
! [[ -r "$Z_SH_PATH" ]] \
    && wget "$Z_SH_LINK" -O "$Z_SH_PATH" \
    || source "$Z_SH_PATH"

# Create directories that don't exist
! [[ -d "$HISTORY_DIR" ]] && mkdir "$HISTORY_DIR"
! [[ -d "$VENV_DIR" ]] && mkdir "$VENV_DIR"
! [[ -d "$CODE_DIR" ]] && mkdir "$CODE_DIR"
! [[ -d "$NOTES_DIR" ]] && mkdir "$NOTES_DIR"

# Node Version Manager
export NVM_DIR="$HOME/.nvm"
! [[ -r "$NVM_DIR" ]] \
    && curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash \
    && nvm install "20.11.0"

#-----------------------------------------------------------------------------

export KEYTIMEOUT=1

# Key Bindings

bindkey '^H' backward-kill-word
# Use nvim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char
bindkey '^R' history-incremental-search-backward

# Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}

zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

fd_command() {
    command -v fd 1>/dev/null 2>/dev/null && printf "fd" || printf "fdfind"
    printf " --color=never"
}

# Setting fd as the default source for fzf (respects .gitignore)
export FZF_DEFAULT_COMMAND="$(fd_command) --type f --strip-cwd-prefix"

__fzfcmd() {
    printf "fzf --height $_FZF_HEIGHT_ $_FZF_OPTIONS_"
}

__rg_cmd() {
    printf "rg --column --line-number --hidden --ignore-case --no-heading ."
}

__dmenucmd() {
    printf "dmenu -i -f -l 10"
}

############

compdef __confCompletions conf
function __confCompletions(){
    _arguments -C \
        "1: :($(ls $HOME/.config))" \
        "2: :($(ls $HOME/.config))"
}

compdef __venvCompletions venv
function __venvCompletions(){
    _arguments -C \
        "1: :(new remove source -f)" \
        "2: :($(ls $VENV_DIR))"
}

compdef __ccoCompletions cco
function __ccoCompletions(){
    _arguments -C \
        "1: :($(ls $CODE_DIR))" \
        "2: :($(ls $CODE_DIR))"
}

compdef __noteCompletions note
function __noteCompletions(){
    _arguments -C \
        "1: :($(ls $NOTES_DIR/*.md | awk -F/ '{print $NF}'))"
}

# functions
venv() {
    case "$1" in
        "new")
            [[ "$2" != "" ]] && virtualenv "$VENV_DIR/$2" &&
                source "$VENV_DIR/$2/bin/activate"||
                printf "Empty Name Provided!"
            ;;
        "remove")
            [[ "$2" != "" ]] && \rm -rf "$VENV_DIR/$2" &&
                printf "Removed $2 Succesfully!" ||
                printf "Empty Name Provided!"
            ;;
        "-f")
            local sel="$( ls $VENV_DIR | $(__fzfcmd) )"
            [[ "$sel" != "" ]] && source "$VENV_DIR/$sel/bin/activate"
            ;;
        "source")
            source "$VENV_DIR/$2/bin/activate"
            ;;
    esac
}

tl() {
    local _session="$(tmux list-sessions | $(__fzfcmd) | awk -F: '{print $1}')"
    [[ "$_session" != "" ]] && tmux attach-session -t $_session
}

all_content() {
    du -a /random/RTDownloads /F/FTDownloads | grep ".m[k,p][v,4]$" | awk -F'\t' '{print $2}'
}

bh() {
    setopt local_options BASH_REMATCH
    __sel="$(brow -q "title,url" -c | $(__fzfcmd))"
    [[ "$__sel" =~ http.*$ ]] && echo "$BASH_REMATCH" | xargs -r -d '\n' brave
}

program() {
    if [[ "$1" == "-d" ]]; then
        printf "__dmenucmd"
    else
        printf "__fzfcmd"
    fi
}

mpvf(){
    local __sel="$(all_content | $($(program "$1" )))"
    [[ "$1" == "-p" ]] &&
        __openCmd="pcmanfm" __sel="`dirname "$__sel"`" ||
        __openCmd="mpv"
    printf "$__sel" | xargs -r -d '\n' $__openCmd
}

note(){
    if [[ "$1" == "-d" ]]; then
        nvim $NOTES_DIR/$(date "+%a_%d_%b.md")
    elif [[ "$1" == "-f" ]]; then
        all_files $NOTES_DIR | $(__fzfcmd) | xargs -r -d '\n' $EDITOR
    elif [[ "$1" == "-g" ]]; then
        cd $NOTES_DIR
    elif [[ "$1" != "" ]]; then
        nvim $NOTES_DIR/"$1"
    fi
}

extract(){
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1   ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *.deb)       ar x $1      ;;
      *.tar.xz)    tar xf $1    ;;
      *.tar.zst)   unzstd $1    ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

sc(){
    if [[ "$1" == "-m" ]]; then
        fileName=$2
        echo "#!/bin/sh" > $HOME/scripts/$fileName &&
        chmod +x $HOME/scripts/$fileName &&
        nvim $HOME/scripts/$fileName
    elif [[ "$1" == "-g" ]]; then
        cd $HOME/scripts/
    else
        all_files $HOME/scripts | $(__fzfcmd) | xargs -r -d '\n' $EDITOR
    fi
}

lzf(){
    locate "$1" | $(__fzfcmd)
}

fg(){
    optionS=$($(__rg_cmd) | $(__fzfcmd) | awk '{print $1}' | awk -F ":" '{print $1 "-" $2}')
    if [[ "$optionS" != "" ]]; then
        nvim ${optionS%-*} -c "normal ${optionS#*-}Gzz"
    fi
}

cco(){
    if [[ "$1" == "-m" ]];  then
        printf "Making Directory $2\n"
        mkdir "$CODE_DIR/$2"
        printf "Changing Directory to $2\n"
        cd "$CODE_DIR/$2"
    elif [[ "$1" == "-f" ]];  then
        dir=$(ls $CODE_DIR/ | $(__fzfcmd) )
        cd "$CODE_DIR/$dir"
    elif [[ "$1" == "-rm" || "$1" == "rm"  ]];  then
        \rm -ivr "$CODE_DIR/$2"
    elif [[ "$1" == "-c" ]]; then
        cd $CODE_DIR/$2
    else
        f="$1"
        shift 1>/dev/null 2>/dev/null
        z $CODE_DIR/$f $@
    fi
}

ez(){
    local file="$(cat ~/.zshrc -n | $(__fzfcmd))"
    [[ "$file" != "" ]] && (
        local line_nr="$(awk '{print $1}' <<< "$file")"
        local line="$(awk -F$line_nr '{print $2}' <<< "$file")"
        grep "source" <<< "$line" &&
            nvim "$(envsubst <<< $(awk -F\" '{print $2}' <<< "$line" | sed "s/\ //g"))" ||
        (nvim -c "$(printf "normal %sGzz" $line_nr)" ~/.zshrc))
}

asmc(){
    nasm -f elf64 -o "/tmp/${1%.asm}.o" "$1" &&
    ld "/tmp/${1%.asm}.o" -o "/tmp/${1%.asm}" &&
    "/tmp/${1%.asm}"
}

fs(){
    $(__fzfcmd) | xargs -r -d '\n' $EDITOR
}

all_files(){
    $(printf "$(fd_command) . $1")
}

conf(){
    local dir="NOT SET"
    # Args
    for i in "$@"
    do
        if [[ "$i" == "-g" ]]; then
            local GO_TO_DIR=1
        else
            local dir="$i"
        fi
    done

    # Dir
    if [[ "$dir" == "NOT SET" ]]; then
        local dir=$(ls $HOME/.config/ | $(__fzfcmd) )
    fi

    if [[ "$GO_TO_DIR" == "1" ]]; then
        cd ~/.config/$dir
    else
        nvim ~/.config/$dir
    fi
}

fn(){
    all_files "$HOME/.config/nvim/" | $(__fzfcmd) | xargs -r -d '\n' $EDITOR
}

envm() {
    # Node Version Manager
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
}

# Prompt Starts

local BRANCH_COLOR=red
local PROMPT_COLOR=yellow
local FILE_COLOR=blue

## autoload vcs and colors
autoload -Uz vcs_info
autoload -U colors && colors

# enable only git
zstyle ':vcs_info:*' enable git

# setup a hook that runs before every ptompt.
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst

zstyle ':vcs_info:git:*' formats " %B%{$fg[$BRANCH_COLOR]%}%b"

PROMPT="%{$fg[$FILE_COLOR]%}%B%2~"
PROMPT+="\$vcs_info_msg_0_ % %{$fg[$PROMPT_COLOR]%}%% %{$reset_color%}"

# Prompt Ends

! [[ -z $E_ZPROF ]] && zprof > ~/zsh.log
