if status is-interactive
    # Commands to run in interactive sessions can go here
end

# colorful stuff with gcr + fish gcr plugin
set -U grcplugin_ls --color -l
# set a custom config path just so we can have starship on its own dir in the dotfiles
set -U STARSHIP_CONFIG ~/.config/starship/starship.toml

fish_add_path /opt/homebrew/opt/openjdk/bin
fish_add_path $HOME/.cargo/bin
fish_add_path /nix/var/nix/profiles/default/bin
fish_add_path /opt/homebrew/bin
fish_add_path $HOME/go/bin
#replay . /nix/var/nix/profiles/default/etc/profile.d/nix.sh

zoxide init fish | source

starship init fish | source

alias kube="kubectl"
alias kub="kubectl"
alias g="git"
alias gst="git status"
alias reload="source ~/.config/fish/config.fish"
alias fish-config="nvim ~/.config/fish/config.fish"
alias update-neovim="brew uninstall neovim && brew install --HEAD neovim"
alias afk="open -a /System/Library/CoreServices/ScreenSaverEngine.app"

#!/usr/bin/fish

# Kanagawa Fish shell theme
# A template was taken and modified from Tokyonight:
# https://github.com/folke/tokyonight.nvim/blob/main/extras/fish_tokyonight_night.fish
set -l foreground DCD7BA
set -l selection 2D4F67
set -l comment 727169
set -l red C34043
set -l orange FF9E64
set -l yellow C0A36E
set -l green 76946A
set -l purple 957FB8
set -l cyan 7AA89F
set -l pink D27E99

# Syntax Highlighting Colors
set -g fish_color_normal $foreground
set -g fish_color_command $cyan
set -g fish_color_keyword $pink
set -g fish_color_quote $yellow
set -g fish_color_redirection $foreground
set -g fish_color_end $orange
set -g fish_color_error $red
set -g fish_color_param $purple
set -g fish_color_comment $comment
set -g fish_color_selection --background=$selection
set -g fish_color_search_match --background=$selection
set -g fish_color_operator $green
set -g fish_color_escape $pink
set -g fish_color_autosuggestion $comment

# Completion Pager Colors
set -g fish_pager_color_progress $comment
set -g fish_pager_color_prefix $cyan
set -g fish_pager_color_completion $foreground
set -g fish_pager_color_description $comment

starship init fish | source

replay source "/opt/homebrew/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.bash.inc"
replay source "/opt/homebrew/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.bash.inc"


# pnpm
set -gx PNPM_HOME "/Users/thiago.pontes/Library/pnpm"
set -gx PATH "$PNPM_HOME" $PATH
# pnpm end

replay export GPG_TTY=$(tty)
gpgconf --launch gpg-agent

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH
