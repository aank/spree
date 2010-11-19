module ControllerMacros

  def user_request(req)
    { 'HTTP_AUTHORIZATION' => "#{req}:xxxxxx",
      "Content-Type" => "application/json",
      "Accept" => "application/json"
    }
  end

  def uri_for(req)
    "http://example.org/api" + req
  end

  def generate_unique_email
    @@email_count ||= 0
    @@email_count += 1
    "test#{@@email_count}@email.com"
  end

  def valid_attributes(attributes={})
    { :username => "usertest",
      :email => generate_unique_email,
      :password => '123456',
      :password_confirmation => '123456' }.update(attributes)
  end

  def new_user(attributes={})
    User.new(valid_attributes(attributes))
  end
    
  def create_user(attributes={})
    User.create!(valid_attributes(attributes))
  end
  
end