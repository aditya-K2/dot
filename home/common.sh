#!/bin/bash

# Common functions and utilities that can be shared between bash and zsh

#-(Source Files)--------------------------------------------------------------
__wsl__() {
    [[ -f /proc/sys/fs/binfmt_misc/WSLInterop ]] && return 0
    return 255
}

__source__() {
    local file="lin_$1.sh"
    __wsl__ && file="wsl_$1.sh"
    source "$HOME/$file"
}

__source__ env
__source__ alias

#-(Create files/folders that don't exist but are required )-------------------

# Z script
Z_SH_PATH="$HOME/z.sh"
Z_SH_LINK="https://raw.githubusercontent.com/rupa/z/master/z.sh"
! [[ -r "$Z_SH_PATH" ]] \
    && wget "$Z_SH_LINK" -O "$Z_SH_PATH" \
    || source "$Z_SH_PATH"

# Create directories that don't exist
! [[ -d "$VENV_DIR" ]] && mkdir "$VENV_DIR"
! [[ -d "$CODE_DIR" ]] && mkdir "$CODE_DIR"
! [[ -d "$NOTES_DIR" ]] && mkdir "$NOTES_DIR"

# Node Version Manager
export NVM_DIR="$HOME/.nvm"
! [[ -r "$NVM_DIR" ]] \
    && curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash \
    && nvm install node \
    && nvm use node

#-----------------------------------------------------------------------------

_FZF_HEIGHT_=7
_FZF_OPTIONS_="--border=none --info=hidden --color=light --reverse"

cmd_exists() {
	command -v "$1" 1>/dev/null 2>/dev/null && return 0
	return 1
}

fd_command() {
    cmd_exists fd && printf "fd" || printf "fdfind"
    printf " --color=never"
}

# Setting fd as the default source for fzf (respects .gitignore)
export FZF_DEFAULT_COMMAND="$(fd_command) --type f --strip-cwd-prefix"

__fzf_cmd() {
    printf "fzf --height $_FZF_HEIGHT_ $_FZF_OPTIONS_"
}

__rg_cmd() {
    printf "rg --column --line-number --hidden --ignore-case --no-heading ."
}

__dmenu_cmd() {
    printf "dmenu -i -f -l 10"
}

____wrapper() {
    eval "$(eval $1)"
}

fzf_cmd() {
    ____wrapper __fzf_cmd
}

rg_cmd() {
    ____wrapper __rg_cmd
}

dmenu_cmd() {
    ____wrapper __dmenu_cmd
}

fk() {
    [[ $1 == "" ]] && return 1
    ps aux | \grep $1 | fzf_cmd | awk '{print $2}' | xargs -r kill
}

venv() {
    case "$1" in
        "new")
            [[ "$2" != "" ]] && virtualenv "$VENV_DIR/$2" &&
                source "$VENV_DIR/$2/bin/activate"||
                echo "Empty Name Provided!"
            ;;
        "remove")
            [[ "$2" != "" ]] && \rm -rf "$VENV_DIR/$2" &&
                echo "Removed $2 Succesfully!" ||
                echo "Empty Name Provided!"
                command -v deactivate && deactivate
            ;;
        "-f")
            local sel
            sel="$( find "$VENV_DIR" -maxdepth 1 -mindepth 1 -type d | fzf_cmd )"
            [[ "$sel" != "" ]] && source "$sel/bin/activate"
            ;;
        "source")
            source "$VENV_DIR/$2/bin/activate"
            ;;
    esac
}

tl() {
    local _session="$(tmux list-sessions | fzf_cmd | awk -F: '{print $1}')"
    [[ "$_session" != "" ]] && tmux attach-session -t $_session
}

note(){
    if [[ "$1" == "-d" ]]; then
        nvim $NOTES_DIR/$(date "+%a_%d_%b.md")
    elif [[ "$1" == "-f" ]]; then
        all_files $NOTES_DIR | fzf_cmd | xargs -r -d '\n' $EDITOR
    elif [[ "$1" == "-g" ]]; then
        cd $NOTES_DIR
    elif [[ "$1" != "" ]]; then
        if [[ "$1" != *.md ]]; then
            nvim "$NOTES_DIR/$1.md"
        else
            nvim "$NOTES_DIR/$1"
        fi
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
        all_files $HOME/scripts | fzf_cmd | xargs -r -d '\n' $EDITOR
    fi
}

lzf(){
    locate "$1" | fzf_cmd
}

fg(){
    optionS=$($(__rg_cmd) | fzf_cmd | awk '{print $1}' | awk -F ":" '{print $1 "-" $2}')
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
        dir=$(ls $CODE_DIR/ | fzf_cmd )
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
    local file="$(cat $HOME/.zshrc -n | fzf_cmd)"
    [[ "$file" != "" ]] && (
        local line_nr="$(awk '{print $1}' <<< "$file")"
        nvim -c "$(printf "normal %sGzz" $line_nr)" $HOME/.zshrc
    )
}

fs(){
    fzf_cmd | xargs -r -d '\n' $EDITOR
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
        local dir=$(ls $HOME/.config/ | fzf_cmd )
    fi

    if [[ "$GO_TO_DIR" == "1" ]]; then
        cd $HOME/.config/$dir
    else
        nvim $HOME/.config/$dir
    fi
}

fn(){
    all_files "$HOME/.config/nvim/" | fzf_cmd | xargs -r -d '\n' $EDITOR
}

envm() {
    # Node Version Manager
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
}

epyenv() {
    export PYENV_ROOT="$HOME/.pyenv"
    [[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init -)"
}

sb() {
    if [[ -n "$ZSH_VERSION" ]]; then
        source ~/.zshrc
    elif [[ -n "$BASH_VERSION" ]]; then
        source ~/.bashrc
    fi
}
