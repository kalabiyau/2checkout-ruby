module Twocheckout
  class Sale

    def self.retrieve(params={})
      if params.has_key?("sale_id") || params.has_key?("invoice_id")
        Twocheckout.request(:get, 'sales/detail_sale', params)
      else
        Twocheckout.request(:get, 'sales/list_sales', params)
      end
    end

    def self.refund(params={})
      if params.has_key?("lineitem_id")
        result = Twocheckout.request(:post, 'sales/refund_lineitem', params)
      elsif params.has_key?("sale_id") || params.has_key?("invoice_id")
        result = Twocheckout.request(:post, 'sales/refund_invoice', params)
      else
        message = {:errors => [{:code => "INVALID PARAMETER", :message => "You must pass a sale_id, invoice_id or lineitem_id."}]}
        result = TwocheckoutMessage.new(message).retrieve
      end
      result
    end

    def self.stop(params={})
      if params.has_key?("lineitem_id")
        result = Twocheckout.request(:post, 'sales/stop_lineitem_recurring', params)
      elsif params.has_key?("sale_id")
        @sale = Twocheckout.request(:get, 'sales/detail_sale', params)
        @sale = JSON.parse(@sale)
        if @sale.has_key?("errors")
          return @sale
        end
        @lineitems = Twocheckout::Util.active(@sale)
        if @lineitems.empty?
          message = {:errors => [{:code => "NOTICE", :message => "No Active recurring lineitems."}]}
          result = TwocheckoutMessage.new(message).retrieve
        else
          result = {}
          i=0
          @lineitems.each do |k,v|
            params={'lineitem_id' => v}
            response = Twocheckout.request(:post, 'sales/stop_lineitem_recurring', params)
            result[i] = response
            i+=1
          end
        end
      else
        message = {:errors => [{:code => "INVALID PARAMETER", :message => "You must pass a sale_id or lineitem_id."}]}
        result = TwocheckoutMessage.new(message).retrieve
      end
      result
    end

    def self.comment(params={})
      if params.has_key?("sale_id" && "sale_comment")
        result = Twocheckout.request(:post, 'sales/create_comment', params)
      else
        message = {:errors => [{:code => "INVALID PARAMETER", :message => "You must pass a sale_id and sale_comment."}]}
        result = TwocheckoutMessage.new(message).retrieve
      end
      result
    end

    def self.ship(params={})
      if params.has_key?("sale_id" && "tracking_number")
        result = Twocheckout.request(:post, 'sales/mark_shipped', params)
      else
        message = {:errors => [{:code => "INVALID PARAMETER", :message => "You must pass a sale_id and tracking_number."}]}
        result = TwocheckoutMessage.new(message).retrieve
      end
      result
    end

    def self.reauth(params={})
      if params.has_key?("sale_id") || params.has_key?("invoice_id")
        result = Twocheckout.request(:post, 'sales/reauth', params)
      else
        message = {:errors => [{:code => "INVALID PARAMETER", :message => "You must pass a sale_id or invoice_id."}]}
        result = TwocheckoutMessage.new(message).retrieve
      end
      result
    end
  end
end
