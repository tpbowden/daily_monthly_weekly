require "daily_weekly_monthly/runner"

module DailyWeeklyMonthly
  def self.start command, options
    Runner.new(command, options).call
  end
end
