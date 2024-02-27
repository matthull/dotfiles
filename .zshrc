fpath=($HOME/completion_zsh $fpath)

# Location of dotfiles
export DOTFILES=$HOME/.dotfiles

HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.history

# share history between shells and eliminate dupe commands
setopt sharehistory histignorealldups

# enable fancy globbing
setopt extendedglob

# prevent dupes in path array
typeset -U path

# get list of zsh files
typeset -U config_files
config_files=($DOTFILES/**/*.zsh)

# Load the path files
for file in ${(M)config_files:#*/path.zsh}
do
  source $file
done

# Now load everything else
for file in ${config_files:#*/path.zsh}
do
  source $file
done

unset config_files

bindkey -v
bindkey "^R" history-incremental-search-backward
autoload -U history-search-end

zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end

bindkey "^[OA" history-beginning-search-backward-end
bindkey "^[OB" history-beginning-search-forward-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

export PATH=./bin:$PATH

export PATH="./pythonenv/bin:$PATH"

alias pydoc='python -m pydoc'

export REDIS_HOST=127.0.0.1

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

export PATH="$HOME/.poetry/bin:$PATH"

alias aws="PAGER=cat aws"

ZSH_THEME="fishy"

#wal -R

autoload bashcompinit && bashcompinit
autoload -Uz compinit && compinit
compinit

complete -C '/usr/local/bin/aws_completer' aws
source /usr/share/chruby/chruby.sh
export COMPOSE_FILE=~/code/musashi/docker-compose.yml
export PATH=/home/matt/.poetry/bin:./pythonenv/bin:./bin:/home/matt/.local/bin:/home/matt/bin:/usr/local/bin:/usr/local/share/npm/bin:/usr/local/mysql/bin:/home/matt/.cargo/bin:/home/matt/.local/kitty.app/bin:/usr/local/sbin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:/usr/local/go/bin

chruby ruby 3.0.6

alias vim=lvim

# setxkbmap -option ctrl:swap_lalt_lctl

alias de="docker exec -it musashi-web-1 "
alias deb="docker exec -it musashi-web-1 bundle exec "
alias det="docker exec -e DATABASE_URL="postgres://musashi:san@database/test_ue" -e RAILS_ENV=test -it musashi-web-1 "
alias detb="docker exec -e DATABASE_URL="postgres://musashi:san@database/test_ue" -e RAILS_ENV=test -e SIMPLECOV=1 -it musashi-web-1 bundle exec "
source /usr/share/nvm/init-nvm.sh
alias kg="docker exec -it musashi-web-1 /bin/bash ps aux | grep -v grep | grep guard | awk '{print $2}' | xargs kill -9 "
alias deg="det bundle exec guard"

alias ls="eza"
