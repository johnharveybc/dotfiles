# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions

export PATH="~/bin:$PATH"
alias config='/usr/bin/git --git-dir=/mnt/Profiles/jharvey@trackvfx.local/.cfg/ --work-tree=/mnt/Profiles/jharvey@trackvfx.local'
