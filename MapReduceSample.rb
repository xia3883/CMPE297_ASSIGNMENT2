require 'rubygems'
require 'sinatra'
require 'haml'
require 'mongo_mapper'

configure do  
  host = JSON.parse(ENV['VCAP_SERVICES'])['mongodb-2.0'].first['credentials']['hostname'] rescue 'localhost'
  port = JSON.parse(ENV['VCAP_SERVICES'])['mongodb-2.0'].first['credentials']['port'] rescue 27017
  username = JSON.parse( ENV['VCAP_SERVICES'] )['mongodb-2.0'].first['credentials']['username'] rescue nil
  password = JSON.parse( ENV['VCAP_SERVICES'] )['mongodb-2.0'].first['credentials']['password'] rescue nil
  database = JSON.parse( ENV['VCAP_SERVICES'] )['mongodb-2.0'].first['credentials']['db'] rescue 'hello_test1'

  uri = "mongodb://#{username}:#{password}@#{host}:#{port}/#{database}"
  
  MongoMapper.database = database
end

class DailyInfo
   include MongoMapper::Document
   key :date, Date
   key :ip, String
   key :count, Integer

   def self.map
     <<-MAP
       function() {
         emit(this.date, 1);
       }
     MAP
   end
  
   def self.reduce
     <<-REDUCE
       function(k, v) {
         var count = 0;
         for (index in v) {
           count += v[index];
         }
         return count
       }
      REDUCE
    end

    def self.build
       DailyInfo.collection.map_reduce(map, reduce, :query=>{})
end

get '/' do
   @today = "#{Date.today}"
   ip = "#{request.ip}"
   DailyInfo.create!({:date=>"#{@today}", :ip=>"#{ip}", :count=>1}).save
   @daily=DailyInfo.build.find()
   haml :display
end