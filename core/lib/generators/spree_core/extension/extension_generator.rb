require "rails/generators/rails/plugin/plugin_generator"

module SpreeCore
  module Generators
    class ExtensionGenerator < Rails::Generators::PluginGenerator

      def self.source_paths
        paths = self.superclass.source_paths
        paths << File.expand_path('../templates', __FILE__)
        paths.flatten
      end

      protected
      def plugin_dir(join=nil)
        file_name
      end

    end
  end
end
