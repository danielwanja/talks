#!/usr/bin/ruby
app_name = ARGV[0]
app_id = ARGV[1] ?  ARGV[1] :  ARGV[0].gsub('_','.')

def sh(command)
  puts command
  system command
  puts ""
end


sh "adt -launchApp -platform ios -platformsdk /Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator4.3.sdk -device ios-simulator -appid #{app_id}"