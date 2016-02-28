require "spec_helper"
require "daily_weekly_monthly/processor"

describe DailyWeeklyMonthly::Processor do
  let(:backup) { double :backup }
  let(:dir) { double :dir }
  let(:ext) { double :ext }
  let(:creator) { double :creator, call: true }
  let(:cleaner) { double :cleaner, call: true }

  subject { described_class.new backup, dir, ext }

  before do
    allow(DailyWeeklyMonthly::Creator).to receive(:new).with(backup, dir, ext) { creator }
    allow(DailyWeeklyMonthly::Cleaner).to receive(:new).with(dir, ext) { cleaner }
  end

  describe "#call" do
    let(:period) { "weekly" }
    let(:options) { {keep: to_keep} }
    let(:to_keep) { 5 }

    it "calls the creator with the period" do
      expect(creator).to receive(:call).with(period)
      subject.call period, options
    end

    it "calls the cleaner with the period and number to keep" do
      expect(cleaner).to receive(:call).with(period, to_keep)
      subject.call period, options
    end
  end
end
