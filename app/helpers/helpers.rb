require 'sinatra/base'

class Helpers

  def self.current_user(session) #should accept the session hash as an argument
    @user = User.find_by_id(session[:user_id]) # should use the user_id from the session hash to find the user in the database and return that user
  end

  def self.is_logged_in?(session) #should also accept the session hash as an argument
      !!session[:user_id] #This method should return true if the user_id is in the session hash 
    end

end
