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
      @name = mailbox.name
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
      puts "Mailbox: #{@name}\n\n"
      header
      rows
      footer
    end
  end
  
  #Task 5: Test the MailboxHtmlFormatter

  class MailboxHtmlFormatter
    def initialize(mailbox)
      @mailbox = mailbox
    end

    def headline
      tag(:h1, @mailbox.name)
    end  

    # enclosing head and body in html tag
    def format
      tag(:html, [head, body].join("\n"))
    end

    #  enclosing body tag
    def body
      tag(:body, [headline, table].join("\n"))
    end

    # enclosing table tag
    def table
      tag(:table , [thead, tbody].join("\n"))
    end

    # enclosing thead tag
    def thead
      tag(:thead, ths.join("\n"))
    end  

    # adding table headers
    def ths
      headers = ["Date", "From", "Subject"]
      headers.map {|header_name| tag(:th, header_name)} 
    end

    # enclosing tbody tag 
    def tbody
      tag(:tbody, trs.join("\n"))
    end  

    # iterating table rows
    def trs
      rows.map { |row| tr(row) }
    end

    # enclosing table row tag
    def tr(row)
      tag(:tr, tds(row).join("\n"))
    end 
    
    # enclosing table data tag
    def tds(row)
      row.collect { |content| tag(:td, content)}
    end

    # enclosing tag around content
    def tag (name, content)
      content = "\n#{content}\n" unless [:h1, :td, :th].include?(name)
      html = "<#{name}>#{content}</#{name}>"
      html = indent(html) unless name == :html
      html
    end

    # splitting, adding 2 spaces before and then joining
    def indent(html)
      lines = html.split("\n")
      lines = lines.map {|line| " " * 2 + line}
      lines.join("\n")
    end

    # individual mail element
    def rows
      @mailbox.emails.map do |email|
        [email.date, email.from, email.subject]
      end
    end
    
    
    # html header 
    def head
      "<head>
        <style>
          table {
            border-collapse: collapse;
          }
          td, th {
            border: 1px solid black;
            padding: 1em;
          }
        </style>
      </head>"
    end
    
  end
  
  emails = [
    Email.new("Homework this week", { :date => "2014-12-01", :from => "Ferdous"}),
    Email.new("Keep on coding! :)", { :date => "2014-12-01", :from => "Dajana"}),
    Email.new("Re: Homework this week", { :date => "2014-12-02", :from => "Ariane"})
  ]
  mailbox = Mailbox.new("Ruby Study Group", emails)
  formatter = MailboxHtmlFormatter.new(mailbox)
  
  
  File.write("emails.html", formatter.format)
  
  
  
  