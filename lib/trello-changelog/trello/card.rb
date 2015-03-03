module Trello
  class Card < BasicData
    def creation_date
      epoch_from_id = self.id[0..7].hex
      DateTime.strptime(epoch_from_id.to_s,'%s')
    end
  end
end
