require "mail"

module DailyWeeklyMonthly
  class Notifier
    def initialize smtp_server, smtp_port
      @smtp_server = smtp_server
      @smtp_port = smtp_port
    end

    # rubocop: disable Metrics/MethodLength
    def call exception, deliver_to
      mail = Mail.new {
        from "backups@localhost"
        to deliver_to
        subject "Backup failed"
        body <<EOF
Backup failure

#{exception.message}

#{exception.backtrace.join("\n")}
EOF
      }
      mail.delivery_method :smtp, address: @smtp_server, port: @smtp_port if @smtp_server && @smtp_port
      mail.deliver
    end
    # rubocop: enable all
  end
end
