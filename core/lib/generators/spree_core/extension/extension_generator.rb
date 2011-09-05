require "rails/generators/rails/plugin/plugin_generator"

class SpreeCore::ExtensionGenerator < Rails::Generators::NamedBase

  desc "Creates new Spree extension"

  source_root File.expand_path("../templates", __FILE__)
  #def self.source_paths
    #paths = self.superclass.source_paths
    #paths << File.expand_path('../templates', __FILE__)
    #paths.flatten
  #end

   def create_root_files
    empty_directory file_name
    empty_directory "#{file_name}/config"
    empty_directory "#{file_name}/db"
    template "LICENSE", "#{file_name}/LICENSE"
    template "Rakefile", "#{file_name}/Rakefile"
    template "README", "#{file_name}/README"
    template "gitignore", "#{file_name}/.gitignore"
    template "extension.gemspec", "#{file_name}/#{file_name}.gemspec"
    template "Versionfile", "#{file_name}/Versionfile"
  end

  def create_app_dirs
    empty_directory "#{file_name}/app"
    empty_directory "#{file_name}/app/assets"
    empty_directory "#{file_name}/app/controllers"
    empty_directory "#{file_name}/app/helpers"
    empty_directory "#{file_name}/app/models"
    empty_directory "#{file_name}/app/views"
    empty_directory "#{file_name}/spec"
  end

  def create_lib_files
    directory "lib", "#{file_name}/lib"
  end

  def misc_stuff
    template "routes.rb", "#{file_name}/config/routes.rb"
    template "spec_helper.rb", "#{file_name}/spec/spec_helper.rb"
  end


  protected
  def plugin_dir(join=nil)
    file_name
  end

end
