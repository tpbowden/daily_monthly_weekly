# frozen_string_literal: true
$LOAD_PATH.unshift File.expand_path("../lib", __FILE__)
require "daily_weekly_monthly/version"

Gem::Specification.new do |s|
  s.name = "daily_weekly_monthly"
  s.version = DailyWeeklyMonthly::VERSION
  s.date = "2016-02-28"
  s.summary = "Manage database backups"
  s.description = "Automatically manage daily, weekly and monthly database backups"
  s.authors = ["Tom Bowden"]
  s.files = `git ls-files`.split($RS)
  s.bindir = "bin"
  s.executables = "daily_weekly_monthly"
  s.email = "tom.b1992@gmail.com"
  s.homepage = "http://github.com/tpbowden/daily_weekly_monthly"
  s.license = "MIT"
  s.required_ruby_version = ">= 2.0.0"

  s.add_dependency "mail", ">= 2.6"

  s.add_development_dependency "rake", ">= 10.4"
  s.add_development_dependency "rubocop", ">= 0.35"
  s.add_development_dependency "rspec", ">= 3.4"
  s.add_development_dependency "simplecov", ">= 0.11"
  s.add_development_dependency "cucumber", ">= 2.0"
  s.add_development_dependency "codeclimate-test-reporter", ">= 0.4"
end
