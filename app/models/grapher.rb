class Grapher     
  def write_graph(measurements)
    g = Gruff::Line.new
    g.title = "Recently Weights" 
     
    weights =     measurements.collect {|w| w.weight}
    percentages = measurements.collect {|w| w.body_fat_percentage}
    g.data("Weights", weights)
    g.data("Body Fat Percentage", percentages) unless percentages.nil?
     
    labels = Array.new
    if measurements.length > 7 
      measurements.each_with_index do |w, i|
        if i % 4 == 0
          labels.push([i ,w.created_at.in_time_zone('Tokyo').strftime("%m-%d")])
        end
      end
    else
      measurements.each_with_index do |w, i|
        labels.push([i ,w.created_at.in_time_zone('Tokyo').strftime("%m-%d")])
      end
    end
      
    g.labels = Hash[*labels.flatten]
    file_name = "./tmp/my_weight_graph-#{Time.now.strftime("%Y%m%d%H%M%S")}.png" 
    g.write(file_name)

    return file_name
  end
end
