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
          response = '{"code":"PASS","message:":"Hash Matched"}'
          TwocheckoutMessage.new(response).retrieve
        else
          response = '{"code":"FAIL","message:":"Hash Mismatch"}'
          TwocheckoutMessage.new(response).retrieve
        end
      else
        response = '{"code":"INVALID PARAMETER","message:":"Hash was not passed"}'
        TwocheckoutMessage.new(response).retrieve
      end
      response
    end
  end
end