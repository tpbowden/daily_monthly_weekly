require "spec_helper"
require "db_backup/downloader"

describe DbBackup::Downloader do
  describe "#call" do
    context "when the command fails" do
      subject { described_class.new "commandThatAlwaysFails 2> /dev/null" }

      it "raises a runtime error" do
        expect { subject.call }.to raise_error RuntimeError, "Failed to download backup"
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
