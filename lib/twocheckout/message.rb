module Twocheckout
  class TwocheckoutMessage < StandardError
    attr_reader :message

    def initialize(message=nil)
      @message = message
    end

    def retrieve
      if @message.is_a?(Hash)
        @message = JSON.generate(@message)
        "#{@message}"
      else
        "#{@message}"
      end
    end
  end
end
