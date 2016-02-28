Given "it is the correct day for daily backups" do
  # noop
end

Given "it is the correct day for weekly backups" do
  @weekly_backup_day = Date.today.wday
end

Given "it is the correct day for monthly backups" do
  @monthly_backup_day = Date.today.day
end

Given(/there are old (.+) backups/) do |period|
  FileUtils.mkdir_p File.join(backups_dir, period)

  %w(2001 2002 2003 2004 2005 2006 2007 2008 2009 2010).each do |year|
    File.write(File.join(backups_dir, period, "#{year}-01-01.pgdump.gz"), "foo\n")
  end
end

When "I run the backups" do
  DbBackup.start("echo 'foo';", backups_dir:  backups_dir,
                                day_of_week: @weekly_backup_day || 1,
                                day_of_month: @monthly_backup_day || 1,
                                days_to_keep: 3,
                                weeks_to_keep: 3,
                                months_to_keep: 3)
end

Then(/I can see a (.+) backup file/) do |period|
  expect(File.exist?(File.join(backups_dir, period, "#{Date.today.iso8601}.pgdump.gz"))).to be true
end

Then(/the (.+) backup file contains the backup command contents/) do |period|
  expect(File.read(File.join(backups_dir, period, "#{Date.today.iso8601}.pgdump.gz"))).to eq "foo\n"
end

Then(/the old (.+) backups have been removed/) do |period|
  files = Dir[File.join(backups_dir, period, "*.pgdump.gz")].map {|f| File.basename f }
  expect(files).to match_array [
    "2009-01-01.pgdump.gz",
    "2010-01-01.pgdump.gz",
    "#{Date.today.iso8601}.pgdump.gz",
  ]
end
