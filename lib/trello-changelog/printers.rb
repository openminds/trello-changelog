require 'trello-changelog/tickets'

class TrelloChangelog
  def print
    print_summary
    print_labels
  end

  def print_summary
    puts "# Start date: #{start_date}\n\n"

    puts "Created Trello items since #{start_date}: #{new_tickets_count}\n\n"
    puts "Finished Trello items since #{start_date}: #{done_tickets_count}\n\n"
    puts "Archived Trello items since #{start_date}: #{archived_tickets_count}\n\n"

    puts "Summary: #{new_tickets_count} tickets in, #{done_tickets_count + archived_tickets_count} tickets out\n\n"
  end

  def print_labels
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
