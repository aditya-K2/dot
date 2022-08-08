#     ____  _____/ /_  __________
#    /_  / / ___/ __ \/ ___/ ___/
#     / /_(__  ) / / / /  / /__
#    /___/____/_/ /_/_/   \___/
#
autoload -U colors && colors

# History in cache directory:
HISTSIZE=100000
SAVEHIST=100000
HISTFILE=~/.cache/zsh/history

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)        # Include hidden files.

# vi mode
bindkey -v

# Exports

export KEYTIMEOUT=1
# export CGO_ENABLED=1
export PATH=$PATH:$HOME/suckless/scripts
export PATH=$PATH:$HOME/.local/bin
export PATH=$PATH:$HOME/.cargo/bin
export EDITOR='nvim'
export JDTLS_HOME=$HOME/suckless/jdtls/

source "$HOME/env.sh"

# Key Bindings

bindkey '^R' history-incremental-search-backward
bindkey '^H' backward-kill-word
bindkey -M vicmd '/' history-incremental-search-backward
# Use nvim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char
bindkey -s '^o' 'openFFF\n'
bindkey -s '^y' 'fff /D/Downloads/\n'
bindkey -s '^a' 'fff /D/Downloads/\n'


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

# Edit line in nvim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line
bindkey -M vicmd '^R' history-incremental-search-backward

# ZSH_ALIASES_START

# Mnemonics C :

alias cdwm='cd $HOME/suckless/dwm'
alias cdwmblocks='cd $HOME/suckless/dwmblocks '
alias cst='cd $HOME/suckless/st'
alias cscripts='cd $HOME/suckless/scripts'
alias cdd='cd /D/Downloads/'
alias cpo='cd /H/code/competitive'
alias cnotes='cd /random/notes'
alias cl='cd /random/collegeStuff'
alias cm='cd /random/collegeStuff/md'
alias cmusic='cd /D/Downloads/Music/'
alias cf='cd /F/RTDownloads'
alias cs='cd $HOME/suckless'
alias cr='cd /random/'
alias crt='cd /random/RTDownloads'
alias cn='cd ~/.config/nvim '
alias cgom='cd /H/code/gomp'
alias cgs='cd /H/code/gspt'
alias cgui="cd /H/code/docScanner"
alias cmanga='cd /random/Manga/'
alias cds='cd /H/code/competitive/DSA'
alias cdsa='cd /H/code/competitive/DSA'
alias crandom='cd /random'
alias cdot='cd /H/code/dotfiles/'

# utils aliases

alias mutt='neomutt'
alias diff='diff --color'
alias ls='exa'
alias la='exa -a '
alias ll='exa -l --icons'
alias grep='grep --color'
alias rm='rm -iv'
alias cp='cp -v'
alias mv='mv -v'
alias zathura='zathura --fork'
alias sl='ls'
alias code='codium'

# Edit aliases

alias ex='nvim ~/.xinitrc '
alias xm='nvim ~/.xmonad/xmonad.hs'
alias xb='nvim ~/.xmobarrc'
alias en='nvim ~/.config/nvim '
alias ea='nvim ~/.config/alacritty/alacritty.yml '
alias et='nvim ~/.tmux.conf'
alias es='nvim ~/.config/starship.toml'
alias eb='nvim ~/.bashrc '
alias em='nvim ~/.config/mutt/muttrc '
alias sb='source ~/.zshrc '

# suckless aliases

alias dco='cd $HOME/suckless/dwm && rm -f config.h && nvim config.def.h'
alias dbo='cd $HOME/suckless/slstatus && rm -f config.h && nvim config.def.h'
alias sto='cd $HOME/suckless/st && rm -f config.h && nvim config.def.h'
alias dmo='cd $HOME/suckless/dmenu && rm -f config.h && nvim config.def.h'

# Disk Space Aliases

alias dm='du -h --max-depth 1 | grep M '
alias dg='du -h --max-depth 1 | grep G '

# Wifi Related Aliases

alias wlist='nmcli d wifi list'
alias wconnect='nmcli d wifi connect'
alias wk='nmcli d wifi list && nmcli d wifi connect "kurdunkar home" '
alias wr='nmcli d wifi list && nmcli d wifi connect "realme X7 Max" '
alias wo='nmcli d wifi list && nmcli d wifi connect oppo '

# Random Aliases

alias aco='cd $HOME/.config/awesome ; nvim rc.lua'
alias yt='youtube-dl'
alias tsm='transmission-remote'
alias pg='ping google.com'
alias smci='sudo make clean install'

# git aliases

alias gp='git push'
alias gd='git diff'
alias gsf='git config --global --add safe.directory "$(pwd)"'
alias gg='git log --graph --pretty=oneline --abbrev-commit'
alias gl='git log'
alias gb='git branch'
alias gco='git checkout'
alias gst='git status'
alias gq='git add . && git commit -m "quick commit"'

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

note(){
    if [[ "$1" != "" ]]; then
        nvim /random/notes/thots/"$1"
    else
        nvim /random/notes/thots/$(date "+%a_%d_%b.md")
    fi
}

his(){
    cat $HOME/.cache/zsh/history | fzf --height 10 | xclip -selection clipboard
}

audioConvert(){
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
        echo "#!/bin/sh" > $HOME/suckless/scripts/$fileName &&
        chmod +x $HOME/suckless/scripts/$fileName &&
        nvim $HOME/suckless/scripts/$fileName
    elif [[ "$1" == "-g" ]]; then
        cd $HOME/suckless/scripts/
    else
        allFiles $HOME/suckless/scripts | fzf --height 10 | xargs -r $EDITOR
    fi
}

openFFF() {
    fff "$@"
    cd "$(cat "${XDG_CACHE_HOME:=${HOME}/.cache}/fff/.fff_d")"
}

tsma(){
    transmission-remote --add "$1"
}

lzf(){
    locate "$1" | fzf --height 10
}

fg(){
    optionS=$(rg --column --line-number --hidden --ignore-case --no-heading . | fzf --height 10 | awk '{print $1}' | awk -F ":" '{print $1 "-" $2}')
    if [[ "$optionS" != "" ]]; then
        nvim ${optionS%-*} -c "normal ${optionS#*-}Gzz"
    fi
}
ntem(){
    nvim /tmp/$1
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
pom(){
    (pgrep pomodoro | xargs kill -INT ) || pomodoro &
}

ez(){
    nvim -c "normal $(cat ~/.zshrc -n | fzf --height 10| awk '{print $1}')Gzz" ~/.zshrc
}

fo(){
    if [ -z ${1} ]; then
        selectedFile="$(fzf --height 10)" &&
        nvim -c "$(cat -n $selectedFile | fzf --height 10 | awk '{print $1}')" "$selectedFile"
    else
        selectedFile="$(du -a $1 | awk '{print $2}' |fzf --height 10)" &&
        nvim -c "$(cat -n $selectedFile | fzf --height 10 | awk '{print $1}')" "$selectedFile"
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
    dir=$(ls $HOME/.config/ | fzf  --height 10 )
    if [[ "$1" == "-g" ]]; then
        cd ~/.config/$dir
    else
        nvim ~/.config/$dir
    fi
}

fn(){
    allFiles "$HOME/.config/nvim/" | fzf  --height 10 | xargs -r $EDITOR
}

nf(){
    allFiles "$HOME/.config/nvim/"| fzf  --height 10 | xargs -r $EDITOR
}

gpp(){
    g++ $1 && ./a.out
}

gc(){
    if [[ "$1" == "-m" ]]; then
        git clone $2
    elif [[ "$1" == "-p" ]]; then
        git clone https://github.com/aditya-K2/$2 && cd $2
    else
        git clone "https://github.com/$1"
    fi
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
rsv(){
    mpv /dev/video0
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
autopush(){
    if [[ "$2" == "" ]]; then
        git add . && git commit -m "$1" && git push origin master
    elif [[ "$2" == "-n" ]]; then
        git add . && git commit -m "$1"
    else
        git add . && git commit -m "$1" && git push origin "$2"
    fi
}
all(){
    ls *.$1
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

# add a function to check for untracked files in the directory.
# from https://github.com/zsh-users/zsh/blob/master/Misc/vcs_info-examples
zstyle ':vcs_info:git*+set-message:*' hooks git-untracked
#
+vi-git-untracked(){
    if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == 'true' ]] && \
        git status --porcelain | grep '??' &> /dev/null ; then
        # This will show the marker if there are any untracked files in repo.
        # If instead you want to show the marker only if there are untracked
        # files in $PWD, use:
        #[[ -n $(git ls-files --others --exclude-standard) ]] ; then
        hook_com[staged]+='!' # signify new files with a bang
    fi
}

zstyle ':vcs_info:*' check-for-changes true
# zstyle ':vcs_info:git:*' formats " %r/%S %b %m%u%c "
zstyle ':vcs_info:git:*' formats " %{$fg[magenta]%}%b"

PROMPT=" %{$fg[cyan]%}%~%{$reset_color%}"
PROMPT+="\$vcs_info_msg_0_ "

# Prompt Ends

source $HOME/suckless/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null
