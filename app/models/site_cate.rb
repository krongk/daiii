class SiteCate < ActiveRecord::Base
  has_many :site_items
  belongs_to :user

  attr_accessible :user_id, :name
  validates :name, :presence => true
end
