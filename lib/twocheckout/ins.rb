module Twocheckout
  class Ins

    # Checks against MD5 Hash
    def self.check(sale_id, sid, invoice_id, secret, key)
      Digest::MD5.hexdigest("#{sale_id}#{sid}#{invoice_id}#{secret}").upcase == key
    end

    # Parses Header Redirect Query String
    def self.request(options={})
      params = options[:params]
      credentials = options[:credentials]
      if params.is_a?(Hash)
        if check(params['sale_id'], credentials['sid'], params['invoice_id'], credentials['secret'], params['md5_hash'])
          message = {:code => "PASS", :message => "Hash Matched"}
          result = TwocheckoutMessage.new(message).retrieve
        else
          message = {:code => "FAIL", :message => "Hash Mismatch"}
          result = TwocheckoutMessage.new(message).retrieve
        end
      else
          message = {:errors => [{:code => "INVALID PARAMETER", :message => "Hash was not passed"}]}
          result = TwocheckoutMessage.new(message).retrieve
      end
      result
    end
  end
end
