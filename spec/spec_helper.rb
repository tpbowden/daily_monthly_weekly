require "codeclimate-test-reporter"
require "simplecov"

CodeClimate::TestReporter.configure do |config|
  config.logger.level = Logger::WARN
end

SimpleCov.start do
  formatter(
    SimpleCov::Formatter::MultiFormatter.new(
      [
        SimpleCov::Formatter::HTMLFormatter,
        CodeClimate::TestReporter::Formatter,
      ],
    ),
  )

  coverage_dir "coverage/rspec"
end
