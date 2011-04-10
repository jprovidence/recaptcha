require 'recaptcha'
module Rails
  module Recaptcha
    class Railtie < Rails::Railtie
      initializer "setup config" do
        begin
          ActionView::Base.send(:include, ::Recaptcha::ClientHelper)
          ActionController::Base.send(:include, ::Recaptcha::Verify)
          ActiveRecord::Base.send(:include, ::Recaptcha::ActiveRecordVerify::InstanceMethods)
        end
      end
    end
  end
end
