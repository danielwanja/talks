!SLIDE commandline incremental
	$ heroku addons:add mongohq:free
	Adding mongohq:free to freezing-autumn-489... done, v17 (free)
	
* http://devcenter.heroku.com/articles/mongohq
* see http://mongohq.com
* see http://www.mongodb.org/display/DOCS/Tutorial

!SLIDE bullets smaller
# Multiple gems
# http://mongoid.org/
# http://rubygems.org/gems/mongo
# http://mongomapper.com/
# https://github.com/mongoid/mongoid

!SLIDE commandline incremental

	$ mongo		  # command line
	> db.foo.save( { a : 1, children: [{a: 1.1}, {a: 1.2}] } )
	> db.foo.find()           
	{ "_id" : ObjectId("4df6b7a6a170e0529dc98e42"), "a" : 1 }
	> db.foo.remove({a:1})

!SLIDE commandline incremental

# Create a Rails app

	$ rails new documents
	
# Update the Gemfile

	@@@ruby
	# gem 'sqlite3'
	gem "mongoid", "~> 2.0"
	gem "bson_ext", "~> 1.3"	
	
!SLIDE commandline incremental
	
# Configure mongodb

	$ rails g mongoid:config
	
!SLIDE commandline incremental

	 rails g scaffold article name:string content:text
     invoke  mongoid
     create    app/models/article.rb
     invoke    test_unit
     create      test/unit/article_test.rb
     create      test/fixtures/articles.yml
      route  resources :articles
     invoke  scaffold_controller
     create    app/controllers/articles_controller.rb
	 ...
	
!SLIDE commandline incremental

	$ rails g model comment name:string content:text
    invoke  mongoid
    create    app/models/comment.rb
    invoke    test_unit
    create      test/unit/comment_test.rb
    create      test/fixtures/comments.yml

!SLIDE bullets

* Similar to Rails: Article.all or Article.fist
* but more flexible...
* Article.first.as_document

!SLIDE code smaller

	@@@ruby
  	Mongoid::Factory.build Article, 
		{ name: "Using MongoDb", 
		  content: "...with mongoid", 
		  comments: [  { :name=>"Daniel",
						 :content=>"this is very flexible"}], 
		  other: "Something else"
		}		

!SLIDE bullets smaller

# TODO

* Build example app that has a "dynamic" section
* I.e. Dynamic i.e. check "custom" attributes and allow
*      to attach anything: expand row columns

* Add a finder on custom attributes

