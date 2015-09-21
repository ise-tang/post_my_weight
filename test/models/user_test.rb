require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "体重が増えた場合 increase? が true を返す" do
    user = User.new
    user.weights.create(weight: 80)
    user.weights.create(weight: 85)
    
    assert_equal true, user.increase?
  end
end
