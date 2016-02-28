require "simplecov"
SimpleCov.start

require "tmpdir"
require "db_backup"

def backups_dir
  @backups_dir ||= Dir.mktmpdir
end

at_exit do
  FileUtils.remove_entry backups_dir
end
