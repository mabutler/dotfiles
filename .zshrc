# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="dst"

# set ls colors
eval "$(dircolors ~/.config/dircolors)"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git composer encode64 tmux
)

if [ -f ~/.zshrc.oh-my-zsh.local ]; then
    source ~/.zshrc.oh-my-zsh.local
fi

if ([[ -a $ZSH/oh-my-zsh.sh ]])
then
    source $ZSH/oh-my-zsh.sh
else
    echo 'Oh-my-zsh not installed. Run these commands, then source this file again:'
    echo ' sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"'
    echo ' mv ~/.zshrc.pre-oh-my-zsh ~/.zshrc'
fi

# User configuration
for file in .config/functions/*; do
    source $file
done

for file in .config/statusScripts/*; do
    $file
done

# execute history expansion commands immediately
setopt no_hist_verify

# Preferred editor for local and remote sessions
export EDITOR='vim'

# disable beep
export ZBEEP=''

export LESS="-rSFX"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
alias ls='ls --color="tty" -F'
alias g='git'
alias gs='git status'
alias diff='colordiff -u'
alias config='git --git-dir=$HOME/.dotfiles --work-tree=$HOME'

if [ -f ~/.zshrc.local ]; then
    source ~/.zshrc.local
fi

