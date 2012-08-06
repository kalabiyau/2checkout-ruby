# Currently just checks to make sure bindings are mapping.
# I'll make these tests more useful in the future.

require 'minitest/spec'
require 'minitest/autorun'
require '../../lib/twocheckout.rb'

describe Twocheckout::Sale do
  before do
    Twocheckout.api_credentials=({'username' => 'APIuser1817037', 'password' => 'APIpass1817037'})
  end

  #retrieve sale
  it "Sale retrieve returns sale" do
    action = Twocheckout::Sale.retrieve({'sale_id' => 4774380224})
    action = JSON.parse(action)
    assert_equal('OK', action['response_code'])
  end

  #retrieve list
  it "Sale retrieve returns list" do
    action = Twocheckout::Sale.retrieve()
    action = JSON.parse(action)
    assert_equal('OK', action['response_code'])
  end

  #refund sale
  it "Sale refund returns successful result when passing sale_id" do
    action = Twocheckout::Sale.refund({'sale_id' => 4774380224, 'comment' => "test refund", 'category' => 1})
    action = JSON.parse(action)
    assert_equal('Invoice was already refunded.', action['errors'][0]['message'])
  end

  #stop recurring sale
  it "Sale stop returns successful result when passing sale_id" do
    action = Twocheckout::Sale.stop('sale_id' => 4774380224)
    action = JSON.parse(action)
    assert_equal('No Active recurring lineitems.', action['errors']['message'])
  end

  #create comment
  it "Sale comment returns successful result" do
    action = Twocheckout::Sale.comment({'sale_id' => 4774380224, 'sale_comment' => "test"})
    action = JSON.parse(action)
    assert_equal('Created comment successfully.', action['response_message'])
  end

  #mark shipped
  it "Sale ship returns successful result" do
    action = Twocheckout::Sale.ship({'sale_id' => 4774380224, 'tracking_number' => "test"})
    action = JSON.parse(action)
    assert_equal('Sale already marked shipped.', action['errors'][0]['message'])
  end

  #reauth
  it "Sale reauth returns successful result" do
    action = Twocheckout::Sale.reauth({'sale_id' => 4774380224})
    action = JSON.parse(action)
    assert_equal('Payment is already pending or deposited and cannot be reauthorized.', action['errors'][0]['message'])
  end
end

describe Twocheckout::Product do
  before do
    Twocheckout.api_credentials=({'username' => 'APIuser1817037', 'password' => 'APIpass1817037'})
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
    assert_equal('OK', action['response_code'])
  end

  #update
  it "Product update returns successful result" do
    action = Twocheckout::Product.update({'product_id' => 4774376165, 'name' => "test product"})
    action = JSON.parse(action)
    assert_equal('Failed to update product.', action['errors'][0]['message'])
  end

  #delete
  it "Product delete returns successful result" do
    action = Twocheckout::Product.delete({'product_id' => 4774376165})
    action = JSON.parse(action)
    assert_equal('Unable to find product.', action['errors'][0]['message'])
  end
end

describe Twocheckout::Coupon do
  before do
    Twocheckout.api_credentials=({'username' => 'APIuser1817037', 'password' => 'APIpass1817037'})
  end

  #create
  it "Coupon create returns successful result" do
    action = Twocheckout::Coupon.create({'coupon_code' => "ruby2345", 'date_expire' => "2012-12-01",
                                         'type' => "shipping", 'minimum_purchase' => 1.00})
    action = JSON.parse(action)
    Twocheckout::Coupon.delete({'coupon_code' => "ruby2345"})
    assert_equal('PARAMETER_INVALID', action['errors'][0]['code'])
  end

  #retrieve
  it "Coupon retrieve returns successful result" do
    action = Twocheckout::Coupon.retrieve()
    action = JSON.parse(action)
    assert_equal('Coupon information retrieved successfully.', action['response_message'])
  end

  #update
  it "Coupon update returns successful result" do
    action = Twocheckout::Coupon.update({'coupon_code' => "rubylibrarytest1", 'date_expire' => "2012-12-10"})
    action = JSON.parse(action)
    assert_equal('OK', action['response_code'])
  end

  #delete
  it "Coupon delete returns successful result" do
    action = Twocheckout::Coupon.delete({'coupon_code' => "rubylibrarytest2"})
    action = JSON.parse(action)
    assert_equal('Coupon successfully deleted.', action['response_message'])
  end
end

describe Twocheckout::Option do
  before do
    Twocheckout.api_credentials=({'username' => 'APIuser1817037', 'password' => 'APIpass1817037'})
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
    assert_equal('OK', action['response_code'])
  end

  #update
  it "Option update returns successful result" do
    action = Twocheckout::Option.update({'option_name' => "test option", 'option_id' => 123})
    action = JSON.parse(action)
    assert_equal('Unable to find option.', action['errors'][0]['message'])
  end

  #delete
  it "Option delete returns successful result" do
    action = Twocheckout::Option.delete({'option_id' => 123})
    action = JSON.parse(action)
    assert_equal('Unable to find option.', action['errors'][0]['message'])
  end
end