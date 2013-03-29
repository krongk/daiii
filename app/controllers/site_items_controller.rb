#encoding: utf-8
require 'site_util'
class SiteItemsController < ApplicationController
  before_filter :authenticate_user!
  include HomeHelper
  caches_action :index
  caches_action :show
  caches_action :new
  
  # GET /site_items
  # GET /site_items.json
  def index
    @site_items = SiteItem.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @site_items }
    end
  end

  # GET /site_items/1
  # GET /site_items/1.json
  def show
    @site_item = SiteItem.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
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
    @site_item = SiteItem.find(params[:id])
  end

  # POST /site_items
  # POST /site_items.json
  def create
    @site_item = SiteItem.new(params[:site_item])
    @site_item.site_cate_id = params[:site_item][:site_cate_id].to_i
    @site_item.user_id = current_user.id
    @site_item.site_url = get_site_url(@site_item)

    #sidekiq not work on Windows
    #FetchSiteIconWorker.perform_async(@site_item)
    @site_item.site_icon = SiteUtil.get_icon(@site_item.site_url)
    
    respond_to do |format|
      if @site_item.save
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
        format.html { redirect_to root_path, notice: '网站添加成功.' }
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
    @site_item = SiteItem.find(params[:id])
    @site_item.destroy

    respond_to do |format|
      format.html { redirect_to site_items_url }
      format.json { head :no_content }
    end
  end
end
