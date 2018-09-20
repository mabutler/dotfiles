# If you come from bash you might have to change your $PATH.
export PATH=/opt/rh/rh-php71/root/bin:/opt/laravel/spark-installer:/home/mbutler/.config/composer/vendor/bin:$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=/home/mbutler/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="dst"

# set ls colors
eval "$(dircolors ~/.config/dircolors)"

# Set list of themes to load
# Setting this variable when ZSH_THEME=random
# cause zsh load theme from this variable instead of
# looking in ~/.oh-my-zsh/themes/
# An empty array have no effect
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git composer encode64 tmux
)

source $ZSH/oh-my-zsh.sh

# User configuration

# execute history expansion commands immediately
setopt no_hist_verify

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi
export EDITOR='vim'

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
#
# disable beep
export ZBEEP=''

export LESS="-rSFX"

alias ls='ls --color="tty" -F'
alias g='git'
alias gs='git status'
alias diff='colordiff -u'
alias config='git --git-dir=$HOME/.dotfiles --work-tree=$HOME'

# locate for a specific folder
#
# Usage:   clocate $regexFileName $path=pwd
# Example: clocate .zsh*          ../../
clocate() {
	if [ -z $2 ]; then
		directory=$(pwd)
	else
		directory=$2
	fi

	locate -ir $(realpath $directory)/".*"/"$1"
}

artisan() {
	local pathToArtisan='';
	if [ -f 'artisan' ]; then pathToArtisan='artisan';
	elif [ -f $(git rev-parse --show-toplevel 2>/dev/null)'/artisan' ]; then pathToArtisan="$(git rev-parse --show-toplevel 2>/dev/null)/artisan";
	elif [ -f $(git rev-parse --show-toplevel 2>/dev/null)'/emr/artisan' ]; then pathToArtisan="$(git rev-parse --show-toplevel 2>/dev/null)/emr/artisan";
	elif [ -z "$pathToArtisan" ]; then echo "Could not find artisan"; return 1;
	fi

	php $pathToArtisan $@
}

warp() {
    # TODO: add git repo bookmarks (if in a git repo check for local bookmarks)
    #
    # may be able to redo this with existing git project
    # see https://github.com/mfaerevaag/wd
    USAGE="Usage: warp make|to|rm|show [bookmark]" ;
    local folder=$(git rev-parse --show-toplevel 2>/dev/null)
    if  [ ! -e $folder/.cd_bookmarks ] ; then
        mkdir $folder/.cd_bookmarks
    fi

    case $1 in
        # create bookmark
        create)
            ;&
        make) shift
            if [ ! -f $folder/.cd_bookmarks/$1 ] ; then
                echo "cd `pwd`" > $folder/.cd_bookmarks/"$1" ;
            else
                echo "Try again! Looks like there is already a bookmark '$1'"
            fi
            ;;
        # goto bookmark
        go)
            ;&
        to) shift
            if [ -f $folder/.cd_bookmarks/$1 ] ; then
                source $folder/.cd_bookmarks/"$1"
            else
                echo "Mmm...looks like your bookmark has spontaneously combusted. What I mean to say is that your bookmark does not exist." ;
            fi
            ;;
        # delete bookmark
        delete)
            ;&
        rm) shift
            if [ -f $folder/.cd_bookmarks/$1 ] ; then
                rm $folder/.cd_bookmarks/"$1" ;
            else
                echo "Oops, forgot to specify the bookmark" ;
            fi
            ;;
        # list bookmarks
        list)
            ;&
        show) shift
            \ls $folder/.cd_bookmarks/ ;
            ;;
         *) echo "$USAGE" ;
            ;;
    esac
}

_warp () {
    if (( $+functions[_warp-$words[2]] )); then
        _call_function ret _warp-$words[2]
    else
        local -a commands
        commands=('make' 'to' 'rm' 'list')
        _describe 'commands' commands
    fi
}
_warp-to () {
    local -a fileList
    fileList=$(warp list)
    fileList=( ${(f)fileList} )
    _describe 'commands' fileList
}
# alias of warp to
_warp-go () {
    _call_function ret _warp-to
}

_warp-rm () {
    _call_function ret _warp-to
}
# alias of warp rm
_warp-delete () {
    _call_function ret _warp-rm
}

_warp-list () {
    #nothing
}
#alias of warp list
_warp-show () {
    _call_function ret _warp-list
}

_warp-create () {
    #nothing
}
_warp-make () {
    _call_function ret _warp-create
}
compdef _warp warp

if [ -f ~/.zshrc.local ]; then
    source ~/.zshrc.local
fi

