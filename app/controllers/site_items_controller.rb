#encoding: utf-8
require 'site_util'
class SiteItemsController < ApplicationController
  before_filter :authenticate_user!
  include HomeHelper
  
  layout :nil, :only => [:show, :edit]

  def tags
    @tags = current_user.site_items.tag_counts_on(:tags)
  end

  def tag
    @site_items = current_user.site_items.tagged_with(params[:id])
    @tags = current_user.site_items.tag_counts_on(:tags)
    render :action => 'index'
  end

  # GET /site_items
  # GET /site_items.json
  def index
    #authorize! :index, @user, :message => 'Not authorized as an administrator.'
    @site_items = current_user.site_items.paginate(:page => params[:page]||1, :per_page => 50)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @site_items }
    end
  end

  # GET /site_items/1
  # GET /site_items/1.json
  def show
    @site_item = current_user.site_items.find_by_id(params[:id])
    unless  @site_item
      redirect_to user_path(current_user), :notice => "没有访问权限!"
      return
    end
    respond_to do |format|
      format.html 
      format.json { render json: @site_item }
    end
  end

  # GET /site_items/new
  # GET /site_items/new.json
  def new
    @site_item = SiteItem.new

    respond_to do |format|
      #format.html # new.html.erb
      #format.json { render json: @site_item }
      format.js # new.js.erb
    end
  end

  # GET /site_items/1/edit
  def edit
    @site_item = current_user.site_items.find_by_id(params[:id])
    unless  @site_item
      redirect_to user_path(current_user), :notice => "没有访问权限!"
      return
    end
  end

  # POST /site_items
  # POST /site_items.json
  def create
    @site_item = SiteItem.new(params[:site_item])
    @site_item.site_cate_id = params[:site_item][:site_cate_id].to_i
    @site_item.user_id = current_user.id
    @site_item.site_url = get_site_url(@site_item)
    @site_item.site_title ||= get_site_title_from_url(@site_item.site_url)
    @site_item.site_title = @site_item.site_title.gsub(/^http(?:s)?\:\/\//, '').gsub(/www\./, '') unless @site_item.site_title.blank?
    
    tag_str = params[:site_item][:tag_list]
    tag_str = tag_str.gsub(/ |，|。|、|；/, ' ') unless tag_str.blank?
    @site_item.tag_list = tag_str.gsub(/\s+/, ',') unless tag_str.blank?

    respond_to do |format|
      if @site_item.save
        #sidekiq not work on Windows
        @site_item.reload
        FetchSiteIconWorker.perform_async(@site_item.id, @site_item.site_url) unless request.host == 'localhost'
        #@site_item.site_icon = SiteUtil.get_icon(@site_item.site_url)
        #@site_item.save!

        format.html { redirect_to root_path, notice: '网站添加成功.' }
        format.json { render json: @site_item, status: :created, location: @site_item }
      else
        format.html { render action: "new" }
        format.json { render json: @site_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /site_items/1
  # PUT /site_items/1.json
  def update
    @site_item = SiteItem.find(params[:id])

    respond_to do |format|
      if @site_item.update_attributes(params[:site_item])
        FetchSiteIconWorker.perform_async(@site_item.id, @site_item.site_url) unless request.host == 'localhost'
        format.html { redirect_to root_path, notice: '网站修改成功.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @site_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /site_items/1
  # DELETE /site_items/1.json
  def destroy
    @site_item = current_user.site_items.find_by_id(params[:id])
    unless  @site_item
      redirect_to user_path(current_user), :notice => "没有访问权限!"
      return
    end

    @site_item.destroy

    respond_to do |format|
      format.html { redirect_to "/" }
      format.json { head :no_content }
    end
  end
end
