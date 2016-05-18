require 'date'
require 'trello'
require 'trello-changelog/config'
require 'trello-changelog/printers'
require 'active_support/core_ext/hash/indifferent_access'

class TrelloChangelog
  def initialize(options)
    @options = options.with_indifferent_access

    load_config_file
    configure_trello
    start_date(@options[:start_date])

    print
  end
end
