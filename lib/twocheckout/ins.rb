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
          response = {:status => {'result' => 'pass', 'reason' => 'Hash Matched'}, :params => params}
        else
          response = {:status => {'result' => 'fail', 'reason' => 'Hash Mismatch'}, :params => params}
        end
      else
        response = {:status => {'result' => 'error', 'reason' => 'Hash was not passed.'}, :params => params}
      end
      response
    end
  end
end