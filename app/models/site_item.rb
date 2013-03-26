class SiteItem < ActiveRecord::Base
  belongs_to :site_cate
  belongs_to :user
  attr_accessible  :site_cate_id, :note, :rate_count, :site_password, :site_password_tips, :site_title, :site_url, :site_username, :visit_count
  validates :site_title, :presence => true
  validates :site_url, :presence => true
  validates :site_url, :uniqueness => true
  # validates :site_url, :format => { :with => /\A[a-zA-Z]+\z/,
  #   :message => "Only letters allowed" }
end
