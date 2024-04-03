# Start writting your code here
# require 'csv'

# # Reading data from the CSV file
# CSV.foreach('emails.csv', headers: true) do |row|
#   process_email(row['Date'], row['From'], row['Subject'])
# end



#Task 1 and 2

class Email
  
    def initialize(subject, header)
      @subject = subject
      @header = header
    end
    
    def subject
      @subject
    end
    
  
    def date
      @header[:date]
    end
  
    def from
      @header[:from]
    end
  
    def output
      puts "Date:".ljust(10) + "#{date}"
      puts "From:".ljust(10) + "#{from}"
      puts "Subject:".ljust(10) + "#{subject}"
    end
  
  end
  
  #Task 3
  class Mailbox
      def initialize(name, emails)
        @name = name
        @emails = emails
      end
  
      def name
        @name
      end
        
      def emails
        @emails
      end  
  
  end
  
  
  
  #create email array as in the last exercise
  emails = [
    Email.new("Homework this week", { :date => "2014-12-01", :from => "Ferdous"}),
    Email.new("Keep on coding! :)", { :date => "2014-12-01", :from => "Dajana"}),
    Email.new("Re: Homework this week", { :date => "2014-12-02", :from => "Ariane"})
  ]
  #create mailbox as before
  mailbox = Mailbox.new("Ruby Study Group", emails)
  
  
  #Task 4: Mailbox Text Formatter
  class MailboxTextFormatter
    def initialize(mailbox)
      @mailbox = mailbox
      @title = mailbox.name
      calculate_max_lengths
    end
    
    def calculate_max_lengths
      @max_date_length = @mailbox.emails.map { |email| email.date.length }.max
      @max_from_length = @mailbox.emails.map { |email| email.from.length }.max
      @max_subject_length = @mailbox.emails.map { |email| email.subject.length }.max
    end
    
    def header
      puts "+#{'-' * (@max_date_length + 2)}+#{'-' * (@max_from_length + 2)}+#{'-' * (@max_subject_length + 2)}+"
      puts "| Date#{' ' * (@max_date_length - 4)} | From#{' ' * (@max_from_length - 4)} | Subject#{' ' * (@max_subject_length - 7)} |"
      puts "+#{'-' * (@max_date_length + 2)}+#{'-' * (@max_from_length + 2)}+#{'-' * (@max_subject_length + 2)}+"
    end
  
    def rows
      @mailbox.emails.each do |mail| 
        puts "| #{mail.date.ljust(@max_date_length)} | #{mail.from.ljust(@max_from_length)} | #{mail.subject.ljust(@max_subject_length)} |"
      end
    end
  
    def footer
      puts "+#{'-' * (@max_date_length + 2)}+#{'-' * (@max_from_length + 2)}+#{'-' * (@max_subject_length + 2)}+"
    end
  
    def format
      puts "Mailbox: #{@title}\n\n"
      header
      rows
      footer
    end
  end
  
  formatter = MailboxTextFormatter.new(mailbox)
  formatter.format
  
  
  
  
  
  
  