module HomeHelper

  def get_site_url(site_item)
    if site_item.site_url !~ /^(http:.*)/
      return "http://#{site_item.site_url}"
    end
    site_item.site_url
  end

  #https://www.uservoice.com/101/
  #http://stackoverflow.com/questions/9779402/setting-default-width-for-collection-select-in-rails
  #http://news.sina.com.cn/c/2013-04-05/053226737005.shtml
  def get_site_title_from_url(site_url)
    return if site_url.blank?
    if site_url =~ /.*\/\/(?:www)?(?:\.)?([^ \/]+)\..*/i
      return $1
    else
      return site_url
    end
  end

  def get_site_icon(site_item)
    if site_item.site_icon.blank?
      return nil
    end
    site_item.site_icon
  end

end
