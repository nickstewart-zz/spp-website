require 'sinatra'

get '/' do
  @title = "Sevenoaks Prime Property"
  erb :index
end

get '/about' do
  @title = "About Sevenoaks Prime Property"
  erb :about
end