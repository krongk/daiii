#encoding: utf-8
require 'mechanize'
require 'hpricot'
require 'uri'

module SiteUtil
  module ClassMethods
    
  end
  
  module InstanceMethods
    
  end
  
  def self.included(receiver)
    receiver.extend         ClassMethods
    receiver.send :include, InstanceMethods
  end

  def self.get_icon(url)
    puts url
    uri = URI(url)
    
    agent = Mechanize.new
    page = agent.get(url)
    doc = Hpricot(page.body)
    imgs = doc.search("//img")

    puts "raw-------------------"
    imgs.each do |img|
      puts img['src']
    end
    puts "raw- end------------------"

    best_icon = choose_best_icon(imgs, uri, ['name', 'domain', 'width'])
    src = best_icon['src'] unless best_icon.nil?
    if src =~ /^\//
      p = src.index(uri.path) - 1
      src = url[0..p] + src
    end
    return src 
    # puts imgs.size
    # #case1: the name is logo|icon
    # matched_imgs = imgs.select { |img| img.attributes['src'] =~ /logo|icon/  }
    # return matched_imgs.first.attributes['src'] if matched_imgs.any?

    # #case2: alt is domain name
    # if uri
    #   matched_imgs = imgs.select { |img| img.attributes['alt'] == uri.host  }
    #   return matched_imgs.first.attributes['src'] if matched_imgs.any?
    # end

    # #case3: width/height in range [50..300]
    # matched_imgs = imgs.select { |img| (50..250).include?(img.attributes['width'].to_i) }
    # return matched_imgs.first.attributes['src'] if matched_imgs.any?

    # return matched_imgs.first.attributes['src']
  end

  def self.choose_best_icon(imgs, uri, cases = ['name', 'domain', 'width'])
    return imgs.first if cases.empty?
    
    flag = nil
    #case1: the name is logo|icon
    if cases.include?('name') 
      matched_imgs = imgs.select { |img| img.attributes['src'] =~ /logo|icon/  }
      flag = 'name'
    elsif cases.include?('domain') && uri
      matched_imgs = imgs.select { |img| img.attributes['alt'] == uri.host  }
      flag = 'domain'
    elsif cases.include?('width')
      matched_imgs = imgs.select { |img| (50..250).include?(img.attributes['width'].to_i) }
      flag = 'width'
    else
      imgs
    end

    case matched_imgs.size
    when 1
      return matched_imgs.first
    else
      choose_best_icon(imgs, uri, cases - [flag])
    end
  end
end

if $0 == __FILE__
  puts SiteUtil.get_icon("http://www.mesbo.com.cn/ffe.html")
end

# url = "http://www.wedding.com/"
# def get_imgs(url)
#  agent = Mechanize.new
#     page = agent.get(url)
#     doc = Hpricot(page.body)
#     doc.search("//img")
# end