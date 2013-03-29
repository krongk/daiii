module HomeHelper

  def get_site_url(site_item)
    if site_item.site_url !~ /^(http:.*)/
      return "http://#{site_item.site_url}"
    end
    site_item.site_url
  end

  def get_site_icon(site_item)
    if site_item.site_icon.blank?
      return nil
    end
    site_item.site_icon
  end
end
