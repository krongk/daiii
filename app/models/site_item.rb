class SiteItem < ActiveRecord::Base
  belongs_to :site_cate
  belongs_to :user
  attr_accessible  :site_cate_id, :note, :rate_count, :site_password, :site_password_tips, :site_title, :site_url, :site_username, :visit_count
end
