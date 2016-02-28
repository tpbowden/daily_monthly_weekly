require "fileutils"
require "date"

module DbBackup
  class Creator
    def initialize backup, backups_dir, output_extension
      @backup = backup
      @backups_dir = backups_dir
      @output_extension = output_extension
    end

    def call dir
      FileUtils.mkdir_p File.join(@backups_dir, dir)
      output_path = File.join(@backups_dir, dir, "#{Date.today.iso8601}.#{@output_extension}")
      File.write output_path, @backup
    end
  end
end
