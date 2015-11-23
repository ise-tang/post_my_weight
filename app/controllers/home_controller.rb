class HomeController < BaseController
  require 'gruff'

  before_action :login_required, only: [:tweet, :post_my_weight, :post_my_weight_30]
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
    weights = if @current_user.weights.length >=7 then 
                @current_user.weights.slice(-7, 7)
              else
                @current_user.weights
              end
    grapher = Grapher.new
    graph_image = grapher.write_graph(weights)
    name = params[:weight].to_s + "kg" + @current_user.check_increase + "の"+ @current_user.name
    twitter_client.update_profile({:name => name})
    twitter_client.update_with_media(text, File.open(graph_image))
    flash[:notice] = "tweet: #{text}." 
    redirect_to root_path
  end

  def post_my_weight_30
    text = "最近30回分のグラフです"
    weights = Weight.where("user_id = '?'", @current_user.id)
                     .order("created_at DESC")
                     .limit(30)
    grapher = Grapher.new
    graph_image = grapher.write_graph(weights)
    twitter_client.update_with_media(text, File.open(graph_image))
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
