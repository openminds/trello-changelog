require 'date'
require 'trello'

begin
  require '~/.trello-changelog.rb'
rescue LoadError
  puts 'File: ".trello-changelog.rb" was not found in your home directory!'
  exit
end


module Trello
  class Card < BasicData
    def creation_date
      epoch_from_id = self.id[0..7].hex
      DateTime.strptime(epoch_from_id.to_s,'%s')
    end
  end
end

class TrelloChangelog
  def initialize(start_date)

    Trello.configure do |trello_config|
      trello_config.developer_public_key = Variables::DEVKEY
      trello_config.member_token = Variables::MEM_TOKEN
    end

    @board = Trello::Board.find(Variables::BOARD)
    if(start_date == nil) 
    @start_date = Date.today - 6
    else
      begin
        @start_date = Date.parse start_date
        rescue ArgumentError
          puts 'The start date syntax is wrong. Possible correct syntax are: YYYY-MM-DD, DD-MM-YYYY, YYYY/MM/DD, DD/MM/YYYY, ... . Please try again.'
          exit
        end
    end
    @year = Date.today.year
    @done_list = @board.lists.select { |list| list.name == Variables::DONE_LIST_NAME }.last

    print
  end

  private

  def new_tickets
    @new_tickets ||= @board.cards.select { |card| card.creation_date >= @start_date}
  end

  def done_tickets
    @done_tickets ||= @board.cards.select { |card| card.list_id == @done_list.id }
  end

  def archived_tickets
    @archived_tickets ||= @board.cards( { filter: :all } ).select { |card| card.creation_date >= @start_date }.select { |card| card.closed == true } - archived_done_tickets
  end
  
  def archived_done_tickets
    @archived_done_tickets ||= @board.cards( { filter: :all } ).select { |card| card.creation_date >= @start_date }.select { |card| card.list_id == @done_list.id }.select { |card| card.closed == true }
  end

  def new_tickets_count
    new_tickets.count
  end

  def done_tickets_count
    done_tickets.count
  end

  def archived_tickets_count
    archived_tickets.count
  end

  def print
    puts "# Start date: #{@start_date}\n\n"

    puts "Created Trello items since #{@start_date}: #{new_tickets_count}\n\n"
    puts "Finished Trello items since #{@start_date}: #{done_tickets_count}\n\n"
    puts "Archived Trello items since #{@start_date}: #{archived_tickets_count}\n\n"

    puts "Summary: #{new_tickets_count} tickets in, #{done_tickets_count + archived_tickets_count} tickets out\n\n"

    for label_name in Variables::LABELS do
      tickets_label_name = done_tickets.select { |ticket| ticket.labels.select { |label| label.name == label_name}.count > 0 }
      puts "\n## #{label_name}:\n\n"
      tickets_label_name.each do |ticket|
        puts " * [#{ticket.name}](#{ticket.url})"
      end
      puts 'n.a.' if tickets_label_name.count == 0
    end
  end
end
