class HomeSweeper < ActionController::Caching::Sweeper
  observe User
  
  def sweep(user)
    # expire_news_item news_items_path
    # expire_news_item news_item_path(news_item)
    # expire_news_item "/"
    FileUtils.rm_rf "#{news_item_cache_directory}/index.html"
  end
  alias_method :after_create, :sweep
  alias_method :after_update, :sweep
  alias_method :after_destroy, :sweep
end