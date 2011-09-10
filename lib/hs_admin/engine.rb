require 'action_controller'
require 'hs_admin/action_controller_extend'
require 'hs_admin/application_helper_extend'

module HS
  class Engine < Rails::Engine
    engine_name :hs_admin
    
    initializer "hs_admin.load_app_instance_data" do |app|
      HS.setup do |config|
        config.app_root = app.root  
        ApplicationController.helper(HS::ApplicationHelperExtend)
      end  
    end
    
    initializer "hs_admin.load_static_assets" do |app|
      app.middleware.use ::ActionDispatch::Static, "#{root}/public"
    end
    
  end
end