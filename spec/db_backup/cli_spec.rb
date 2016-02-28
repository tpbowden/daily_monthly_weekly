require "spec_helper"
require "db_backup/cli"

describe DbBackup::Cli do
  describe "#call" do
    subject { described_class.new ARGV }

    context "when no command is given" do
      before do
        ARGV.replace []
      end

      it "raises an error" do
        expect { subject.call }.to raise_error RuntimeError, "Please supply a command to run"
      end
    end

    context "with arguments and a command" do
      before do
        ARGV.replace [
          "-M", "5",
          "-W", "3",
          "-D", "2",
          "-m", "1",
          "-e", "foo",
          "-w", "2",
          "-d", "bar",
          "some", "command"
        ]
      end

      it "passes the parsed arguments and command to DbBackup.start" do
        expect(DbBackup).to receive(:start).with("some command", months_to_keep: 5,
                                                                 weeks_to_keep: 3,
                                                                 days_to_keep: 2,
                                                                 day_of_month: 1,
                                                                 output_extension: "foo",
                                                                 day_of_week: 2,
                                                                 backups_dir: "bar")
        subject.call
      end
    end
  end
end
