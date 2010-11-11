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

end