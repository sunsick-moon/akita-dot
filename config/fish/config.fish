# akita-dot fish config
#
# This used to `source /usr/share/cachyos-fish-config/cachyos-config.fish`,
# but that file only exists on CachyOS (it ships in the cachyos-fish-config
# package, which isn't in the official Arch repos). Everything genuinely
# useful from it is reproduced below so this works on any Arch install.
#
# Needs: fish, fastfetch, eza, bat (pacman) + fisher with pure-fish/pure and
# jorgebucaran/done (bootstrapped by install_dependencies.sh).

if status is-interactive
    # Run fastfetch as the welcome message, like CachyOS does.
    function fish_greeting
        fastfetch
    end

    # "done" plugin (https://github.com/jorgebucaran/done): notifies you when
    # a long-running command finishes in an unfocused terminal.
    set -U __done_min_cmd_duration 10000
    set -U __done_notification_urgency_level low
end

# Format man pages with bat for syntax highlighting.
set -x MANROFFOPT "-c"
set -x MANPAGER "sh -c 'col -bx | bat -l man -p'"

# Apply ~/.fish_profile if present (useful for POSIX-sh compatible env setup).
if test -f ~/.fish_profile
    source ~/.fish_profile
end

fish_add_path ~/.local/bin ~/.cargo/bin

## Functions needed for !! and !$ (https://github.com/oh-my-fish/plugin-bang-bang)
function __history_previous_command
    switch (commandline -t)
        case "!"
            commandline -t $history[1]
            commandline -f repaint
        case "*"
            commandline -i !
    end
end

function __history_previous_command_arguments
    switch (commandline -t)
        case "!"
            commandline -t ""
            commandline -f history-token-search-backward
        case "*"
            commandline -i '$'
    end
end

if test "$fish_key_bindings" = fish_vi_key_bindings
    bind -Minsert ! __history_previous_command
    bind -Minsert '$' __history_previous_command_arguments
else
    bind ! __history_previous_command
    bind '$' __history_previous_command_arguments
end

function backup --argument filename
    cp $filename $filename.bak
end

## Aliases
# eza instead of ls
alias ls='eza -al --color=always --group-directories-first --icons=always'
alias la='eza -a --color=always --group-directories-first --icons=always'
alias ll='eza -l --color=always --group-directories-first --icons=always'
alias lt='eza -aT --color=always --group-directories-first --icons=always'
alias l.="eza -a | grep -e '^\.'"

# Generic Arch maintenance
alias update='sudo pacman -Syu'
alias mirror='sudo reflector --latest 20 --protocol https --sort rate --save /etc/pacman.d/mirrorlist'
alias fixpacman='sudo rm -f /var/lib/pacman/db.lck'
alias cleanup='sudo pacman -Rns (pacman -Qtdq)'
alias orphans='pacman -Qtdq'
alias jctl='journalctl -p 3 -xb'
alias gitpkg='pacman -Q | grep -i "\-git" | wc -l'

# Help people coming from Debian/Ubuntu
alias apt='man pacman'
alias apt-get='man pacman'

# Generic shell QoL
alias tarnow='tar -acf '
alias untar='tar -zxvf '
alias wget='wget -c '
alias psmem='ps auxf | sort -nr -k 4'
alias psmem10='ps auxf | sort -nr -k 4 | head -10'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias tb='nc termbin.com 9999'

abbr -a hval "hyprctl eval ''"
abbr -a matu-nmtui "NEWT_COLORS=(string join ' ' (cat ~/.config/nmtui/palette)) nmtui"
