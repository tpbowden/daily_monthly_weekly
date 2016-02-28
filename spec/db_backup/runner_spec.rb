require "spec_helper"
require "db_backup/runner"

describe DbBackup::Runner do
  let(:command) { double :command }
  let(:downloader) { double :downloader }
  let(:backup) { double :backup }
  let(:backups_dir) { double :backups_dir }
  let(:ext) { double :ext }
  let(:processor) { double :processor, call: true }
  let(:options) {
    {
      backups_dir: backups_dir,
      output_extension: ext,
    }
  }

  subject { described_class.new command, options }

  before do
    allow(DbBackup::Downloader).to receive(:new).with(command) { downloader }
    allow(downloader).to receive(:call) { backup }
    allow(DbBackup::Processor).to receive(:new).with(backup, backups_dir, ext) { processor }
  end

  context "when the day of the month is backup day" do
    subject { described_class.new command, options.merge(day_of_month: Date.today.day) }

    it "runs the monthly backup" do
      expect(processor).to receive(:call).with("monthly", keep: 12)
      subject.call
    end
  end

  context "when the weekday is the backup day" do
    subject { described_class.new command, options.merge(day_of_week: Date.today.wday) }

    it "runs the weekly backup" do
      expect(processor).to receive(:call).with("weekly", keep: 5)
      subject.call
    end
  end

  it "runs the daily backup" do
    expect(processor).to receive(:call).with("daily", keep: 7)
    subject.call
  end
end
