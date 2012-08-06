module Twocheckout
  class Company

    def self.retrieve(params={})
      Twocheckout.request(:get, 'acct/detail_company_info', @api_credentials, params)
    end
  end
end