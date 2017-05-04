ENV["RACK_ENV"] ||="development"
require 'sinatra/base'
require 'sinatra'
require 'sinatra/flash'
require_relative 'data_mapper_setup'

class BookmarkManager < Sinatra::Base

  enable :sessions
  set :session_secret, 'super secret'
  register Sinatra::Flash

  helpers do
    def current_user
      @current_user ||= User.get(session[:user_id])
    end
  end

  get '/links' do
    @links = Link.all
    erb :'links/index'
  end

  get '/links/new' do
    erb :'links/new'
  end

  post '/links' do
    link = Link.create(title: params[:title], url: params[:url])
    params[:tags].split.each do |tag|
      link.tags << Tag.first_or_create(tag: tag)
    end
    link.save
    redirect to ('/links')
  end

  get '/tag/:tag' do
    @tag = Tag.all(:tag => params[:tag])
    @tag_links = @tag.links
    erb :'links/tag'
  end

  get '/signup' do
    erb :'users/signup'
  end

  post '/signup' do
    user = User.new(email: params[:email], password: params[:password], password_confirmation: params[:password_confirmation])
    if user.save
      session[:user_id] = user.id
      redirect to('/links')
    else
      flash.now[:password_error] = "Password and confirmation do not match"
      erb :'users/signup'
    end
  end

  run! if app_file == $0

end
