class ApplicationController < ActionController::Base
  protect_from_forgery
  layout 'application_static', :except => [:index, :show, :update]
  
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, :alert => exception.message
  end


  #fit for mobile device
  #http://railscasts.com/episodes/199-mobile-devices
  before_filter :prepare_for_mobile

  #overwrite the devise default root path
  def after_sign_in_path_for(resource)
    "/dashboard/index"
  end

	private

	def mobile_device?
	  if session[:mobile_param]
	    session[:mobile_param] == "1"
	  else
	    request.user_agent =~ /Mobile|webOS/
	  end
	end
	helper_method :mobile_device?

	def prepare_for_mobile
	  session[:mobile_param] = params[:mobile] if params[:mobile]
	  request.format = :mobile if mobile_device?
	end
end
