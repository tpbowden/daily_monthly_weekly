require "db_backup/runner"

Before do
  $backups_dir ||= Dir.mktmpdir
end

at_exit do
  FileUtils.remove_entry $backups_dir
end

