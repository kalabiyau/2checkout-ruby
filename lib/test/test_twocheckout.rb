require 'minitest/spec'
require 'minitest/autorun'
require '../../lib/twocheckout.rb'

describe Twocheckout::Sale do
  before do
    Twocheckout.api_credentials=({'username' => 'APIuser1817037', 'password' => 'APIpass1817037'})
  end

  #retrieve sale
  it "Sale retrieve returns sale" do
    action = Twocheckout::Sale.retrieve({'sale_id' => 4786293822})
    action = JSON.parse(action)
    assert_equal('Sale detail retrieved', action['response_message'])
  end

  #retrieve invoice
  it "Sale retrieve returns sale" do
    action = Twocheckout::Sale.retrieve({'invoice_id' => 4786293831})
    action = JSON.parse(action)
    assert_equal('Sale detail retrieved', action['response_message'])
  end

  #retrieve list
  it "Sale retrieve returns list" do
    action = Twocheckout::Sale.retrieve()
    action = JSON.parse(action)
    assert_equal('Sales summaries retrieved successfully.', action['response_message'])
  end

  #refund sale
  it "Sale refund returns successful result when passing sale_id" do
    action = Twocheckout::Sale.refund({'sale_id' => 4786293822, 'comment' => "test refund", 'category' => 1})
    action = JSON.parse(action)
    if action['response_message']
      assert_equal('refund added to invoice', action['response_message'])
    else
      assert_equal('Invoice was already refunded.', action["errors"][0]["message"])
    end
  end

  #refund invoice
  it "Sale refund returns successful result when passing invoice_id" do
    action = Twocheckout::Sale.refund({'invoice_id' => 4786293831, 'comment' => "test refund", 'category' => 1})
    action = JSON.parse(action)
    if action['response_message']
      assert_equal('refund added to invoice', action['response_message'])
    else
      assert_equal("Invoice was already refunded.", action["errors"][0]["message"])
    end
  end

  #refund lineitem
  it "Sale refund returns successful result when passing lineitem_id" do
    action = Twocheckout::Sale.refund({'lineitem_id' => 4789788509, 'comment' => "test refund", 'category' => 1})
    action = JSON.parse(action)
    if action['response_message']
      assert_equal('lineitem refunded', action['response_message'])
    else
      assert_equal('This lineitem cannot be refunded.', action["errors"][0]["message"])
    end
  end

  #stop recurring lineitem
  it "Sale stop returns successful result when passing lineitem_id" do
    action = Twocheckout::Sale.stop({'lineitem_id' => 4789788509})
    action = JSON.parse(action)
    if action['response_message']
      assert_equal('Recurring billing stopped for lineitem', action['response_message'])
    else
      assert_equal('Lineitem is not scheduled to recur.', action["errors"][0]["message"])
    end
  end

  #stop recurring sale
  it "Sale stop returns successful result when passing sale_id" do
    action = Twocheckout::Sale.stop('sale_id' => 4786293822)
    action = JSON.parse(action)
    if action[0]
     assert_equal('Recurring billing stopped for lineitem', action['response_message'])
    else
      assert_equal("No Active recurring lineitems.", action["errors"][0]["message"])
    end
  end

  #create comment
  it "Sale comment returns successful result" do
    action = Twocheckout::Sale.comment({'sale_id' => 4786293822, 'sale_comment' => "test"})
    action = JSON.parse(action)
    assert_equal('Created comment successfully.', action['response_message'])
  end

  #mark shipped
  it "Sale ship returns successful result" do
    action = Twocheckout::Sale.ship({'sale_id' => 4786293822, 'tracking_number' => "test"})
    action = JSON.parse(action)
    if action['response_message']
      assert_equal('Sale marked shipped.', action['response_message'])
    else
      assert_equal('Item not shippable.', action["errors"][0]["message"])
    end
  end

  #reauth
  it "Sale reauth returns successful result" do
    action = Twocheckout::Sale.reauth({'sale_id' => 4786293822})
    action = JSON.parse(action)
    if action['response_message']
      assert_equal('Payment reauthorized.', action['response_message'])
    else
      assert_equal('Payment is already pending or deposited and cannot be reauthorized.', action["errors"][0]["message"])
    end
  end
end

describe Twocheckout::Product do
  before do
    Twocheckout.api_credentials=({'username' => 'APIuser1817037', 'password' => 'APIpass1817037'})
    action = Twocheckout::Product.create({'name' => "test product", 'price' => 1.00})
    action = JSON.parse(action)
    @product_id = action['product_id']
  end

  #create
  it "Product create returns successful result" do
    action = Twocheckout::Product.create({'name' => "test product", 'price' => 1.00})
    action = JSON.parse(action)
    assert_equal('Product successfully created', action['response_message'])
  end

  #retrieve list
  it "Product retrieve returns successful result" do
    action = Twocheckout::Product.retrieve()
    action = JSON.parse(action)
    assert_equal('Product list successfully retrieved.', action['response_message'])
  end

  #retrieve product
  it "Product retrieve returns successful result" do
    action = Twocheckout::Product.retrieve({'product_id' => @product_id})
    action = JSON.parse(action)
    assert_equal('Product detail information retrieved successfully', action['response_message'])
  end

  #update
  it "Product update returns successful result" do
    action = Twocheckout::Product.update({'product_id' => @product_id, 'name' => "test product"})
    action = JSON.parse(action)
    assert_equal('Product successfully updated', action['response_message'])
  end

  #delete
  it "Product delete returns successful result" do
    action = Twocheckout::Product.delete({'product_id' => @product_id})
    action = JSON.parse(action)
    assert_equal('Product successfully deleted.', action['response_message'])
  end
end

describe Twocheckout::Coupon do
  before do
    Twocheckout.api_credentials=({'username' => 'APIuser1817037', 'password' => 'APIpass1817037'})
    action = Twocheckout::Coupon.create({'date_expire' => "2099-12-01",
                                         'type' => "shipping", 'minimum_purchase' => 1.00})
    action = JSON.parse(action)
    @coupon_code = action['coupon_code']
  end

  #create
  it "Coupon create returns successful result" do
    action = Twocheckout::Coupon.create({'date_expire' => "2099-12-01",
                                         'type' => "shipping", 'minimum_purchase' => 1.00})
    action = JSON.parse(action)
    assert_equal('Coupon successfully created', action['response_message'])
  end

  #retrieve
  it "Coupon retrieve returns successful result" do
    action = Twocheckout::Coupon.retrieve()
    action = JSON.parse(action)
    assert_equal('Coupon information retrieved successfully.', action['response_message'])
  end

  #update
  it "Coupon update returns successful result" do
    action = Twocheckout::Coupon.update({'coupon_code' => @coupon_code, 'date_expire' => "2099-12-10"})
    action = JSON.parse(action)
    assert_equal('Coupon updated successfully', action['response_message'])
  end

  #delete
  it "Coupon delete returns successful result" do
    action = Twocheckout::Coupon.delete({'coupon_code' => @coupon_code})
    action = JSON.parse(action)
    assert_equal('Coupon successfully deleted.', action['response_message'])
  end
end

describe Twocheckout::Option do
  before do
    Twocheckout.api_credentials=({'username' => 'APIuser1817037', 'password' => 'APIpass1817037'})
    action = Twocheckout::Option.create({'option_name' => "test product", 'option_value_name' => "example",'option_value_surcharge' => 1.00})
    action = JSON.parse(action)
    @option_id = action['option_id']
  end

  #create
  it "Option create returns successful result" do
    action = Twocheckout::Option.create({'option_name' => "test product", 'option_value_name' => "example",'option_value_surcharge' => 1.00})
    action = JSON.parse(action)
    assert_equal('Option created successfully', action['response_message'])
  end

  #retrieve
  it "Option retrieve returns successful result" do
    action = Twocheckout::Option.retrieve()
    action = JSON.parse(action)
    assert_equal('Option information retrieved successfully.', action['response_message'])
  end

  #update
  it "Option update returns successful result" do
    action = Twocheckout::Option.update({'option_name' => "test option", 'option_id' => @option_id})
    action = JSON.parse(action)
    assert_equal('Option updated successfully', action['response_message'])
  end

  #delete
  it "Option delete returns successful result" do
    action = Twocheckout::Option.delete({'option_id' => @option_id})
    action = JSON.parse(action)
    assert_equal('Option deleted successfully', action['response_message'])
  end
end

describe Twocheckout::Return do
  before do
    @params = {'order_number' => '4789848870', 'total' => '0.01', 'key' => 'CDF3E502AA1597DD4401760783432337'}
  end

  #check
  it "Return check returns successful result" do
    action = Twocheckout::Return.request({ :credentials => {'sid' => '1817037', 'secret' => 'tango'}, :params => @params})
    action = JSON.parse(action)
    assert_equal('PASS', action['code'])
  end
end

describe Twocheckout::Ins do
  before do
    @params = {'sale_id' => '4789848870', 'invoice_id' => '4789848879', 'md5_hash' => '827220324C722873694758F38D8D3624'}
  end

  #check
  it "Return check returns successful result" do
    action = Twocheckout::Ins.request({ :credentials => {'sid' => '1817037', 'secret' => 'tango'}, :params => @params})
    action = JSON.parse(action)
    assert_equal('PASS', action['code'])
  end
end
