require "spec_helper"
require "daily_weekly_monthly/downloader"

describe DailyWeeklyMonthly::Downloader do
  describe "#call" do
    context "when the command fails" do
      subject { described_class.new "echo 'foo' && exit 1" }

      it "raises a runtime error" do
        expect { subject.call }.to raise_error RuntimeError, "Failed to download backup: foo\n"
      end
    end

    context "when the command succeeds" do
      subject { described_class.new "echo 'foo'" }

      it "returns the output of the command" do
        expect(subject.call).to eq "foo\n"
      end
    end
  end
end
