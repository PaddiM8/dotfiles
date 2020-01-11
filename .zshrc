#Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -e
# End of lines configured by zsh-newuser-install

PROMPT="%F{cyan}[%1~] $%f%b "
RPROMPT="  %D{%H:%M}"

# Update every 30 seconds.
TMOUT=30
TRAPALRM() {
   zle reset-prompt
}

archey3

# Exports
export TERM=xterm
export EDITOR=nvim
export PATH="$PATH:/home/paddi/.gem/ruby/2.6.0/bin"
export MOZ_ENABLE_WAYLAND=1
export DOTNET_ROOT=~/dotnet
export PATH=$PATH:~/dotnet
export PATH=$PATH:~/.dotnet/tools

# Sway
export _JAVA_AWT_WM_NONREPARENTING=1
export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on'
export SDL_VIDEODRIVER=wayland
export LC_ALL=en_GB.UTF-8
export XKB_DEFAULT_LAYOUT=se_bakk;
export XKB_DEFAULT_MODEL=pc101;
export GTK_THEME=Arc-Gruvbox

# Aliases
setopt transient_rprompt
alias dotnetserver='dotnet run --server.urls=http://0.0.0.0:5000'
#alias vim='nvim'
alias mtrans='trans -b -t fi+eo+de'
alias vi='vim'
alias lookin='looking-glass-client -M -o opengl:vsync=0'
alias discord='GDK_BACKEND=x11 /usr/bin/discord 2>/dev/null'
alias ls='ls --color'
alias repo='repo-add *.db.tar.xz *.pkg.tar.xz'
alias SUDO='sudo !!'
#alias fp='cd $(find ~/projects -type d | fzf)'
#alias fc='vim $(find ~/.config -type f | fzf)'

# Functions
function fp() {
   if [ $1 ]; then
      cd $(find ~/Projects -type d | fzf -f $1 | head -1)
   else
      cd $(find ~/Projects -type d | fzf)
   fi
}

function fc() {
   if [ $1 ]; then
      $EDITOR $(find ~/.config -type f | fzf -f $1 | head -1)
   else
      $EDITOR $(find ~/.config -type f | fzf)
   fi
}

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
alias uu='sudo fstrim / && yay'
alias 'sudo -E vim'
export FFSEND_HOST='https://send.smrk.me/'
