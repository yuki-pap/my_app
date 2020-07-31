
  $worker  = 2

  $timeout = 30

  $app_dir = "/var/www/rails/my_app/current"

  $listen  = File.expand_path 'tmp/sockets/.unicorn.sock', $app_dir

  $pid     = File.expand_path 'tmp/pids/unicorn.pid', $app_dir

  $std_log = File.expand_path 'log/unicorn.log', $app_dir


  before_exec do |server|
    ENV['BUNDLE_GEMFILE'] = File.expand_path('Gemfile', $app_dir)
  end

  worker_processes  $worker
  working_directory $app_dir
  stderr_path $std_log
  stdout_path $std_log
  timeout $timeout
  listen  $listen
  pid $pid


  preload_app true


  before_fork do |server, worker|
    defined?(ActiveRecord::Base) and ActiveRecord::Base.connection.disconnect!
    old_pid = "#{server.config[:pid]}.oldbin"
    if old_pid != server.pid
      begin
        Process.kill "QUIT", File.read(old_pid).to_i
      rescue Errno::ENOENT, Errno::ESRCH
      end
    end
  end

#fork後に行うことを定義。後述
  after_fork do |server, worker|
    defined?(ActiveRecord::Base) and ActiveRecord::Base.establish_connection
  end

  #Bundler::GemfileNotFound from unicornerror
  before_exec do |server|
    ENV["BUNDLE_GEMFILE"] = File.join(File.expand_path("../../../../../", __FILE__), "current", "Gemfile")
  end
