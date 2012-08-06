module Twocheckout
  class Util

    # Parse Header Redirect
    def self.parse(querystring)
      params = querystring.split('&').inject({}) do |result, q|
        k,v = q.split('=')
        if !v.nil?
          result.merge({k => v})
        elsif !result.key?(k)
          result.merge({k => true})
        else
          result
        end
      end
      params
    end

    # Get active recurring lineitems
    def self.active(params)
      @invoice = params['sale']['invoices'].last['lineitems']
      @lineitems = {}
      i=0
      @invoice.each do |li|
        if li['billing']['recurring_status'] == 'active'
          li.each do |k,v|
            if k == "lineitem_id"
              @lineitems[i] = v
              i+=1
            end
          end
        end
      end
      @lineitems
    end
  end
end