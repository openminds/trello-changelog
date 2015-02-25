require 'date'
require 'trello'

module Trello
  class Card < BasicData
    def creation_date
      epoch_from_id = self.id[0..7].hex
      DateTime.strptime(epoch_from_id.to_s,'%s')
    end
  end
end

class TrelloChangelog
  def initialize(week)
    config = []
    config_lines = File.readlines(File.join(File.expand_path('~'), '.trello-changelog'))
    config_lines.each do |line|
      config << line.split("'").values_at(1)
    end

    config.flatten!

    Trello.configure do |trello_config|
      trello_config.developer_public_key =  config[0]
      trello_config.member_token = config[1]
    end

    @board = Trello::Board.find(config[2])
    @week = week
    @year = Date.today.year
    @done_list = @board.lists.select { |list| list.name == config[3] }.last

    print(config)
  end

  private

  def new_tickets
    @new_tickets ||= @board.cards.select { |card| card.creation_date.cweek == @week }
  end

  def done_tickets
    @done_tickets ||= @board.cards.select { |card| card.list_id == @done_list.id }
  end

  def archived_tickets
    @archived_tickets ||= @board.cards( { filter: :all } ).select { |card| card.creation_date.cweek == @week }.select { |card| card.closed == true }
  end

  def done_feature_tickets
    @done_feature_tickets ||=
      done_tickets.select { |ticket| ticket.labels.select { |label| label.name == 'feature' }.count > 0 }
  end

  def done_bug_tickets
    @done_bug_tickets ||=
      done_tickets.select { |ticket| ticket.labels.select { |label| label.name == 'bug' }.count > 0 }
  end

  def done_postmortem_tickets
    @done_postmortem_tickets ||=
      done_tickets.select { |ticket| ticket.labels.select { |label| label.name == 'postmortem' }.count > 0 }
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

  def print(config)
    puts "# Week #{@week}\n\n"

    puts "Created Trello items this week: #{new_tickets_count}\n\n"
    puts "Finished Trello items this week: #{done_tickets_count}\n\n"
    puts "Archived Trello items this week: #{archived_tickets_count}\n\n"

    puts "Summary: #{new_tickets_count} tickets in, #{done_tickets_count + archived_tickets_count} tickets out\n\n"

    puts "\n## #{config[4]}:\n\n"
    done_feature_tickets.each do |ticket|
      puts " * [#{ticket.name}](#{ticket.url})"
    end
    puts 'n.a.' if done_feature_tickets.count == 0

    puts "\n## #{config[5]}:\n\n"
    done_bug_tickets.each do |ticket|
      puts " * [#{ticket.name}](#{ticket.url})"
    end
    puts 'n.a.' if done_bug_tickets.count == 0

    puts "\n## #{config[6]}:\n\n"
    done_postmortem_tickets.each do |ticket|
      puts " * [#{ticket.name}](#{ticket.url})"
    end

    puts 'n.a.' if done_postmortem_tickets.count == 0
  end
end
