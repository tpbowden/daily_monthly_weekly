require "English"

module DailyWeeklyMonthly
  class Downloader
    def initialize backup_command
      @backup_command = backup_command
    end

    def call
      result = `#{@backup_command}`
      raise "Failed to download backup: #{result}" unless $CHILD_STATUS.exitstatus.zero?
      result
    end
  end
end
