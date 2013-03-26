class HomeController < ApplicationController
  def index
    @users = User.all
  end

  def modal_window
  	sleep 4 #development only, simulates wait time
	  respond_to do |format|
	    #format.html { redirect_to "home/modal_window" } #for my controller, i wanted it to be JS only
	    format.js
	  end
  end
end
