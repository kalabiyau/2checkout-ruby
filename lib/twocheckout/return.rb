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
          response = {:status => {'result' => 'pass', 'reason' => 'Hash Matched'}, :params => params}
        else
          response = {:status => {'result' => 'fail', 'reason' => 'Hash Mismatch'}, :params => params}
        end
      else
        response = {:status => {'result' => 'error', 'reason' => 'You must pass a hash or string.'}, :params => params}
      end
      response
    end
  end
end