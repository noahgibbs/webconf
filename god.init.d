#! /bin/sh
### BEGIN INIT INFO
# Provides:          god
# Required-Start:    $local_fs
# Required-Stop:     $local_fs
# Default-Start:     S
# Default-Stop:      0 6
# Short-Description: Start God daemon to run various processes
# Description        Start God, a process monitor, with various configurations
#                    to run web servers and similar Ruby daemons.
### END INIT INFO

[ -x /usr/local/bin/god ] || exit 0

RUBYOPT=rubygems
PATH=/usr/sbin:/usr/bin:/sbin:/bin:/usr/local/bin
. /lib/init/vars.sh

. /lib/lsb/init-functions

case "$1" in
  start|"")
	[ "$VERBOSE" = no ] || log_action_begin_msg "Initializing God process monitor"
        /usr/local/bin/god -c /home/angelbob/god/god.conf
	[ "$VERBOSE" = no ] || log_action_end_msg "Initialized God process monitor"
	;;
  stop)
	[ "$VERBOSE" = no ] || log_action_begin_msg "Shutting down God process monitor"
        /usr/local/bin/god terminate
	[ "$VERBOSE" = no ] || log_action_end_msg "Shut down God process monitor"
	;;
  restart|reload|force-reload)
	echo "Error: argument '$1' not supported" >&2
	exit 3
	;;
  *)
	echo "Usage: god start|stop" >&2
	exit 3
	;;
esac

:
