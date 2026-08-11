source /usr/share/cachyos-fish-config/cachyos-config.fish

# overwrite greeting
# potentially disabling fastfetch
#function fish_greeting
#    # smth smth
#end

#function hval
#    hyprctl eval $argv
#end

abbr -a hval "hyprctl eval ''"
abbr -a matu-nmtui "NEWT_COLORS=(string join ' ' (cat ~/.config/nmtui/palette)) nmtui"
