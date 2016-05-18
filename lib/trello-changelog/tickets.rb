require 'trello-changelog/trello/card'

class TrelloChangelog
  def board
    @board ||= Trello::Board.find(@config[:board])
  end

  def done_list
    @done_list ||= board.lists.select { |list| list.name == @config[:done_list_name] }.last
  end

  def new_tickets
    @new_tickets ||= board.cards.select { |card| card.creation_date >= start_date}
  end

  def done_tickets
    @done_tickets ||= board.cards.select { |card| card.list_id == done_list.id }
  end

  def archived_tickets
    @archived_tickets ||= board.cards( { filter: :all } ).select { |card| card.creation_date >= start_date }.select { |card| card.closed == true } - archived_done_tickets
  end

  def archived_done_tickets
    @archived_done_tickets ||= board.cards( { filter: :all } ).select { |card| card.creation_date >= start_date }.select { |card| card.list_id == done_list.id }.select { |card| card.closed == true }
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
end
