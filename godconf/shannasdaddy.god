# Keeps Shanna's Daddy Software mongrel processes running

RAILS_ROOT = "/home/www/checkouts/shannasdaddy"

%w{8300 8301}.each do |port|
  God.watch do |w|
    w.name = "sds-mongrel-#{port}"
    w.uid = 'www'
    w.gid = 'www'
    w.interval = 30.seconds # default      
    w.start = "cd #{RAILS_ROOT} && mongrel_rails start -c #{RAILS_ROOT} -p #{port} \
-P #{RAILS_ROOT}/log/mongrel.#{port}.pid -l #{RAILS_ROOT}/log/mongrel.#{port}.log -d -e production"
    w.stop = "mongrel_rails stop -P #{RAILS_ROOT}/log/mongrel.#{port}.pid"
    w.restart = "mongrel_rails restart -P #{RAILS_ROOT}/log/mongrel.#{port}.pid"
    w.start_grace = 10.seconds
    w.restart_grace = 10.seconds
    w.pid_file = "#{RAILS_ROOT}/log/mongrel.#{port}.pid"
    
    w.behavior(:clean_pid_file)

    w.start_if do |start|
      start.condition(:process_running) do |c|
        c.interval = 5.seconds
        c.running = false
      end
    end
    
    w.restart_if do |restart|
      restart.condition(:memory_usage) do |c|
        c.above = 150.megabytes
        c.times = [3, 5] # 3 out of 5 intervals
      end
    
      restart.condition(:cpu_usage) do |c|
        c.above = 50.percent
        c.times = 5
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
end