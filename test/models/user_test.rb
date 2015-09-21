require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  setup do
    @user = User.new
    @user.save
  end


  test "体重が増えた場合 check_increase が ↑ を返す" do
    @user.weights.create(weight: 80)
    @user.weights.create(weight: 85)
    
    assert_equal "↑", @user.check_increase
  end

  test "体重がへった場合 check_increase が ↓ を返す" do
    @user.weights.create(weight: 80)
    @user.weights.create(weight: 75)
    
    assert_equal "↓", @user.check_increase
  end

  test "体重が変わらない場合 check_increase が → を返す" do
    @user.weights.create(weight: 80)
    @user.weights.create(weight: 80)
    
    assert_equal "→", @user.check_increase
  end
end
