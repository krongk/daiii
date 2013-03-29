require 'site_util'

class FetchSiteIconWorker
	include Sidekiq::Worker

  def perform(site_item)
  	site_item.site_icon = SiteUtil.get_icon(site_item.site_url)
  	site_item.save!
  	puts "Sidekiq==============================#{site_item.site_icon}"
  end
end
