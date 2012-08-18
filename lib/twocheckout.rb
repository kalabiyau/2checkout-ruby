gem 'rest-client'
require 'rest_client'
require 'cgi'
require 'json'
require 'net/http'
require 'base64'
require 'digest/md5'

require File.dirname(__FILE__) + '/twocheckout/api/sale.rb'
require File.dirname(__FILE__) + '/twocheckout/api/company.rb'
require File.dirname(__FILE__) + '/twocheckout/api/contact.rb'
require File.dirname(__FILE__) + '/twocheckout/api/product.rb'
require File.dirname(__FILE__) + '/twocheckout/api/option.rb'
require File.dirname(__FILE__) + '/twocheckout/api/coupon.rb'
require File.dirname(__FILE__) + '/twocheckout/charge.rb'
require File.dirname(__FILE__) + '/twocheckout/return.rb'
require File.dirname(__FILE__) + '/twocheckout/ins.rb'
require File.dirname(__FILE__) + '/twocheckout/util.rb'
require File.dirname(__FILE__) + '/twocheckout/message.rb'

module Twocheckout
  @api_base = 'https://www.2checkout.com/api/'
  @api_credentials = nil

  def self.api_url(url='')
    @api_base + url
  end

  def self.api_credentials=(options = {})
    @api_credentials = options
  end

  def self.api_base=(api_base)
    @api_base = api_base
  end

  def self.request(method, url, params=nil)

    if method == :get
      @url = api_url(url) + '?' + params.map{|k,v| "#{k}=#{v}"}.join('&')
      params = nil
    elsif method == :post
      @url = api_url(url)
    else

    end

    opts = {
        :method => method,
        :url => @url,
        :headers => {:accept => :json, :content_type => :json},
        :user => @api_credentials['username'],
        :password => @api_credentials['password'],
        :payload => params
        }
    begin
      RestClient::Request.execute(opts)
    rescue => e
      TwocheckoutMessage.new(e.response).retrieve
    end
  end
end