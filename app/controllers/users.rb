require './lib/send_recover_link.rb'

class BookmarkManager < Sinatra::Base

  get '/users/new' do
    erb :'/users/new'
  end

  post '/users/new' do
    user = User.new(email: params[:email], password: params[:password], password_confirmation: params[:password_confirmation])
    if user.save
      session[:user_id] = user.id
      redirect to('/links')
    else
      flash.now[:errors] = user.errors.full_messages
      erb :'/users/new'
    end
  end

  get '/users/recover' do
    erb :'/users/recover'
  end

  post '/users/recover' do
    user = User.first(email: params[:email])
    if user
      user.generate_token
      SendRecoverLink.call(user)
    end
    flash.next[:notice] = "Thanks, please check your inbox."
    redirect to '/'
  end

  get '/users/reset_password' do
    @user = User.find_by_valid_token(params[:token])
    if @user
      session[:token] = params[:token]
      erb :'users/reset_password'
    else
      "This token is no longer valid"
    end
  end

  patch '/users' do
    user = User.find_by_valid_token(session[:token])
    if user.update(password: params[:password], password_confirmation: params[:password_confirmation])
      session[:token] = nil
      user.update(password_token: nil)
      redirect "/sessions/new"
    else
      flash.now[:errors] = user.errors.full_messages
      erb :'users/reset_password'
    end
  end

end
