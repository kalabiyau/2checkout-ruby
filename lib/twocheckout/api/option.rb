module Twocheckout
  class Option

    def self.create(params={})
      Twocheckout.request(:post, 'products/create_option', params)
    end

    def self.retrieve(params={})
      if params.has_key?("option_id")
        Twocheckout.request(:get, 'products/detail_option', params)
      else
        Twocheckout.request(:get, 'products/list_options', params)
      end
    end

    def self.update(params={})
      Twocheckout.request(:post, 'products/update_option', params)
    end

    def self.delete(params={})
      Twocheckout.request(:post, 'products/delete_option', params)
    end
  end
end