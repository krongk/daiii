class HomeController < ApplicationController
  caches_page :index_static, :us

  def index
    unless current_user
      render "index_static", :layout => 'application_static'
      return 
    end

    cate_id = params[:cate_id].to_i if params[:cate_id]
    if cate_id
      @site_items = SiteItem.where(:user_id => current_user.id, :site_cate_id => cate_id).order("updated_at DESC").paginate(:page => params[:page] || 1, :per_page => 100)
    else
      @site_items = SiteItem.where(:user_id => current_user.id).order("updated_at DESC").paginate(:page => params[:page] || 1, :per_page => 100)
    end
  end

  def index_static
    @user_count = User.all.size
    render "index_static", :layout => 'application_static'
  end

  def us

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
