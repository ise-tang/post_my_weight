class Measurement < ActiveRecord::Base
  belongs_to :user

  validates :weight, presence: true, numericality: {:greater_than => 0 }
  validates :body_fat_percentage, numericality: {:greater_than => 0 }, allow_blank: true
end
