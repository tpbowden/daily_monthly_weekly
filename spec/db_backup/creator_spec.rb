require "spec_helper"
require "db_backup/creator"

describe DbBackup::Creator do
  let(:backup) { "some content" }
  let(:backups_dir) { Dir.mktmpdir }
  let(:ext) { "txt" }

  subject { described_class.new backup, backups_dir, ext }

  describe "#call" do
    it "writes a file using today's date into the correct backup directory" do
      subject.call "weekly"
      expect(File.read(File.join(backups_dir, "weekly", "#{Date.today.iso8601}.#{ext}"))).to eq backup
    end
  end

  after do
    FileUtils.remove_entry backups_dir
  end
end
