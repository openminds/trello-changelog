require 'date'
require 'trello'
require 'trello-changelog/config'
require 'trello-changelog/printers'

class TrelloChangelog
  def initialize(date)
    load_config_file
    configure_trello
    start_date date

    print
  end
end
