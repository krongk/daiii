#encoding: utf-8
class SiteCatesController < ApplicationController
  before_filter :authenticate_user! 
  # GET /site_cates
  # GET /site_cates.json
  def index
    @site_cates = SiteCate.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @site_cates }
    end
  end

  # GET /site_cates/1
  # GET /site_cates/1.json
  def show
    @site_cate = SiteCate.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @site_cate }
    end
  end

  # GET /site_cates/new
  # GET /site_cates/new.json
  def new
    @site_cate = SiteCate.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @site_cate }
    end
  end

  # GET /site_cates/1/edit
  def edit
    @site_cate = SiteCate.find(params[:id])
  end

  # POST /site_cates
  # POST /site_cates.json
  def create
    @site_cate = SiteCate.new(params[:site_cate])
    @site_cate.user_id = current_user.id
    respond_to do |format|
      if @site_cate.save
        format.html { redirect_to site_cates_url, notice: '添加成功.' }
        format.json { render json: @site_cate, status: :created, location: @site_cate }
      else
        format.html { render action: "new" }
        format.json { render json: @site_cate.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /site_cates/1
  # PUT /site_cates/1.json
  def update
    @site_cate = SiteCate.find(params[:id])

    respond_to do |format|
      if @site_cate.update_attributes(params[:site_cate])
        format.html { redirect_to @site_cate, notice: 'Site cate was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @site_cate.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /site_cates/1
  # DELETE /site_cates/1.json
  def destroy
    @site_cate = SiteCate.find(params[:id])
    @site_cate.destroy

    respond_to do |format|
      format.html { redirect_to site_cates_url }
      format.json { head :no_content }
    end
  end
end
