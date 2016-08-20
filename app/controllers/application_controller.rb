class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  protected
  	def manager_only
  		redirect_to root_path unless current_user.manager
  	end

  	def manager_and_mentor_only
  		redirect_to root_path unless current_user.manager || current_user.mentor?
  	end
end
