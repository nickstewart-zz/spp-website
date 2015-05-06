require 'sinatra'
require 'erb'

def auth
  @auth ||= Rack::Auth::Basic::Request.new(request.env)
end

def unauthorized!(realm="Short URL Generator")
  headers 'WWW-Authenticate' => %(Basic realm="#{realm}")
  throw :halt, [ 401, 'Authorisation Required' ]
end

def bad_request!
  throw :halt, [ 400, 'Bad Request' ]
end

def authorized?
  request.env['REMOTE_USER']
end

def authorize(username, password)
  if (username=='admin' && password=='admin') then
    true
  else
    false
  end
end

def require_admin
  return if authorized?
  unauthorized! unless auth.provided?
  bad_request! unless auth.basic?
  unauthorized! unless authorize(*auth.credentials)
  request.env['REMOTE_USER'] = auth.username
end

def admin?
  authorized?
end

get '/' do
  require_admin
  @title = "Sevenoaks Prime Property"
  erb :index
end

get '/about' do
  @title = "About Sevenoaks Prime Property"
  erb :about
end