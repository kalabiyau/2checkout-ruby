module Twocheckout
  class Contact

    def self.retrieve(params={})
      Twocheckout.request(:get, 'acct/detail_contact_info', @api_credentials, params)
    end
  end
end