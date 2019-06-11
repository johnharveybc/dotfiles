# .bashrc

# this is a comment

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions

export PATH="~/bin:$PATH"
alias config='/usr/bin/git --git-dir=/mnt/Profiles/jharvey@trackvfx.local/.cfg/ --work-tree=/mnt/Profiles/jharvey@trackvfx.local'

# Another CTRL-R script to insert the selected command from history into the command line/region
__fzf_history ()
{
    builtin history -a;
    builtin history -c;
    builtin history -r;
    builtin typeset \
        READLINE_LINE_NEW="$(
            HISTTIMEFORMAT= builtin history |
            command fzf +s --tac +m -n2..,.. --tiebreak=index --toggle-sort=ctrl-r |
            command sed '
                /^ *[0-9]/ {
                    s/ *\([0-9]*\) .*/!\1/;
                    b end;
                };
                d;
                : end
            '
        )";

        if
                [[ -n $READLINE_LINE_NEW ]]
        then
                builtin bind '"\er": redraw-current-line'
                builtin bind '"\e^": magic-space'
                READLINE_LINE=${READLINE_LINE:+${READLINE_LINE:0:READLINE_POINT}}${READLINE_LINE_NEW}${READLINE_LINE:+${READLINE_LINE:READLINE_POINT}}
                READLINE_POINT=$(( READLINE_POINT + ${#READLINE_LINE_NEW} ))
        else
                builtin bind '"\er":'
                builtin bind '"\e^":'
        fi
}

builtin set -o histexpand;
builtin bind -x '"\C-x1": __fzf_history';
builtin bind '"\C-r": "\C-x1\e^\er"'

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

export PYTHONPATH="/mnt/Plugins/Python:$PYTHONPATH"
export PYTHONPATH="/usr/local/lib64/python2.7/site-packages:$PYTHONPATH"
export SYNTHEYES_SCRIPT_PATH="/mnt/Plugins/SynthEyes/Scripts:$SYNTHEYES_SCRIPT_PATH"
export PYTHON_CUSTOM_SCRIPTS_3DE4="/mnt/Plugins/3DE/Scripts:$PYTHON_CUSTOM_SCRIPTS_3DE4"

export LD_LIBRARY_PATH="/usr/lib:/usr/lib64:/usr/local/lib:/usr/local/lib64:$LD_LIBRARY_PATH"
export CPATH="/usr/include:/usr/local/include:$CPATH"

export PYTHON_CUSTOM_SCRIPTS_3DE4__old=""
export SYNTHEYES_SCRIPT_PATH__old=""
export PYTHONPATH__old=""


function setDev() {

    read -r -p "SynthEyes Root: " SE_ROOT
    if [ ! -z "$SE_ROOT" ]
    then
        export SYNTHEYES_SCRIPT_PATH__old="$SYNTHEYES_SCRIPT_PATH"
        export SYNTHEYES_SCRIPT_PATH="$SE_ROOT"
    fi
    read -r -p "3DE Root: " TDE_ROOT
    if [ ! -z "$TDE_ROOT" ]
    then
        export PYTHON_CUSTOM_SCRIPTS_3DE4__old="$PYTHON_CUSTOM_SCRIPTS_3DE4"
        export PYTHON_CUSTOM_SCRIPTS_3DE4="$TDE_ROOT"
    fi

    read -r -p "Python Root: " PY_ROOT
    if [ ! -z "$PY_ROOT" ]
    then
        export PYTHONPATH__old="$PYTHONPATH"
        export PYTHONPATH="$PY_ROOT"
    fi

    export PS1="(dev) [\u@\h \W]\$ "

}


function setDefaultDev() {

    export SYNTHEYES_SCRIPT_PATH__old="$SYNTHEYES_SCRIPT_PATH"
    export SYNTHEYES_SCRIPT_PATH="/mnt/Profiles/jharvey@trackvfx.local/dev/TrackerConverter/SynthEyesPython"
    export PYTHON_CUSTOM_SCRIPTS_3DE4__old="$PYTHON_CUSTOM_SCRIPTS_3DE4"
    export PYTHON_CUSTOM_SCRIPTS_3DE4="/mnt/Profiles/jharvey@trackvfx.local/dev/TrackerConverter/3DEPython"
    export PYTHONPATH__old="$PYTHONPATH"
    export PYTHONPATH="/mnt/Profiles/jharvey@trackvfx.local/dev/TrackerConverter/python"
    export PS1="(dev) [\u@\h \W]\$ "

}

function unsetDev() {
    if [ ! -z "$PYTHON_CUSTOM_SCRIPTS_3DE4__old" ] 
    then
        export PYTHON_CUSTOM_SCRIPTS_3DE4="$PYTHON_CUSTOM_SCRIPTS_3DE4__old"
        export PYTHON_CUSTOM_SCRIPTS_3DE4__old=""
    fi

    if [ ! -z "$SYNTHEYES_SCRIPT_PATH__old" ] 
    then
        export SYNTHEYES_SCRIPT_PATH="$SYNTHEYES_SCRIPT_PATH__old"
        export SYNTHEYES_SCRIPT_PATH__old=""
    fi

    if [ ! -z "$PYTHONPATH__old" ] 
    then
        export PYTHONPATH="$PYTHONPATH__old"
        export PYTHONPATH__old=""
    fi

    export PS1="[\u@\h \W]\$ "

}

export PYTHONPATH='/mnt/Plugins/Python:/usr/local/lib64/python2.7/site-packages:/usr/local/lib/python2.7/site-packages:/mnt/Plugins/Python:/usr/local/lib64/python2.7/site-packages:$PYTHONPATH'
export PROGRAMS_ROOT="/mnt/Plugins/Programs"

alias release="sudo $PROGRAMS_ROOT/bin/release_package"

# /usr/lib64/python2.7/site-packages:
