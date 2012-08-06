module Twocheckout
  class Coupon

    def self.create(params={})
      Twocheckout.request(:post, 'products/create_coupon', @api_credentials, params)
    end

    def self.retrieve(params={})
      if params.has_key?("coupon_code")
        Twocheckout.request(:get, 'products/detail_coupon', @api_credentials, params)
      else
        Twocheckout.request(:get, 'products/list_coupons', @api_credentials, params)
      end
    end

    def self.update(params={})
      Twocheckout.request(:post, 'products/update_coupon', @api_credentials, params)
    end

    def self.delete(params={})
      Twocheckout.request(:post, 'products/delete_coupon', @api_credentials, params)
    end
  end
end