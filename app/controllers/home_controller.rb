class HomeController < ApplicationController
 # caches_page :index

  def index
    @users = User.all
  end

  def modal_window
     #	sleep 2 #development only, simulates wait time
	  respond_to do |format|
	    #format.html { redirect_to "home/modal_window" } #for my controller, i wanted it to be JS only
	    format.js
	  end
  end

  def like_view
    return if current_user.nil?
    if params[:like] == 'grid'
      current_user.like_view = 'grid'
    else
      current_user.like_view = 'list'
    end
    current_user.save!
    redirect_to '/'
  end
end
