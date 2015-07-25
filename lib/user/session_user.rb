class SessionUser
  def initialize(session)
    @name = session[:name]
    @uid = session[:user_id]
    @token = session[:oauth_token]
    @secret = session[:oauth_token_secret]
  end

  attr_reader :name, :uid, :token, :secret
end
