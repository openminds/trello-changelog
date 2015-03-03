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

1. Create a file named '.trello-changelog.rb' in your ~home directory.

2. Get your API keys from trello.com/app-key.

3. Visit the URL [trello.com/1/authorize], with the following GET parameters:


4. 	key: the API key you got in step 2.

	response_type: "token"
	
	expiration: "never" if you don't want your token to ever expire. If you leave this blank, your generated token will expire after 30 days.
	
	So this should be something like: trello.com/1/authorize?	key=INSERT_KEY_FROM_STEP_1&response_type=token&expiration=never
	You should see a page asking you to authorize your Trello application. Click "allow" and 	you should see a second page with a long alphanumeric string. This is your member token, 	write it down!

5. Copy this and fill it in
	
		module Variables  
		DEVKEY = '' # here your key from step 2
  	 	MEM_TOKEN = '' # here your token
  	 	BOARD = '' # here the code of your trello board (can be found in url of your trello board)
  	 	DONE_LIST_NAME = '' # here name of your done list 
  	 	LABELS = %w( 
    		 # here name of label 1
   			 # here name of label 2
   			 # ...
   		)          
		end



## Usage
----------

If you want to summarize this week (6 days back): 

`trello-changelog print`

If you want to summarize since a certain date:

`trello-changelog print --start_date=2015-02-20`

## Contributing
----------

Bug reports, feature requests and test implementations are more than welcome. Please use our [Github account](https://github.com/openminds/trello-changelog) for this.
