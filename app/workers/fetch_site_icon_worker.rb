require 'site_util'

class FetchSiteIconWorker
	include Sidekiq::Worker

  def perform(site_item_id, site_url)
    site_item = SiteItem.find(site_item_id)
  	site_item.site_icon = SiteUtil.get_icon(site_url)
  	site_item.save!
  end
end
