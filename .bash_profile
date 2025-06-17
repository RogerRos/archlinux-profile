#
# ~/.bash_profile
#

#[[ -f ~/.bashrc ]] && . ~/.bashrc

#
# Run 'sudo systemctl enable sddm' in the terminal to re-enable the graphical login.
#

# Auto-launch Hyprland on TTY1 if no graphical session is active
if [[ -z $DISPLAY && $XDG_VTNR -eq 1 ]]; then
  exec Hyprland
fi
