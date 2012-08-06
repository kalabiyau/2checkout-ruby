module Twocheckout
  class Option

    def self.create(params={})
      Twocheckout.request(:post, 'products/create_option', @api_credentials, params)
    end

    def self.retrieve(params={})
      if params.has_key?("option_id")
        Twocheckout.request(:get, 'products/detail_option', @api_credentials, params)
      else
        Twocheckout.request(:get, 'products/list_options', @api_credentials, params)
      end
    end

    def self.update(params={})
      Twocheckout.request(:post, 'products/update_option', @api_credentials, params)
    end

    def self.delete(params={})
      Twocheckout.request(:post, 'products/delete_option', @api_credentials, params)
    end
  end
end