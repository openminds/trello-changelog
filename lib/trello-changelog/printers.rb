require 'trello-changelog/tickets'

class TrelloChangelog
  def print
    puts build_output
  end

  def build_output
    @output = ""
    build_summary
    build_labels
    build_unlabeled

    @output
  end

  def build_summary
    @output << "# Start date: #{start_date}\n\n"

    @output << "Created Trello items since #{start_date}: #{new_tickets_count}\n\n"
    @output << "Finished Trello items since #{start_date}: #{done_tickets_count}\n\n"
    @output << "Archived Trello items since #{start_date}: #{archived_tickets_count}\n\n"

    @output << "Summary: #{new_tickets_count} tickets in, #{done_tickets_count + archived_tickets_count} tickets out\n\n"
  end

  def build_labels
    for label_name in @config[:labels] do
      tickets_label_name = done_tickets.select { |ticket| ticket.labels.select { |label| label.name == label_name}.count > 0 }
      @output << "\n## #{label_name}:\n\n"
      tickets_label_name.each do |ticket|
        @output << " * [#{ticket.name}](#{ticket.url})\n"
      end
      @output << 'n.a.' if tickets_label_name.count == 0
    end
  end

  def build_unlabeled
    # We only list the cards that have none of the configured labels
    @unlabeled_done_tickets = done_tickets.select { |ticket| (ticket.labels.map(&:name) & @config[:labels]).empty? }

    @output << "\n## Other\n\n"
    @unlabeled_done_tickets.each do |ticket|
      @output << " * [#{ticket.name}](#{ticket.url})\n"
    end
  end
end
