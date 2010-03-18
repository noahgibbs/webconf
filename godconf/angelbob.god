# run with:  god -c /path/to/file/angelbob.god
# 
# Keeps the Angelbob blog's mongrel processes running

AB_RAILS_ROOT = "/home/angelbob/deploy/blog"
ENV['BLOG_PASSWORD'] = "Opus23HE"

%w{5000}.each do |port|
  God.watch do |w|
    w.name = "angelbob-mongrel-#{port}"
    w.interval = 30.seconds # default      
    w.start = "mongrel_rails start -c #{AB_RAILS_ROOT} -p #{port} \
      -P #{AB_RAILS_ROOT}/log/mongrel.#{port}.pid  -d -e production"
    w.stop = "mongrel_rails stop -P #{AB_RAILS_ROOT}/log/mongrel.#{port}.pid"
    w.restart = "mongrel_rails restart -P #{AB_RAILS_ROOT}/log/mongrel.#{port}.pid"
    w.start_grace = 10.seconds
    w.restart_grace = 10.seconds
    w.pid_file = File.join(AB_RAILS_ROOT, "log/mongrel.#{port}.pid")

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
