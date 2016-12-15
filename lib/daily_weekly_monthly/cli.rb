require "optparse"
require "daily_weekly_monthly"

module DailyWeeklyMonthly
  class Cli
    OPTIONS = [
      :dir,
      :ext,
      :week_day,
      :month_day,
      :keep_days,
      :keep_weeks,
      :keep_months,
      :smtp_server,
      :smtp_port,
      :notify,
    ].freeze

    def initialize args
      @options = {}
      @command = parse args
      raise "Please supply a command to run" if @command.empty?
      @command = @command.join(" ")
    end

    def call
      DailyWeeklyMonthly.start @command, @options
    end

    private

    def parse args
      args.options do |opts|
        opts.banner = "Usage: daily_weekly_monthly \"database backup command\" [options]"
        parse_all_options(opts)
      end
      args
    end

    def parse_all_options opts
      OPTIONS.each do |option|
        send("parse_#{option}", opts)
      end
      opts.parse!
    end

    def parse_keep_months opts
      opts.on("-M n", "--months-to-keep=n", "Monthly backups to keep", OptionParser::DecimalInteger) do |n|
        @options[:months_to_keep] = n
      end
    end

    def parse_smtp_server opts
      opts.on("-s s", "--smtp-server=s", "SMTP server for notifications", String) do |s|
        @options[:smtp_server] = s
      end
    end

    def parse_smtp_port opts
      opts.on("-p p", "--smtp-server=p", "SMTP port for notifications", OptionParser::DecimalInteger) do |p|
        @options[:smtp_port] = p
      end
    end

    def parse_notify opts
      opts.on("-n s", "--notify=s", "Notification email address", String) do |s|
        @options[:notify] = s
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
