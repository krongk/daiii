class SiteItem < ActiveRecord::Base
  belongs_to :site_cate
  belongs_to :user
 
  attr_accessible :user_id, :site_cate_id, :note, :rate_count, :site_password, :site_password_tips, :site_title, :site_url, :site_username, :visit_count
  #validates :site_title, :presence => true
  validates :site_url, :presence => true
  #validates :site_url, :uniqueness => true
  # validates :site_url, :format => { :with => /\A[a-zA-Z]+\z/,
  #   :message => "Only letters allowed" }

  attr_accessor :tags
  acts_as_taggable
  acts_as_taggable_on :tags #, :skills
  scope :by_created_date, order("created_at DESC")

  def self.recent(count)
  	SiteItem.order("created_at DESC").limit(count)
  end
  
end
