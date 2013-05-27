#encoding: utf-8
class HomeController < ApplicationController
  caches_page :index, :us, :chrome
  layout 'application_static'
  def index
  end
  def us
  end

  def chrome
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
    tag_str = tag_str.gsub(/ |，|。|、|；/, ' ') unless tag_str.blank?
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
