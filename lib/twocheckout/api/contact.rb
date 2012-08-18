module Twocheckout
  class Contact

    def self.retrieve(params={})
      Twocheckout.request(:get, 'acct/detail_contact_info', params)
    end
  end
end