#encoding: utf-8
class HomeController < ApplicationController
  caches_page :index, :us, :chrome
  cache_sweeper :home_sweeper

  def index
    @tags = current_user.site_items.tag_counts_on(:tags)
  end

  def index_static
    redirect_to "/home" if user_signed_in?
  end

  def us
  end

  def setting
  end

  def help
  end
  
  def chrome
  end

  def public_share
    @site_items = SiteItem.where(params[:u] ? ["user_id = ?", params[:u]] : true).paginate(:per_page => 10, :page => params[:page] || 1).order("updated_at DESC")
  end

  def add_quote
    #params =>{"quote"=>{"content"=>"雨服务", "creator"=>"", "title"=>"雨服务", "tag_names"=>"电子书 故事", "url"=>"http://localhost:3000/chrome"}, "action"=>"add_quote", "controller"=>"home"}
    unless current_user
      redirect_to "/users/sign_in", notice: "你还没有登录，请先登录。"
      return
    end
    @item = SiteItem.new(:user_id => current_user.id)
    @item.note = params[:quote][:content]
    @item.site_url = params[:quote][:url]
    @item.site_title = params[:quote][:title]
    tag_str = params[:quote][:tag_names]
    tag_str = tag_str.gsub(/，|。|、|；/, ' ') unless tag_str.blank?
    @item.tag_list = tag_str.gsub(/\s+/, ',') unless tag_str.blank?
    respond_to do |format|
      if @item.save
        format.html { redirect_to "/quote_added?item_id=#{@item.id}", notice: '添加成功.' }
        format.json { render json: @item, status: :created, location: @item }
      else
        format.html { render action: "/add_quote" }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  def quote_added
    @item = SiteItem.find(params[:item_id])
  end

  def modal_window
     #	sleep 2 #development only, simulates wait time
	  respond_to do |format|
	    #format.html { redirect_to "home/modal_window" } #for my controller, i wanted it to be JS only
	    format.js
	  end
  end
  
end
