Flex, Ruby, Rails and the Cloud

Think of all the things that are needed to create a top notch web application.... You setup everything I'll present here your self, on
your servers...But that starts to make less sense these days

[Rather] show an app and point to where various technologies can be useful. Then Section  how these technologies can easily be used on the
cloud.

There are different type of "cloud" offering. Google App Engine is an approach where you have unlimited capacity but the programming
approach is different [need better explanation] where scalability it build in.

There is another cloud approach which I consider more traditional in the client server way of thinking where scalability is reached by
adding more servers at different layers. Adding more servers and capacity is nowadays as easy as clicking a button...seriously! I'll Section 
it.

They are now many services provider like google, Amazon Web Services, Heroku, CloudFoundry, Engineyard, and ton's more. Today I'll focus on
Heroku as they made it really simple to get started.

Everything we show here can also be accomplished locally on your computer using open source solutions. Besides that we assume that you can
use git, wish is a source control tool, to get started on your own I have put together the following page http://on
rails.org/max2011FlexRailsGettingStarted that will show you how to setup all this up on your Mac.

In this presentation I will walk you through the various services and techniques that enable these cloud based applications

[provide diagram of a 'cloud' based application]

We will investigate these  cloud services


By checking out these services we look at those technologies:

And following techniques:

Database charding

Scenario:

Section  1: Intro   [5minutes]
  why the cloud
  different cloud offering
Section  2: Anatomy of a Rails app      [2 minutes]
    client (html/javascript/flex)
    Rails/Database
Section  3: Different Options to Connect Flex to a Server [2 minutes]
  HTTPService XML/JSON/BSON/AMF
  Sockets/WebSockets
Section  4: Flex and Vanilla Rails   - noting take app [5 minutes]
  explain Rails, Routes, Rest, Database
  explain HTTPService
  explain Heroku deployment
Section  5: Flex app that use Bulk APi   -  todos app [5 minutes]
Section  6: RestfulX [5 minutes]
Section  7: Flex Gotcha's  [2 minutes]
Section  8: Server side compression using Zlib  [5 minutes]
Section  9: Ruby and AMF [5 minutes]
Section 10: Redis a Key/Value store and more [5 minutes]
Section 11: MongoDb a nosql schema less database [5 minutes]
Section 12: WebSockets and Pusher [5 minutes]
Closing
QA

And more?
	Sending Email
	URLShortener
    credit card payment technique
	Single sign on using oauth (think twitter, facebook)
	
Should I talk about BSON
   https://github.com/argoncloud/ActionBSON
	
    
And following techniques:

Database charding

http://help.adobe.com/en_US/FlashPlatform/reference/actionscript/3/flash/utils/CompressionAlgorithm.html
File.open('data_to_compress.zlib','w') do |f|
    z = Zlib::Deflate.new(9)
    f.write z.deflate(s.to_xml, Zlib::FINISH)
    z.close
end