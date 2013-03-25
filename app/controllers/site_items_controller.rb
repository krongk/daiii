class SiteItemsController < ApplicationController
  before_filter :authenticate_user!
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
      format.html # new.html.erb
      format.json { render json: @site_item }
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
    
    respond_to do |format|
      if @site_item.save
        format.html { redirect_to @site_item, notice: 'Site item was successfully created.' }
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
        format.html { redirect_to @site_item, notice: 'Site item was successfully updated.' }
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
