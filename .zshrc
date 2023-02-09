autoload -U colors && colors

# History in cache directory:
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.cache/zsh/history

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)        # Include hidden files.

# vi mode
bindkey -v

export KEYTIMEOUT=1
source "$HOME/env.sh"

# Key Bindings

bindkey '^H' backward-kill-word
# Use nvim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

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

# Use fzf for Reverse Searching History
__fzfcmd() {
    printf "fzf --height 10"
}

__dmenucmd() {
    printf "dmenu -i -f -l 10"
}

# CTRL-R - Paste the selected command from history into the command line
fzf-history-widget() {
  local selected num
  setopt localoptions noglobsubst noposixbuiltins pipefail no_aliases 2> /dev/null
  selected=( $(fc -rl 1 | awk '{ cmd=$0; sub(/^[ \t]*[0-9]+\**[ \t]+/, "", cmd); if (!seen[cmd]++) print $0 }' |
    FZF_DEFAULT_OPTS="--height ${FZF_TMUX_HEIGHT:-40%} $FZF_DEFAULT_OPTS -n2..,.. --scheme=history --bind=ctrl-r:toggle-sort,ctrl-z:ignore $FZF_CTRL_R_OPTS --query=${(qqq)LBUFFER} +m" $(__fzfcmd)) )
  local ret=$?
  if [ -n "$selected" ]; then
    num=$selected[1]
    if [ -n "$num" ]; then
      zle vi-fetch-history -n $num
    fi
  fi
  zle reset-prompt
  return $ret
}

# Mappings for Reverse Searching

zle     -N            fzf-history-widget
bindkey -M emacs '^R' fzf-history-widget
bindkey -M vicmd '^R' fzf-history-widget
bindkey -M viins '^R' fzf-history-widget

############

# ZSH_ALIASES_START

# utils aliases

alias diff='diff --color'
# alias ls='exa'
# alias la='exa -a '
# alias ll='exa -l --icons'
alias ll='ls -l'
alias grep='grep --color'
alias rm='rm -iv'
alias cp='cp -v'
alias mv='mv -v'
alias zathura='zathura --fork'
alias code='codium'

# Edit aliases

alias ex='nvim ~/.xinitrc '
alias xm='nvim ~/.xmonad/xmonad.hs'
alias xb='nvim ~/.xmobarrc'
alias en='nvim ~/.config/nvim '
alias ea='nvim ~/.config/alacritty/alacritty.yml '
alias et='nvim ~/.tmux.conf'
alias eb='nvim ~/.bashrc '
alias sb='source ~/.zshrc '

# Disk Space Aliases

alias dm='du -h --max-depth 1 | grep M '
alias dg='du -h --max-depth 1 | grep G '

# Wifi Related Aliases

alias wlist='nmcli d wifi list'
alias wconnect='nmcli d wifi connect'
alias wr='nmcli d wifi list && nmcli d wifi connect "realme X7 Max" '

# Random Aliases

alias yt='youtube-dl'
alias tsm='transmission-remote'
alias pg='ping google.com'
alias smci='sudo make clean install'

# git aliases

alias gd='git diff'
alias gb='git branch'
alias gsf='git config --global --add safe.directory "$(pwd)"'
alias gg='git log --graph --pretty=oneline --abbrev-commit'
alias gco='git checkout'
alias gs='git status'
alias gst='git status'

# ZSH_ALIASES_END

# completion Functions

compdef __ccoCompletions cco

function __ccoCompletions(){
    _arguments -C \
        "1: :($(ls /H/code))" \
}

compdef __ccgCompletions ccg

function __ccgCompletions(){
    _arguments -C \
        "1: :($(ls /H/code/college/))" \
}

source "/H/code/lbdsa/dsa.zsh"

# Functions

allContent() {
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
    local __sel="$(allContent | $($(program "$1" )))"
    [[ "$1" == "-p" ]] &&
        __openCmd="pcmanfm" __sel="`dirname "$__sel"`" ||
        __openCmd="mpv"
    printf "$__sel" | xargs -r -d '\n' $__openCmd
}

note(){
    if [[ "$1" == "-d" ]]; then
        nvim /random/notes/journals/$(date "+%a_%d_%b.md")
    elif [[ "$1" != "" ]]; then
        nvim /random/notes/thots/"$1.md"
    else
        allFiles /random/notes/thots | $(__fzfcmd) | xargs -r $EDITOR
    fi
}

webmTomp3(){
    for i in *.webm
    do
        ffmpeg -i "$i" -b:a 320k "${i%.webm}.mp3" &&
        rm "$i"
    done
}

ytm (){
    mkdir /random/Music/$1 &&
    cd /random/Music/$1 &&

    youtube-dl -f 251 "$2"

    for i in *.webm
    do
        ffmpeg -i "$i" -b:a 320k "${i%.webm}.mp3" &&
        rm "$i"

    done
}

m4atoflac(){
    for i in *.m4a
    do
        # ffmpeg -i "$i" -b:a 320k "${i%.webm}.mp3" &&
        ffmpeg -i "$i" -f flac "${i%.m4a}.flac" &&
        rm "$i"
    done
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
        allFiles $HOME/scripts | $(__fzfcmd) | xargs -r $EDITOR
    fi
}

tsma(){
    transmission-remote --add "$1"
}

lzf(){
    locate "$1" | $(__fzfcmd)
}

fg(){
    optionS=$(rg --column --line-number --hidden --ignore-case --no-heading . | $(__fzfcmd) | awk '{print $1}' | awk -F ":" '{print $1 "-" $2}')
    if [[ "$optionS" != "" ]]; then
        nvim ${optionS%-*} -c "normal ${optionS#*-}Gzz"
    fi
}

poke(){
    cat $HOME/suckless/colorscripts/$(ls $HOME/suckless/colorscripts/ | shuf -n 1)
}

cco(){
    if [[ "$1" == "-m" ]];  then
        printf "Making Directory $2\n"
        mkdir "/H/code/$2"
        printf "Changing Directory to $2\n"
        cd "/H/code/$2"
    elif [[ "$1" == "-f" ]];  then
        dir=$(ls /H/code/ | fzf  --height 10 )
        cd "/H/code/$dir"
    else
        cd /H/code/$1
    fi
}

ccg(){
    cd /H/code/college/$1
}

ez(){
    nvim -c "normal $(cat ~/.zshrc -n | $(__fzfcmd) | awk '{print $1}')Gzz" ~/.zshrc
}

fo(){
    if [ -z ${1} ]; then
        selectedFile="$($(__fzfcmd))" &&
        nvim -c "$(cat -n $selectedFile | $(__fzfcmd) | awk '{print $1}')" "$selectedFile"
    else
        selectedFile="$(du -a $1 | awk '{print $2}' |$(__fzfcmd))" &&
        nvim -c "$(cat -n $selectedFile | $(__fzfcmd) | awk '{print $1}')" "$selectedFile"
    fi
}

asmc(){
    nasm -f elf64 -o "/tmp/${1%.asm}.o" "$1" &&
    ld "/tmp/${1%.asm}.o" -o "/tmp/${1%.asm}" &&
    "/tmp/${1%.asm}"
}

fs(){
    fzf  --height 10 | xargs -r $EDITOR
}

allFiles(){
    du -a "$1" | awk '{print $2}'
}

fsc(){
    fzf  --height 20 | xargs -r codium --add
}

fco(){

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
        local dir=$(ls $HOME/.config/ | fzf  --height 10 )
    fi

    if [[ "$GO_TO_DIR" == "1" ]]; then
        cd ~/.config/$dir
    else
        nvim ~/.config/$dir
    fi

}

fn(){
    allFiles "$HOME/.config/nvim/" | fzf  --height 10 | xargs -r $EDITOR
}

gpp(){
    g++ $1 && ./a.out
}

rsc(){
    if [[ "$1" == "-c" ]]; then
         ffmpeg -f v4l2 -video_size 640x480 -i /dev/video0 -c:v libx264 -preset ultrafast -c:a aac "$2"
    else
         ffmpeg -f x11grab -s 1920x1080 -i :0.0 $1
    fi
}

mkvtomp4(){
    ffmpeg -i "$1" -codec copy "${1%.*}.mp4"
}

ap(){
    searchTerm=$(printf "$1" | sed "s/ /%20/g")
    brave "https://archlinux.org/packages/?sort=&q=$searchTerm&maintainer=&flagged=" &
}

aur(){
    searchTerm=$(printf "$1" | sed "s/ /%20/g")
    brave "https://aur.archlinux.org/packages/?O=0&K=$searchTerm" &
}

aw(){
    searchTerm=$(printf "$1" | sed "s/ /%20/g")
    brave "https://wiki.archlinux.org/index.php?search=$searchTerm&title=Special%3ASearch&go=Go" &
}

# Prompt Starts

## autoload vcs and colors
autoload -Uz vcs_info
autoload -U colors && colors

# enable only git
zstyle ':vcs_info:*' enable git

# setup a hook that runs before every ptompt.
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst

zstyle ':vcs_info:git:*' formats " %{$fg[magenta]%}%b%{$reset_color%}"

p_color=red

PROMPT="%{$fg[$p_color]%}%B%d%{$reset_color%}"
PROMPT+="\$vcs_info_msg_0_ "

# Prompt Ends
