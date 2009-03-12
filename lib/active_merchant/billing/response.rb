module ActiveMerchant #:nodoc:
  module Billing #:nodoc:
  
    class Error < ActiveMerchantError #:nodoc:
    end
  
    class Response
      attr_reader :params, :message, :test, :authorization, :avs_result, :cvv_result
      
      def success?
        @success
      end

      def test?
        @test
      end
      
      def fraud_review?
        @fraud_review
      end
      
      def requires_3dsecure?
        @requires_3dsecure
      end
      
      def initialize(success, message, params = {}, options = {})
        @success, @message, @params = success, message, params.stringify_keys
        @test = options[:test] || false        
        @authorization = options[:authorization]
        @fraud_review = options[:fraud_review]
        @requires_3dsecure = (@params["Status"] == "3DAUTH")
        @avs_result = AVSResult.new(options[:avs_result]).to_hash
        @cvv_result = CVVResult.new(options[:cvv_result]).to_hash
      end
    end
  end
end
