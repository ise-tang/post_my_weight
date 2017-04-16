class HomeController < BaseController
  require 'gruff'

  before_action :login_required, except: [:index]
  def index
  end

  def tweet
    text = "ちわあああああああああす"
    twitter_client.update(text)
    flash[:notice] = "tweet: #{text}"
    redirect_to root_path
  end

  def post_my_weight
    text = "今の体重は#{params[:weight]}kgでした。#{params[:memo]}"
    begin
      @current_user.measurements.create!(weight: params[:weight], body_fat_percentage: params[:body_fat_percentage], memo: params[:memo])
      measurements = if @current_user.measurements.length >=7 then 
                       @current_user.measurements.slice(-7, 7)
                     else
                       @current_user.measurements
                     end
      grapher = Grapher.new
      graph_weight_image = grapher.write_weight_graph(measurements)
      graph_bfp_image = grapher.write_bfp_graph(measurements) if params[:body_fat_percentage].present?

      if current_user.update_name
        name = params[:weight].to_s + "kg" + @current_user.check_increase + "の"+ @current_user.name
        twitter_client.update_profile({:name => name})
      end

      if params[:body_fat_percentage].present?
        weight_image_id = twitter_client.upload(File.new(graph_weight_image))
        bfp_image_id = twitter_client.upload(File.new(graph_bfp_image))
        twitter_client.update(text, media_ids: [weight_image_id, bfp_image_id].join(","))
      else
        twitter_client.update_with_media(text, File.open(graph_weight_image))
      end
      flash[:notice] = "tweet: #{text}."
    rescue ActiveRecord::RecordInvalid => invalid
      @errors = invalid.record.errors
    rescue => e
      flash[:alert] = e.message
    ensure
      redirect_to root_path
    end
  end

  def post_my_weight_30
    text = "最近30回分のグラフです"
    measurements = Measurement.where("user_id = '?'", @current_user.id)
                     .order("created_at DESC")
                     .limit(30)
    measurements = measurements.sort
    grapher = Grapher.new
    graph_image = grapher.write_weight_graph(measurements)
    twitter_client.update_with_media(text, File.open(graph_image))
    flash[:notice] = "tweet: #{text}." 
    redirect_to root_path
  end

  def post_my_weight_90
    text = "最近90回分のグラフです"
    measurements = Measurement.where("user_id = '?'", @current_user.id)
                     .order("created_at DESC")
                     .limit(90)
    measurements = measurements.sort
    grapher = Grapher.new
    graph_image = grapher.write_weight_graph(measurements, 9)
    twitter_client.update_with_media(text, File.open(graph_image))
    flash[:notice] = "tweet: #{text}."
    redirect_to root_path
  end

  def post_my_weight_180
    text = "最近180回分のグラフです"
    measurements = Measurement.where("user_id = '?'", @current_user.id)
                     .order("created_at DESC")
                     .limit(180)
    measurements = measurements.sort
    grapher = Grapher.new
    graph_image = grapher.write_weight_graph(measurements, 18)
    twitter_client.update_with_media(text, File.open(graph_image))
    flash[:notice] = "tweet: #{text}."
    redirect_to root_path
  end

  def post_my_weights
    times = params[:times].to_i
    text = "最近#{times}回分のグラフです"
    measurements = Measurement.where("user_id = '?'", @current_user.id)
                     .order("created_at DESC")
                     .limit(times)
    measurements = measurements.sort
    grapher = Grapher.new
    graph_image = grapher.write_weight_graph(measurements, times/10)
    twitter_client.update_with_media(text, File.open(graph_image))
    flash[:notice] = "tweet: #{text}."
    redirect_to root_path
  end

  private
  def twitter_client
    Twitter::REST::Client.new do |config|
      config.consumer_key        = Settings.twitter.consumer_key
      config.consumer_secret     = Settings.twitter.consumer_secret
      config.access_token        = @current_user.token
      config.access_token_secret = @current_user.secret
    end
  end
end
