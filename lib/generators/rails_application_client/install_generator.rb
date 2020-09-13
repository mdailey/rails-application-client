
require 'rails/generators'

module RailsApplicationClient
  module Generators
    class InstallGenerator < Rails::Generators::Base

      source_root File.expand_path('../templates', __FILE__)

      class_option :appname, type: :string
      class_option :hostname, type: :string

      def install_app_config_model
        @app_name = options[:appname]
        @hostname = options[:hostname]
        generate 'model', 'app_config', 'ssl_cert:text', 'ssl_pk:text', 'ca_cert:text', 'ca_pk:text'
        if /class AppConfig < ApplicationRecord\nend/m.match(File.read('app/models/app_config.rb'))
          remove_file 'app/models/app_config.rb'
        end
        template 'app_config.erb', 'app/models/app_config.rb'
      end

      def install_client_model
        generate 'model', 'client', 'name:string', 'description:string', 'ssl_cert:text', 'ssl_pk:text'
        if /class Client < ApplicationRecord\nend/m.match(File.read('app/models/client.rb'))
          remove_file 'app/models/client.rb'
        end
        template 'client.erb', 'app/models/client.rb'
      end

      def install_client_user
        generate 'model', 'client_user', 'client:references', 'user:references'
      end

      def install_clients_controller
        # Clients controller generation

        generate 'controller', 'Clients'
        template 'clients_controller.erb', 'app/controllers/clients_controller.rb'

        # ApplicationController changes

        app_controller_file = 'app/controllers/application_controller.rb'
        inject_into_class app_controller_file, ApplicationController, "  before_action :load_configuration\n"

        app_controller_contents = File.read(app_controller_file)
        unless /private$/m.match(app_controller_contents)
          insert_into_file app_controller_file, "\n  private\n\n", before: /^end/
        end

        application_controller_text = <<END_APPLICATION_CONTROLLER


  def redirect_permission_failed
    if request.env["HTTP_REFERER"].present? and request.env["HTTP_REFERER"] != request.env["REQUEST_URI"]
      redirect_to :back
    else
      redirect_to root_path
    end
  end

  def authorize
    unless current_user.is_admin?
      flash[:error] = not_authorize_msg
      redirect_permission_failed
    end
  end

  def load_configuration
    @configuration = AppConfig.instance
    if !@configuration.configured and request.path != configuration_path.split('?')[0]
      redirect_to configuration_path
    end
    if @configuration.configured
      authenticate_user! unless @authenticated_client
    end
    set_locale
    @configuration.check_keys
  end
END_APPLICATION_CONTROLLER
        insert_into_file 'app/controllers/application_controller.rb',
                         application_controller_text, after: /private/
      end
    end
  end
end