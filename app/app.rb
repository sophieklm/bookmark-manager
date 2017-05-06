ENV["RACK_ENV"] ||="development"
require 'sinatra/base'
require 'sinatra/flash'
require 'sinatra/partial'
require_relative 'data_mapper_setup'
require_relative 'server'
require_relative 'controllers/links'
require_relative 'controllers/sessions'
require_relative 'controllers/users'
require_relative 'controllers/tags'

class BookmarkManager < Sinatra::Base

  get '/' do
    erb :'/index'
  end

end
