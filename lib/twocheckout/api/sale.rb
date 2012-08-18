module Twocheckout
  class Sale

    def self.retrieve(params={})
      if params.has_key?("sale_id" || "invoice_id")
        Twocheckout.request(:get, 'sales/detail_sale', params)
      else
        Twocheckout.request(:get, 'sales/list_sales', params)
      end
    end

    def self.refund(params={})
      if params.has_key?("lineitem_id")
        Twocheckout.request(:post, 'sales/refund_lineitem', params)
      elsif params.has_key?("sale_id" || "invoice_id")
        Twocheckout.request(:post, 'sales/refund_invoice', params)
      else
        result = '{"errors":{"code":"INVALID PARAMETER","message:":"You must pass a sale_id, invoice_id or lineitem_id."}}'
        TwocheckoutMessage.new(result).retrieve
      end
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
          result = '{"errors":{"code":"NOTICE","message:":"No Active recurring lineitems."}}'
          TwocheckoutMessage.new(result).retrieve
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
        result = '{"errors":{"code":"INVALID PARAMETER","message:":"You must pass a sale_id or invoice_id."}}'
        TwocheckoutMessage.new(result).retrieve
      end
      result
    end

    def self.comment(params={})
      if params.has_key?("sale_id" && "sale_comment")
        Twocheckout.request(:post, 'sales/create_comment', params)
      else
        result = '{"errors":{"code":"INVALID PARAMETER","message:":"You must pass a sale_id and sale_comment."}}'
        TwocheckoutMessage.new(result).retrieve
      end
    end

    def self.ship(params={})
      if params.has_key?("sale_id" && "tracking_number")
        Twocheckout.request(:post, 'sales/mark_shipped', params)
      else
        result = '{"errors":{"code":"INVALID PARAMETER","message:":"You must pass a sale_id and tracking_number."}}'
        TwocheckoutMessage.new(result).retrieve
      end
    end

    def self.reauth(params={})
      if params.has_key?("sale_id" || "invoice_id")
        Twocheckout.request(:post, 'sales/reauth', params)
      else
        result = '{"errors":{"code":"INVALID PARAMETER","message:":"You must pass a sale_id or invoice_id."}}'
        TwocheckoutMessage.new(result).retrieve
      end
    end
  end
end