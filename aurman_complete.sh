#!/bin/bash
echo '_aurman_complete()
{
    # needed vars
    local cur index line
    cur=$(_get_cword)
    index=${COMP_CWORD}
    line=${COMP_LINE}

    response=$( aurman --auto_complete --auto_complete_cur $cur --auto_complete_index $index --auto_complete_line $line )

    if [ "$response" == "call_pacman" ]; then
        _pacman
    else
        COMPREPLY=($(compgen -W "$response" -- $cur))
    fi
}

_completion_loader pacman
complete -o default -F _aurman_complete aurman' > /etc/bash
