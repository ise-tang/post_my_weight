class HomeController < BaseController
  before_action :login_required, only: [:tweet, :post_my_weight]
  def index
  end

  def tweet
    text = "ちわあああああああああす"
    twitter_client.update(text)
    flash[:notice] = "tweet: #{text}"
    redirect_to root_path
  end

  def post_my_weight
    text = "今の体重は#{params[:weight]}kgでした"
    @current_user.weights.create(weight: params[:weight])
    #twitter_client.update(text)
    flash[:notice] = "tweet: #{text}." 
    redirect_to root_path
  end

  private
  def twitter_client
    Twitter::Client.new(
      :oauth_token        => @current_user.token,
      :oauth_token_secret => @current_user.secret
    )
  end
end
