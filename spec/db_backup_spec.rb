require "spec_helper"
require "db_backup"

describe DbBackup do
  describe ".start" do
    let(:runner) { double :runner }
    let(:command) { double :command }
    let(:options) { double :options }

    before do
      allow(DbBackup::Runner).to receive(:new).with(command, options) { runner }
    end

    it "passes the arguments to the runner" do
      expect(runner).to receive(:call)
      described_class.start command, options
    end
  end
end
