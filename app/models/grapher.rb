class Grapher     
  def write_weight_graph(measurements, label_span=4)
    g = Gruff::Line.new
    g.title = "Recently Weights"
    g.y_axis_increment = 0.5

    weights =     measurements.collect {|w| w.weight}
    g.data("Weights", weights)

    labels = Array.new
    if measurements.length > 7
      measurements.each_with_index do |w, i|
        if i % label_span == 0
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

  def write_bfp_graph(measurements)
    g = Gruff::Line.new
    g.title = "Recently Body Fat Percentage"
    g.y_axis_increment = 0.5

    percentages = measurements.collect {|w| w.body_fat_percentage}
    g.data("Body Fat Percentage", percentages)

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
    file_name = "./tmp/my_bfp_graph-#{Time.now.strftime("%Y%m%d%H%M%S")}.png" 
    g.write(file_name)

    return file_name
  end
end
