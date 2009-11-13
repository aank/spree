#used to load default data, now a task (db:defaults) in extensions.rake

puts "Loading db/seeds.rb for each extension"
extension_roots = Spree::ExtensionLoader.instance.load_extension_roots
extension_roots.each do |extension_root|
  seeds = "#{extension_root}/db/seeds.rb"
  require seeds if File.exists? seeds
end
