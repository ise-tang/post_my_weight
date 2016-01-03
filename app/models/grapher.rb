class Grapher     
  def write_graph(weights)
    g = Gruff::Line.new
    g.title = "Recently Weights" 
     
    data = weights.collect {|w| w.weight}
    g.data("Weights", data)
     
    labels = Array.new
    if weights.length > 7 
      weights.each_with_index do |w, i|
        if i % 4 == 0
          labels.push([i ,w.created_at.in_time_zone('Tokyo').strftime("%m-%d")])
        end
      end
    else
      weights.each_with_index do |w, i|
        labels.push([i ,w.created_at.in_time_zone('Tokyo').strftime("%m-%d")])
      end
    end
      
    g.labels = Hash[*labels.flatten]
    file_name = "./tmp/my_weight_graph-#{Time.now.strftime("%Y%m%d%H%M%S")}.png" 
    g.write(file_name)

    return file_name
  end
end
