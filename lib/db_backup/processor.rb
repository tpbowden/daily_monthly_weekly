require "db_backup/creator"
require "db_backup/cleaner"

module DbBackup
  class Processor
    def initialize backup, backups_dir, output_extension
      @backup = backup
      @creator = Creator.new backup, backups_dir, output_extension
      @cleaner = Cleaner.new backups_dir, output_extension
    end

    def call period, options
      @creator.call period
      @cleaner.call period, options.fetch(:keep)
    end
  end
end
