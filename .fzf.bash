# Setup fzf
# ---------
if [[ ! "$PATH" == */home/florian/.fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/home/florian/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/florian/.fzf/shell/completion.bash" 2> /dev/null

# Key bindings
# ------------
source "/home/florian/.fzf/shell/key-bindings.bash"
