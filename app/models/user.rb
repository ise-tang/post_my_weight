class User < ActiveRecord::Base
  has_many :measurements

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth['provider']
      user.uid = auth['uid']
      user.screen_name = auth['info']['nickname']
      user.name = auth['info']['name']
      user.token = auth['credentials']['token']
      user.secret = auth['credentials']['secret']
    end
  end

  def check_increase
    first, second = self.measurements.sort { |a, b| b.id <=> a.id }.slice(0,2)
 
    if first.weight > second.weight then
      "↑"
    elsif first.weight < second.weight then
      "↓"
    else
      "→"
    end

  end
end
