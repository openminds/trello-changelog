class TrelloChangelog
  private

  def load_config_file
    begin
      require '~/.trello-changelog.rb'
    rescue LoadError
      puts 'File: ".trello-changelog.rb" was not found in your home directory! See README on Github.'
      exit
    end
  end

  def configure_trello
    Trello.configure do |trello_config|
      trello_config.developer_public_key = Variables::DEVKEY
      trello_config.member_token = Variables::MEM_TOKEN
    end
  end

  def start_date(start_date=@start_date)
    @start_date ||= \
      if(start_date == nil)
        Date.today - 6
      else
        begin
          Date.parse start_date
        rescue ArgumentError
          puts 'The start date syntax is wrong. Possible correct syntax are:'\
            'YYYY-MM-DD, DD-MM-YYYY, YYYY/MM/DD, DD/MM/YYYY, ... . Please try again.'
          exit
        end
      end
  end
end
