class TrelloChangelog
  private

  def load_config_file
    @config = HashWithIndifferentAccess.new(labels: [])
    if %w(devkey mem_token board done_list_name).all? { |key| @options.has_key?(key) }
      puts "Config set via cli, ~/.trello-changelog.rb not loaded"
      @options.each { |key, value| @config[key] = value }
      return true
    end
    begin
      require '~/.trello-changelog.rb'
      @config[:devkey] = Variables::DEVKEY
      @config[:mem_token] = Variables::MEM_TOKEN
      @config[:board] = Variables::BOARD
      @config[:done_list_name] = Variables::DONE_LIST_NAME
      @config[:labels] = Variables::LABELS || []
    rescue LoadError
      puts 'File: ".trello-changelog.rb" was not found in your home directory! See README on Github.'
      exit
    end
  end

  def configure_trello
    Trello.configure do |trello_config|
      trello_config.developer_public_key = @config[:devkey]
      trello_config.member_token = @config[:mem_token]
    end
  end

  def start_date(start_date=@start_date)
    @start_date ||= \
      if(start_date == nil)
        Date.today - 6
      else
        begin
          Date.parse(start_date)
        rescue ArgumentError
          puts 'The start date syntax is wrong. Possible correct syntax are:'\
            'YYYY-MM-DD, DD-MM-YYYY, YYYY/MM/DD, DD/MM/YYYY, ... . Please try again.'
          exit
        end
      end
  end
end
