require "fileutils"

module DailyWeeklyMonthly
  class Cleaner
    def initialize backups_dir, output_extension
      @backups_dir = backups_dir
      @output_extension = output_extension
    end

    def call dir, number_to_keep
      old_backups(dir, number_to_keep).each do |file|
        FileUtils.rm file
      end
    end

    def old_backups dir, number_to_keep
      Dir[File.join(@backups_dir, dir, "*.#{@output_extension}")]
        .sort
        .reverse
        .drop(number_to_keep)
    end
  end
end
