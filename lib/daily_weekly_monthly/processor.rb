require "daily_weekly_monthly/creator"
require "daily_weekly_monthly/cleaner"

module DailyWeeklyMonthly
  class Processor
    def initialize backup, backups_dir, output_extension
      @backup = backup
      @creator = Creator.new backup, backups_dir, output_extension
      @cleaner = Cleaner.new backups_dir, output_extension
    end

    def call period, options
      @creator.call period
      @cleaner.call period, options.fetch(:keep)
    end
  end
end
