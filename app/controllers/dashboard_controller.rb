class DashboardController < ApplicationController
  def index
    cate_id = params[:cate_id].to_i if params[:cate_id]
    if cate_id
      @site_items = SiteItem.where(:user_id => current_user.id, :site_cate_id => cate_id).order("updated_at DESC").paginate(:page => params[:page] || 1, :per_page => 100)
    else
      @site_items = SiteItem.where(:user_id => current_user.id).order("updated_at DESC").paginate(:page => params[:page] || 1, :per_page => 100)
    end
    @tags = current_user.site_items.tag_counts_on(:tags)
  end
end
