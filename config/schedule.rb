# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
set :output, 'log/cron.log'
env :PATH, ENV['PATH']
ENV.each { |k, v| env(k, v) }

every 1.minutes do
  rake 'weightable:weight:update'
end

# Learn more: http://github.com/javan/whenever
