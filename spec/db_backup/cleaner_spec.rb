require "spec_helper"
require "tmpdir"
require "db_backup/cleaner"

describe DbBackup::Cleaner do
  let(:backups_dir) { Dir.mktmpdir }
  let(:ext) { "txt" }

  subject { described_class.new backups_dir, ext }

  describe "#call" do
    before do
      FileUtils.mkdir_p(File.join backups_dir, "weekly")
      %w(2015 2016 2017 2016 2017 2018 2019 2020).each do |year|
        File.write File.join(backups_dir, "weekly", "#{year}-01-01.txt"), "some content"
      end
    end

    it "removes all files except the newest N from the target directory" do
      subject.call "weekly", 2
      expect(Dir[File.join(backups_dir, "weekly", "*.#{ext}")].map { |f|
        File.basename(f)
      }).to match_array ["2020-01-01.txt", "2019-01-01.txt"]
    end
  end

  after do
    FileUtils.remove_entry backups_dir
  end
end
