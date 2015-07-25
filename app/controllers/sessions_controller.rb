class SessionsController < ApplicationController
  def callback
    auth = request.env['omniauth.auth']
    # sessionに保持するように変更
    session[:user_id] = auth['uid']
    session[:name] = auth['info']['name']
    # 投稿に必要なauth_token, secret_tokenも取得する
    session[:oauth_token] = auth['credentials']['token']
    session[:oauth_token_secret] = auth['credentials']['secret']
    redirect_to root_path
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end
