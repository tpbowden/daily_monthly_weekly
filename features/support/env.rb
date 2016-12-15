require "simplecov"
SimpleCov.start do
  coverage_dir "coverage/features"
end

require "tmpdir"
require "daily_weekly_monthly"

Mail.defaults do
  delivery_method :test
end

def backups_dir
  @backups_dir ||= Dir.mktmpdir
end

at_exit do
  FileUtils.remove_entry backups_dir
end
