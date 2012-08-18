module Twocheckout
  class Return

    # Checks against MD5 Hash
    def self.check(secret, sid, order_number, total, key)
      Digest::MD5.hexdigest("#{secret}#{sid}#{order_number}#{total}").upcase == key
    end

    # Parses Header Redirect Query String
    def self.request(options={})
      params = options[:params]
      credentials = options[:credentials]
      if params.is_a?(String)
        params = Twocheckout::Util.parse(params)
      end
      if params['demo'] == 'Y'
        params['order_number'] = 1
      end
      if params.is_a?(Hash)
        if check(credentials['secret'], credentials['sid'], params['order_number'], params['total'], params['key'])
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