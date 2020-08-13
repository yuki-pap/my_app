# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever
require File.expand_path(File.dirname(__FILE__) + "/environment")

set :path, "/var/www/rails/my_app/current"

set :output, "/var/www/rails/my_app/current/log/cron.log"

job_type :rake, 'cd :path && :environment_variable=:environment bundle exec rake :task :output'

every 1.day, at: '0:00 am' do
  rake "study:create_study RAILS_ENV=production"
end
