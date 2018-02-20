require_relative '../../config/environment'
class ApplicationController < Sinatra::Base
  configure do
    set :views, Proc.new { File.join(root, "../views/") }
    enable :sessions unless test?
    set :session_secret, "secret"
  end

  get '/' do
    erb :index
  end

  post '/login' do
    @user = User.find_by(:username => params[:username]) #you'll want to find the user in the database based on their username
    if @user != nil && @user.password == params[:password] #If there is a match, set the session to the user's ID, redirect them to the /account route using redirect to
      session[:user_id] = @user.id
      redirect to '/account'
    end
    erb :error #If there is no match, render the error page
  end

  get '/account' do
    @current_user = User.find_by_id(session[:user_id])
     if @current_user
       erb :account #use current_user to display the username and balance.
     else
       erb :error
     end
   end


   get '/logout' do
      session.clear
      redirect to '/'
    end
  end
