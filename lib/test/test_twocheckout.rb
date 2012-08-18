require 'minitest/spec'
require 'minitest/autorun'
require '../../lib/twocheckout.rb'

describe Twocheckout::Sale do
  before do
    Twocheckout.api_credentials=({'username' => 'apichristenson', 'password' => 'qwe'})
  end

  #retrieve sale
  it "Sale retrieve returns sale" do
    action = Twocheckout::Sale.retrieve({'sale_id' => 4765378756})
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
    action = Twocheckout::Sale.refund({'sale_id' => 4742525399, 'comment' => "test refund", 'category' => 1})
    action = JSON.parse(action)
    assert_equal('refund added to invoice', action['response_message'])
  end

  #refund invoice
  it "Sale refund returns successful result when passing invoice_id" do
    action = Twocheckout::Sale.refund({'invoice_id' => 4742525399, 'comment' => "test refund", 'category' => 1})
    action = JSON.parse(action)
    assert_equal('refund added to invoice', action['response_message'])
  end

  #refund lineitem
  it "Sale refund returns successful result when passing lineitem_id" do
    action = Twocheckout::Sale.refund({'lineitem_id' => 4742525399, 'comment' => "test refund", 'category' => 1})
    action = JSON.parse(action)
    assert_equal('lineitem refunded', action['response_message'])
  end

  #stop recurring lineitem
  it "Sale stop returns successful result when passing lineitem_id" do
    action = Twocheckout::Sale.stop({'lineitem_id' => 4742525399})
    action = JSON.parse(action)
    assert_equal('Recurring billing stopped for lineitem', action['response_message'])
  end

  #stop recurring sale
  it "Sale stop returns successful result when passing sale_id" do
    action = Twocheckout::Sale.stop('sale_id' => 4742525399)
    action = JSON.parse(action[0])
    assert_equal('Recurring billing stopped for lineitem', action['response_message'])
  end

  #create comment
  it "Sale comment returns successful result" do
    action = Twocheckout::Sale.comment({'sale_id' => 4765378756, 'sale_comment' => "test"})
    action = JSON.parse(action)
    assert_equal('Created comment successfully.', action['response_message'])
  end

  #mark shipped
  it "Sale ship returns successful result" do
    action = Twocheckout::Sale.ship({'sale_id' => 4765378756, 'tracking_number' => "test"})
    action = JSON.parse(action)
    assert_equal('Sale marked shipped.', action['response_message'])
  end

  #reauth
  it "Sale reauth returns successful result" do
    action = Twocheckout::Sale.reauth({'sale_id' => 4765378756})
    action = JSON.parse(action)
    assert_equal('Payment reauthorized.', action['response_message'])
  end
end

describe Twocheckout::Product do
  before do
    Twocheckout.api_credentials=({'username' => 'apichristenson', 'password' => 'qwe'})
  end

  #create
  it "Product create returns successful result" do
    action = Twocheckout::Product.create({'name' => "test product", 'price' => 1.00})
    action = JSON.parse(action)
    assert_equal('Product successfully created', action['response_message'])
  end

  #retrieve
  it "Product retrieve returns successful result" do
    action = Twocheckout::Product.retrieve()
    action = JSON.parse(action)
    assert_equal('Product list successfully retrieved.', action['response_message'])
  end

  #update
  it "Product update returns successful result" do
    action = Twocheckout::Product.update({'product_id' => 2267317012, 'name' => "test product"})
    action = JSON.parse(action)
    assert_equal('Product successfully updated', action['response_message'])
  end

  #delete
  it "Product delete returns successful result" do
    action = Twocheckout::Product.delete({'product_id' => 4768307843})
    action = JSON.parse(action)
    assert_equal('Product successfully deleted.', action['response_message'])
  end
end

describe Twocheckout::Coupon do
  before do
    Twocheckout.api_credentials=({'username' => 'apichristenson', 'password' => 'qwe'})
  end

  #create
  it "Coupon create returns successful result" do
    action = Twocheckout::Coupon.create({'coupon_code' => "12345678qwerty", 'date_expire' => "2012-12-01",
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
    action = Twocheckout::Coupon.update({'coupon_code' => "12345678qwerty", 'date_expire' => "2012-12-10"})
    action = JSON.parse(action)
    assert_equal('Coupon updated successfully', action['response_message'])
  end

  #delete
  it "Coupon delete returns successful result" do
    action = Twocheckout::Coupon.delete({'coupon_code' => "12345678qwerty"})
    action = JSON.parse(action)
    assert_equal('Coupon successfully deleted.', action['response_message'])
  end
end

describe Twocheckout::Option do
  before do
    Twocheckout.api_credentials=({'username' => 'apichristenson', 'password' => 'qwe'})
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
    action = Twocheckout::Option.update({'option_name' => "test option", 'option_id' => 4632824935})
    action = JSON.parse(action)
    assert_equal('Option updated successfully', action['response_message'])
  end

  #delete
  it "Option delete returns successful result" do
    action = Twocheckout::Option.delete({'option_id' => 4632824935})
    action = JSON.parse(action)
    assert_equal('Option deleted successfully', action['response_message'])
  end
end