module Twocheckout
  class Product

    def self.create(params={})
      Twocheckout.request(:post, 'products/create_product', params)
    end

    def self.retrieve(params={})
      if params.has_key?("product_id")
        Twocheckout.request(:get, 'products/detail_product', params)
      else
        Twocheckout.request(:get, 'products/list_products', params)
      end
    end

    def self.update(params={})
      Twocheckout.request(:post, 'products/update_product', params)
    end

    def self.delete(params={})
      Twocheckout.request(:post, 'products/delete_product', params)
    end
  end
end
