require "English"

module DbBackup
  class Downloader
    def initialize backup_command
      @backup_command = backup_command
    end

    def call
      result = `#{@backup_command}`
      raise "Failed to download backup" unless $CHILD_STATUS == 0
      result
    end
  end
end
