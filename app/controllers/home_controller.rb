class HomeController < BaseController
  require 'gruff'

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
    graph_image = write_graph(@current_user.weights)
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

  private
  def write_graph(weights)
    g = Gruff::Line.new
    g.title = "Recently Weights" 
     
    data = weights.collect {|w| w.weight}
    g.data("Weights", data)
     
    labels = Array.new
    weights.each_with_index do |w, i|
      labels.push([i ,w.created_at.in_time_zone('Tokyo').strftime("%m-%d")])
    end
      
    g.labels = Hash[*labels.flatten]
    file_name = "./tmp/graphes/my_weight_graph-#{Time.now.strftime("%Y%m%d%H%M%S")}.png" 
    g.write(file_name)

    return file_name
  end

end
