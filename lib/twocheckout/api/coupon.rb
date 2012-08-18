module Twocheckout
  class Coupon

    def self.create(params={})
      Twocheckout.request(:post, 'products/create_coupon', params)
    end

    def self.retrieve(params={})
      if params.has_key?("coupon_code")
        Twocheckout.request(:get, 'products/detail_coupon', params)
      else
        Twocheckout.request(:get, 'products/list_coupons', params)
      end
    end

    def self.update(params={})
      Twocheckout.request(:post, 'products/update_coupon', params)
    end

    def self.delete(params={})
      Twocheckout.request(:post, 'products/delete_coupon', params)
    end
  end
end