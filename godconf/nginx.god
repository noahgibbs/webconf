# run with:  god -c /path/to/file/nginx.god
# 
# Keeps WantMyJob's main server process running

nginx_bin = "/usr/local/nginx/sbin/nginx"
nginx_config = "/home/www/checkouts/webconf/nginx.conf"

God.watch do |w|
  w.name = "nginx"
  w.interval = 30.seconds # default      
  w.start = "#{nginx_bin} -c #{nginx_config}"
  w.stop = "kill `cat /home/www/pids/nginx.pid`; killall nginx"
  w.pid_file = "/home/www/pids/nginx.pid"
  w.start_grace = 10.seconds
  w.restart_grace = 10.seconds

  w.behavior(:clean_pid_file)

  w.start_if do |start|
    start.condition(:process_running) do |c|
      c.interval = 5.seconds
      c.running = false
    end
  end

  # lifecycle
  w.lifecycle do |on|
    on.condition(:flapping) do |c|
      c.to_state = [:start, :restart]
      c.times = 5
      c.within = 5.minute
      c.transition = :unmonitored
      c.retry_in = 10.minutes
      c.retry_times = 5
      c.retry_within = 2.hours
    end
  end
end
