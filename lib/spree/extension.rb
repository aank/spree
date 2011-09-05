module Spree
  class Extension < Thor
    include Thor::Actions

    def self.source_root
      File.dirname(__FILE__) + '/templates/extension'
    end

    desc "generate NAME", "generate extension"
    def generate(name)

      class_path = name.include?('/') ? name.split('/') : name.split('::')
      class_path.map! { |m| m.underscore }
      self.file_name = 'spree_' + class_path.pop
      self.human_name = name.titleize
      self.class_name = file_name.classify

      empty_directory file_name

      directory "app", "#{file_name}/app"

      empty_directory "#{file_name}/app/controllers"
      empty_directory "#{file_name}/app/helpers"
      empty_directory "#{file_name}/app/models"
      empty_directory "#{file_name}/app/views"
      empty_directory "#{file_name}/config"
      empty_directory "#{file_name}/db"

      directory "lib", "#{file_name}/lib"

      empty_directory "#{file_name}/spec"

      template "LICENSE", "#{file_name}/LICENSE"
      template "Rakefile", "#{file_name}/Rakefile"
      template "README", "#{file_name}/README"
      template "gitignore", "#{file_name}/.gitignore"
      template "extension.gemspec", "#{file_name}/#{file_name}.gemspec"
      template "Versionfile", "#{file_name}/Versionfile"
      template "Gemfile", "#{file_name}/Gemfile"
      template "routes.rb", "#{file_name}/config/routes.rb"
      template "spec_helper.rb", "#{file_name}/spec/spec_helper.rb"
    end

    no_tasks do
      # File/Lib Name (ex. spree_paypal_express)
      attr_accessor :file_name
    end

    no_tasks do
      # Human Readable Name (ex. Paypal Express)
      attr_accessor :human_name
    end

    no_tasks do
      # Class Name (ex. PaypalExpress)
      attr_accessor :class_name
    end
  end
end
