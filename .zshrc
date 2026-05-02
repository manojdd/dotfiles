HISTFILE=~/.zsh_history
HISTSIZE=10000000
SAVEHIST=10000000
setopt APPEND_HISTORY        # Append instead of overwrite
setopt SHARE_HISTORY         # Share history across all sessions
setopt HIST_IGNORE_DUPS      # Don't record duplicate consecutive commands
setopt HIST_FIND_NO_DUPS     # Don't show dups when searching
setopt HIST_REDUCE_BLANKS
setopt HIST_IGNORE_SPACE     # Don't record commands starting with a space
setopt HIST_VERIFY           # Show command before executing from history
setopt INTERACTIVE_COMMENTS  # Allow adding interactive comments

# vi mode
bindkey -v

# The following lines were added by compinstall
zstyle :compinstall filename "${HOME}/.zshrc"

autoload -Uz compinit
compinit
# End of lines added by compinstall

# Added by me
source <(fzf --zsh)
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
# These 2 should be at the end
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
# Keybindings
# Ctrl-Space accepts the autosuggestion
bindkey '^ ' autosuggest-accept
# Binding Ctrl-Enter is usually problematic and requires terminal to send a different code but the following DOESNOT works in st
# bindkey '^\r' autosuggest-execute
bindkey '\033[1;5M' autosuggest-execute
# zsh-history-substring-search
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

f() {
FZF_DEFAULT_COMMAND="plocate ''" \
    fzf --bind "change:reload:plocate {q} || true" \
        --ansi --phony --query "" --preview 'file {}' --bind '?:preview:cat {}'
}

# Get memory PSS for process which is amore accurate measure of memory usage
mem() {
	pidof "$1" | tr -d '\n' | xargs -I % -d ' ' -n 1 cat /proc/%/smaps_rollup | grep ^Pss: | awk 'BEGIN{total = 0}{total += $2}END{printf("%f GB\n", total/1024^2)}'

	# # AI generated but probably better
	# awk '/^Pss:/ {sum += $2} END {printf("%.2f GiB\n", sum/1024/1024)}' \
	#     $(pidof firefox | tr ' ' '\n' | sed 's|^|/proc/|;s|$|/smaps_rollup|')
	#
	# for p in $(pidof firefox); do
	#   awk '/^Pss:/ {sum += $2} END {print sum}' /proc/$p/smaps_rollup
	# done | awk '{total += $1} END {printf("%.2f GiB\n", total/1024/1024)}'
}

PROMPT='%F{green}%n%f@%F{magenta}%m%f %F{blue}%B%~%b%f %# '

# Aliases
alias ls='ls --color=auto'
alias grep='grep --color=auto'
export MANPAGER='nvim +Man!'
export FZF_DEFAULT_OPTS="--preview '[ -f {} ] && bat --color=always {} || echo {}' --bind 'ctrl-f:preview-page-down,ctrl-b:preview-page-up'"
export FZF_CTRL_R_OPTS="--height 50% --preview 'echo {2..} | bat --color=always -pl sh' --preview-window 'wrap,down,5'"
alias open='xdg-open'
alias pandock='docker run --rm -v "$(pwd):/data" -u $(id -u):$(id -g) pandoc/minimal:latest-alpine'
# Dotfiles
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
