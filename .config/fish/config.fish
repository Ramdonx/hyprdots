function fish_prompt -d "Write out the prompt"
    # This shows up as USER@HOST /home/user/ >, with the directory colored
    # $USER and $hostname are set by fish, so you can just use them
    # instead of using `whoami` and `hostname`
    printf '%s@%s %s%s%s > ' $USER $hostname \
        (set_color $fish_color_cwd) (prompt_pwd) (set_color normal)
end

if status is-interactive # Commands to run in interactive sessions can go here

    # No greeting
    set fish_greeting

    # Use starship
    starship init fish | source
    if test -f ~/.local/state/quickshell/user/generated/terminal/sequences.txt
        cat ~/.local/state/quickshell/user/generated/terminal/sequences.txt
    end

# Aliases
    alias pamcan pacman
    alias ls 'eza --icons'
    alias clear "printf '\033[2J\033[3J\033[1;1H'"
    alias q 'qs -c ii'
    alias ins="sudo pacman -S"
    alias pacsy="sudo pacman -Sy"
    alias update="sudo pacman -Syu"
    alias pacss="pacman -Ss"
    alias pacq="pacman -Qs"
    alias pacr="sudo pacman -Rns"
    alias pacc="sudo pacman -Sc"
    alias ..="cd .."
    alias ...="cd ../.."

zoxide init fish | source

function cd
    __zoxide_z $argv
    and eza --group-directories-first --icons=always
end

# Restaurar el autocompletado de zoxide para cd
complete -c cd -w __zoxide_z

end
