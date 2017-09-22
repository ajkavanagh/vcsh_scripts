#/bin/bash

set -e
# Check for, and set up 6 windows in tmux such that:
#
# 0  - 'juju' - runs ./watch-juju-stat.sh
# 1  - 'hosts' - runs ./watch-hosts.sh
# 2  - 'nova' - runs ./watch-nova.sh
# 3  - 'edit' - just ensures that the window is created and named.
# 4  - 'run' - just ensures that the window is created and named.
# 5  - 'other' - just ensures that the window is created and named.
#
# Also ensures that in each of the windows the ~/novarc file has been sourced.

function create_if_needed {
	local _window_number=$1
	local _window_title=$2
	local _line=$(tmux list-windows | egrep "^${_window_number}:")
	echo $_line
	if [ "xxx${_line}" == "xxx" ]; then
		echo "Not Found"
		tmux new-window -t ":${_window_number}" -n ${_window_title}
	else
		echo "Found making sure it is named ${_window_title}"
		tmux rename-window -t ":${_window_number}" ${_window_title}
	fi
}


# Ensure that the windows are created and that they are named correctly.
create_if_needed "0" "juju"
create_if_needed "1" "hosts"
create_if_needed "2" "nova"
create_if_needed "3" "edit"
create_if_needed "4" "run"
create_if_needed "5" "other"

# now ensure that all the windows have sourced ~/novarc and that the first three are running
# their programs.
NOVARC="source $HOME/novarc"
BEISNER_SCRIPTS="$HOME/beiser-yunk-yard/serverstack-scripts"
JUJU_STAT="$BEISNER_SCRIPTS/watch-juju-stat.sh"
NOVA="$BEISNER_SCRIPTS/watch-nova.sh"
HOSTS="$BEISNER_SCRIPTS/watch-hosts.sh"

tmux send-keys -t :0 C-c; tmux send-keys -t :0 "$NOVARC" C-m; tmux send-keys -t :0  "$JUJU_STAT" C-m
tmux send-keys -t :1 C-c; tmux send-keys -t :1 "$NOVARC" C-m; tmux send-keys -t :1  "$HOSTS" C-m
tmux send-keys -t :2 C-c; tmux send-keys -t :2 "$NOVARC" C-m; tmux send-keys -t :2  "$NOVA" C-m

tmux select-window -t :0
