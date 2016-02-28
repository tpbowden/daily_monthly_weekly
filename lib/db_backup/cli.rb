require "optparse"
require "db_backup"
require "pp"

module DbBackup
  class Cli
    def initialize args
      @options = {}
      @command = parse args
      raise "Please supply a command to run" if @command.empty?
      @command = @command.join(" ")
    end

    def call
      DbBackup.start @command, @options
    end

    private

    # rubocop : disable Metrics/MethodLength
    def parse args
      args.options do |opts|
        opts.banner = "Usage: start_backup \"database backup command\" [options]"
        parse_dir(opts)
        parse_ext(opts)
        parse_week_day(opts)
        parse_month_day(opts)
        parse_keep_days(opts)
        parse_keep_weeks(opts)
        parse_keep_months(opts)
        opts.parse!
      end

      args
    end

    def parse_keep_months opts
      opts.on("-M n", "--months-to-keep=n", "Monthly backups to keep", OptionParser::DecimalInteger) do |n|
        @options[:months_to_keep] = n
      end
    end

    def parse_keep_weeks opts
      opts.on("-W n", "--weeks-to-keep=n", "Weekly backups to keep", OptionParser::DecimalInteger) do |n|
        @options[:weeks_to_keep] = n
      end
    end

    def parse_keep_days opts
      opts.on("-D n", "--days-to-keep=n", "Daily backups to keep", OptionParser::DecimalInteger) do |n|
        @options[:days_to_keep] = n
      end
    end

    def parse_month_day opts
      opts.on("-m n", "--month-day=n", "Day of month to run on", OptionParser::DecimalInteger) do |n|
        @options[:day_of_month] = n
      end
    end

    def parse_ext opts
      opts.on("-e e", "--ext=e", "Backup file extension", String) do |e|
        @options[:output_extension] = e
      end
    end

    def parse_week_day opts
      opts.on("-w n", "--week-day=n", "Week day to run on", OptionParser::DecimalInteger) do |n|
        @options[:day_of_week] = n
      end
    end

    def parse_dir opts
      opts.on("-d d", "--dir=d", "Backups directory path", String) do |d|
        @options[:backups_dir] = d
      end
    end
  end
end
