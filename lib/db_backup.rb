require "db_backup/runner"

module DbBackup
  def self.start command, options
    Runner.new(command, options).call
  end
end
