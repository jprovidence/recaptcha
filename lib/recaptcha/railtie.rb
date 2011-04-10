require 'recaptcha'
module Rails
  module Recaptcha
    class Railtie < Rails::Railtie
      
      config.before_configuration do 
        config.i18n.load_path += Dir[Pathname.new(File.expand_path('../', File.dirname(File.expand_path(__FILE__)))).join('locales', '*.{yml}')]
      end
      
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
