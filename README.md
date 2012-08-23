2Checkout Ruby Library
=====================

This library provides developers with a simple set of bindings to the 2Checkout purchase routine, Instant Notification Service and Back Office API.

To use, install:

```shell
gem install twocheckout
```

Or import into your Gemfile

```ruby
gem "twocheckout", "~> 0.0.1"
```

Full documentation for each binding will be provided in the [Wiki](https://github.com/craigchristenson/2checkout-ruby/wiki).


Example API Usage
-----------------

*Example Usage:*

```ruby
Twocheckout.api_credentials=({'username' => 'APIuser1817037', 'password' => 'APIpass1817037'})

@action = Twocheckout::Sale.refund({'sale_id' => 4769044324, 'comment' => "test refund", 'category' => 1})
puts @action
```

*Example Response:*

```json
{
   "response_code" : "OK",
   "response_message" : "refund added to invoice"
}
```

Example Checkout Usage:
-----------------------

*Example Usage:*

```ruby
require "sinatra"

get '/' do
  @@form = Twocheckout::Charge.submit({'sid' => 1817037, 'cart_order_id' => 'Example Sale', 'total' => 1.00})
  @@form
end
```

Example Return Usage:
---------------------

*Example Usage:*

```ruby
require "sinatra"

post '/' do
  @@response = Twocheckout::Return.request({ :credentials => {'sid' => '532001', 'secret' => 'tango'}, :params => params})
  @@response.inspect
end
```

*Example Response:*

```json
{
   "code" : "PASS",
   "message" : "Hash Matched"
}
```

Example INS Usage:
------------------

*Example Usage:*

```ruby
require "sinatra"

post '/' do
 @@response = Twocheckout::Ins.request({ :credentials => {'sid' => 532001, 'secret' => 'tango'}, :params => params})
 @@response.inspect
end
```

*Example Response:*

```json
{
   "code" : "PASS",
   "message" : "Hash Matched"
}
```

Full documentation for each binding will be provided in the [Wiki](https://github.com/craigchristenson/2checkout-ruby/wiki).
