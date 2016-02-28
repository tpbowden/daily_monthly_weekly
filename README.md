# Daily Weekly Monthly

Keep your data safe by backing up on a daily, weekly and monthly basis.

This tool allows you to take regular backups whilst automatically removing old ones.
Backups are stored in <backup location>/(daily|weekly|monthly), and files are named using
the format YYYY-MM-DD.<extension>

## Installation

Using bundler:

```ruby
gem "daily_weekly_monthly"
```

CLI: 

```sh
gem install daily_weekly_monthly
```

## Use

To use in your code, there is a single wrapper function to call:

```ruby
DailyWeeklyMonthly.start(backup_command, options)
```

Where backup command is a string of the shell command you wish to run to get the database backup (to STDOUT),
and options are a hash of options which are explained in detail below.


### CLI

To use from the command line, just run the following after installing the gem:

    daily_weekly_monthly "your backup command" [options]

Again, the options are explained below.


## Configuration

Config is passed to the gem as a hash, with all possible options, their defaults and command line flags:

```ruby
{
  backups_dir: "~/backups", # Where on the file system to store the backups
  output_extension: "pgdump.gz", # File extension to be appended to each backup
  day_of_week: 1, # Which day of the week to run weekly backups (0 - 6 where 0 is Sunday and 6 is Saturday)
  day_of_month: 1, # Which day in the month to run monthly backups
  days_to_keep: 7, # Number of daily backups to store
  weeks_to_keep: 5, # Number of weekly backups to store
  months_to_keep: 12, # Number of monthly backups to store
}
```

### Command line arguments

    -d, --dir=d                      Backups directory path
    -e, --ext=e                      Backup file extension
    -w, --week-day=n                 Week day to run on
    -m, --month-day=n                Day of month to run on
    -D, --days-to-keep=n             Daily backups to keep
    -W, --weeks-to-keep=n            Weekly backups to keep
    -M, --months-to-keep=n           Monthly backups to keep 
