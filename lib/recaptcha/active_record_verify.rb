module Recaptcha
  module ActiveRecordVerify
    module InstanceMethods
      def save_with_captcha(controller)
        return self.valid_with_captcha?(controller) ? self.save : false
      end

      def valid_with_captcha?(controller)
        captcha_verifier = build_captcha_verifier(controller)
        options_method = :options_for_recaptcha_verification
        options = controller.respond_to?(options_method) ? controller.send(options_method, self) : {}
        options.merge!({:model => self})
        self.valid? && captcha_verifier.verify_recaptcha(options)
      end
      

      def build_captcha_verifier(controller)
        returning Object.new do |validator|
          validator.class_eval do
            include Recaptcha::Verify
            define_method(:params) { controller.params }
            define_method(:request) { controller.request }
            define_method(:flash) { Hash.new } # I don't want flash error
          end
        end
      end
      private :build_captcha_verifier
    end
  end
end
