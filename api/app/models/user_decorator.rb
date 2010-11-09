User.class_eval do

  def clear_api_key!
    self.update_attribute(:api_key, "")
  end

  def generate_api_key!
    self.update_attribute(:api_key, secure_digest(Time.now, (1..10).map{ rand.to_s }))
  end
  
  def self.authenticate_with_http(username, password) 
    self.authenticate_with_token(:auth_token => username) 
  end
    
  private

  def secure_digest(*args)
    Digest::SHA1.hexdigest(args.flatten.join('--'))
  end

end