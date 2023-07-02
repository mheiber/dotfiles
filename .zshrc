# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/Users/mheiber/.oh-my-zsh"
export ZSH_CUSTOM="/Users/mheiber/.oh-my-zsh/custom"
# most of the interesting stuff is there:
source ~/.zshenv


# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
# copydir command copies current dir
# dirhistory: meta-left and meta-right cycle through dir history
#
# custom plugins are in ~/.oh-my-zsh/custom/plugins
# mercurial-prompt plugin is from https://github.com/iarkhanhelsky/oh-my-zsh-hg-prompt
# plugins=( git zsh-autosuggestions mercurial-prompt rust dirhistory)
plugins=( git zsh-autosuggestions rust dirhistory)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
#
#
#
#
#
#
zstyle ':completion:*:manuals'    separate-sections true
zstyle ':completion:*:manuals.*'  insert-sections   true
zstyle ':completion:*:man:*'      menu yes select

zsetup() {
    #
    # Enable Ctrl-x-e to edit command line
    autoload -U edit-command-line
    # Emacs style
    # bindkey '^xe' edit-command-line
    # bindkey '^x^e' edit-command-line
    # Vi style:
    #
    # bindkey -v 
    # bindkey '^R' history-incremental-search-backward
    # bindkey -M viins 'jk' vi-cmd-mode
    # zle -N edit-command-line
    # bindkey -M vicmd V edit-command-line
    # bindkey "^A" vi-beginning-of-line
    # bindkey "^E" vi-end-of-line
    # bindkey "^K" kill-line

    autoload -Uz vcs_info
    zstyle ':vcs_info:*' enable git svn # hg
    # Load version control information
    # zstyle ':vcs_info:git*' formats "%{$fg[grey]%}%s %{$reset_color%}%r/%S%{$fg[grey]%} %{$fg[blue]%}%b%{$reset_color%}%m%u%c%{$reset_color%} "
    # zstyle ':vcs_info:git*' actionformats "%b %m%u%c "

    export ZSH_THEME_HG_PROMPT_USE_BOOKMARK="true"
    export ZSH_THEME_HG_PROMPT_BRANCH_COLOR="$fg[blue]"
    # export ZSH_THEME_GIT_PROMPT_BRANCH_COLOR="$fg[blue]" # doesn't work anyway
    export ZSH_THEME_HG_PROMPT_TAG="" # default is: hg
    export ZSH_THEME_GIT_PROMPT_TAG="" # default is: git
    export ZSH_THEME_HG_PROMPT_PREFIX="" # default is: :
    export ZSH_THEME_GIT_PROMPT_PREFIX="" # default is: :
    export ZSH_THEME_GIT_PROMPT_SUFFIX="" # default is: :
    # export ZSH_THEME_GIT_PROMPT_SUFFIX="" # default is: :
    # export ZSH_THEME_GIT_PROMPT_DIRTY="" # default is: :
    export ZSH_THEME_GIT_PROMPT_DIRTY="%{%} %{%}-" # just adds `-`
    # export ZSH_THEME_HG_PROMPT_DIRTY="%{%} %{%}-" # doesn't do anything
    export ZSH_THEME_GIT_PROMPT_CLEAN=""

    # Format the vcs_info_msg_0_ variable
    # zstyle ':vcs_info:hg:*' formats '%b%m%u%c'
    # zstyle ':vcs_info:git*' formats '%b%m%u%c'
    # zstyle ':vcs_info:git*' actionformats '%b%m%u%c'
    # zstyle ':vcs_info:hg:*' actionformats '%b%m%u%c'
    precmd() {
        vcs_info
    }
     
    # Set up the prompt (with git branch name)
    # setopt PROMPT_SUBST
    # PROMPT='${PWD/#$HOME/~}[$(git_prompt_info)$(hg_prompt_info)] '
    PROMPT='${PWD/#$HOME/~}[$(git_prompt_info)] '
    # PROMPT='${PWD/#$HOME/~}[${vcs_info_msg_0_}] '
    # setopt prompt_subst
}
zsetup
[ -f "/Users/mheiber/.ghcup/env" ] && source "/Users/mheiber/.ghcup/env" # ghcup-env

# opam configuration
[[ ! -r /Users/mheiber/.opam/opam-init/init.zsh ]] || source /Users/mheiber/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null

# added by setup_fb4a.sh
export ANDROID_SDK=/opt/android_sdk
export ANDROID_NDK_REPOSITORY=/opt/android_ndk
export ANDROID_HOME=${ANDROID_SDK}
export PATH=${PATH}:${ANDROID_SDK}/emulator:${ANDROID_SDK}/tools:${ANDROID_SDK}/tools/bin:${ANDROID_SDK}/platform-tools
export PATH="$HOME/homebrew/bin:$HOME/homebrew/sbin:$PATH"

