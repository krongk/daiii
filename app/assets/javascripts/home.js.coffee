# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

# called from a bootstrap dropdown, this closes the dropdown
$('a[data-toggle=modal]').on 'click', ->
  $('.dropdown').removeClass('open')

# this sets up the ajax loader, and it will stay until the method specific js removes it
$('a[data-target=#ajax-modal]').on 'click', ->
   e.preventDefault()
   e.stopPropagation();
   $('body').modalmanager('loading');
   $.rails.handleRemote( $(this) );
   
#removes whatever is in the modal body content div upon clicking close/outside modal
$(document).on 'click', '[data-dismiss=modal], .modal-scrollable', ->
  $('.modal-body-content').empty()

$(document).on 'click', '#ajax-modal', (e) ->
  e.stopPropagation();


# 鼠标滚动到最后时候，加载更多列表：
# 参考：
# 错误：出现"ActionView::MissingTemplate" 和"undifiend method formats for nil.class" 错误
# 解决：在welcome/index.js.erb中，修改为： <%# j render(:partial => 'welcome/site_items', 。。。
#        新建一个partial:　_site_items.html.erb 用于展示餐厅列表， 当要翻页的时候，只是渲染此页。
jQuery ->
  # 1. 当窗口滚动到最后，自动加载
  # if $('#site_items .pagination').length
  #   $(window).scroll ->
  #     url = $('#site_items .pagination .next_page').attr('href')
  #     if url && $(window).scrollTop() > $(document).height() - $(window).height() - 50
  #       $('#site_items .pagination').html("<p><img src='/assets/loading.gif'/></p>")
  #       $.getScript(url)
  #   $(window).scroll()

  # 2. 当点击div, 才加载
  if $('#public_share .pagination').length
    $('#pagination_ajax_title').bind 'click', (event) ->
      url = $('#public_share .pagination .next_page a').attr('href')
      if url
        $('#loading-holder').html("<p><img src='/assets/loading.gif'/></p>")
        $.getScript(url)
    $(window).scroll()