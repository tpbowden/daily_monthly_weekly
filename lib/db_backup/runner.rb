require "db_backup/processor"
require "db_backup/downloader"

module DbBackup
  class Runner
    DEFAULTS = {
      backups_dir: File.expand_path("~/backups"),
      output_extension: "pgdump.gz",
      day_of_week: 1,
      day_of_month: 1,
      days_to_keep: 7,
      weeks_to_keep: 5,
      months_to_keep: 12,
    }.freeze

    def initialize backup_command, options = {}
      @backup_command = backup_command
      @options = DEFAULTS.merge(options)
    end

    def call
      processor = Processor.new(backup, @options[:backups_dir], @options[:output_extension])
      processor.call("daily", keep: @options[:days_to_keep])
      processor.call("weekly", keep: @options[:weeks_to_keep]) if weekly_backup?
      processor.call("monthly", keep: @options[:months_to_keep]) if monthly_backup?
    end

    private

    def weekly_backup?
      Date.today.wday == @options[:day_of_week]
    end

    def monthly_backup?
      Date.today.day == @options[:day_of_month]
    end

    def backup
      Downloader.new(@backup_command).call
    end
  end
end
