!SLIDE commandline incremental
	$ heroku addons:add pusher:test
	Adding pusher:test to freezing-autumn-489... done, v7 (free)
	
* See http://pusher.com/docs/heroku
* Signup at http://pusher.com/

!SLIDE bullets

# Publish/Subscribe uses

* messaging
* screen synchronization
* notification
* inbox/queue count update
* system wide alarams

!SLIDE bullets

* Rails is not needed
* Can be Flex-->Pusher-->Flex
* However, Rails can be useful

!SLIDE bullets

# For Flex see

* https://github.com/smakinson/Pusher-ActionScript-Library
* https://github.com/y8/websocket-as
	
!SLIDE commandline smaller

# Add gem 'pusher' to your Gemfile
	$ bundle install

# Get your pusher api key
	
* Note: production is managed by heroku 
	
!SLIDE code smaller

# config/environments/development.rb
	
	@@@ruby
	require 'pusher'
	Pusher.app_id = 6182
	Pusher.key = 'a0b74a20a5d8df2db432'
	Pusher.secret = '057c1aac0e15defa3a55'
	
!SLIDE commandline incremental

	$ rails g controller Message hello	
	create  app/controllers/message_controller.rb
     route  get "message/hello"
    invoke  erb
    create    app/views/message
    create    app/views/message/hello.html.erb
    invoke  test_unit
    create    test/functional/message_controller_test.rb
    invoke  helper
    create    app/helpers/message_helper.rb
    invoke    test_unit
    create      test/unit/helpers/message_helper_test.rb

!SLIDE code smaller

	@@@ruby
	class MessageController < ApplicationController

	  def hello
	    Pusher['test_channel'].trigger('greet', {
	      :greeting => "Hello there!"
	    })    
	  end

	end
	
!SLIDE  code smaller 

# In Flex: subscribe 
	@@@javascript
	private var pusher:Pusher;
	private var channel:Channel;
	protected function setup():void
	{
		pusher = new Pusher('a0b74a20a5d8df2db432', "pusherexample" );
		channel = pusher.subscribe('test_channel');
		channel.bind('greet', gotData);
	}

	protected function gotData(data:Object):void {
		Alert.show(ObjectUtil.toString(data));
	}

!SLIDE  code smaller 

# In Flex: send (not yet supported)
	@@@javascript

	channel.trigger('greet', {greeting: message.text}); 
	
	
!SLIDE smaller

	Flex use 
	https://github.com/smakinson/Pusher-ActionScript-Library.git
	Note: not quite ready for use?
	Error: [strict] Ignoring policy file at http://ws.pusherapp.com:843/crossdomain.xml