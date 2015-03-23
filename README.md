# README
---------

Trello-changelog summarizes your Trello-board.
It uses your done list to make a changelog of your Trello-board, which includes a count of new tickets, done tickets, archived tickets and a summarization of bugs, features etc...
It's possible to use your own Trello labels.

Example output:

--------
![trello-changelog-img](http://i.imgur.com/01Hxjmt.png) 

--------

## Installation
-----------

Install the gem:

`gem install trello-changelog`

## Configuration
---------

Create a file named '.trello-changelog.rb' in your ~home directory, it should contain the following:

```ruby
module Variables  
  DEVKEY = 'abcde' 
  MEM_TOKEN = 'abcde' 
  BOARD = '1a2b3b4'
  DONE_LIST_NAME = 'Done'
  LABELS = %w( 
    bug
    feature
    postmortem
  )          
end
```

 * **DEVKEY**: get this from [trello.com/app-key](http://trello.com/app-key)
 * **MEM_TOKEN**: go to [trello.com/1/authorize?key=DEVKEY&response_type=token&expiration=never](http://trello.com/1/authorize?key=DEVKEY&response_type=token&expiration=never) (replace DEVKEY with your devkey)
 * **BOARD**: you can find your board ID in the url of your board (should be something like soZ9XlDB)
 * **DONE_LIST_NAME**: the name of the column you use for done tickets (case sensitive)
 * **LABELS**: labels you use in your board and want to use for categorization (case sensitive)

## Usage
----------

If you want to summarize this week (6 days back, we use this gem on a friday by default): 

`trello-changelog print`

If you want to summarize since a certain date:

`trello-changelog print --start_date=2015-02-20`

Run and copy to pasteboard (OS X):

`trello-changelog print | pbcopy`

## Contributing
----------

Bug reports, feature requests and test implementations are more than welcome. Please use our [Github account](https://github.com/openminds/trello-changelog) for this.
