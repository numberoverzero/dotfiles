ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[green]%}["
ZSH_THEME_GIT_PROMPT_SUFFIX="]%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg[red]%}*%{$fg[green]%}"
ZSH_THEME_GIT_PROMPT_CLEAN=""

PROMPT=$'%(?,,%F{red}%K[exit:$?]%f%k )%F{green}%n@%m%f %F{blue}%D{[%X]}%f %F{white}[%~]%f $(git_prompt_info)\
%F{grey}%K[%!]%f%k %F{blue}%(!.#.$)%f '
