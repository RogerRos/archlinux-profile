#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

fastfetch --structure "break\n$all"
fastfetch --logo none

export PATH="$HOME/.local/bin:$PATH"
alias tccode='thunar "/home/ros/Documents/Seattle Central College/fall 2025/CSC143/code/"'
alias ccode='cd "/home/ros/Documents/Seattle Central College/fall 2025/CSC143/code/"'

export EDITOR=nvim
export VISUAL=$EDITOR

alias n='nnn -e'
alias nnn='nnn -e'
