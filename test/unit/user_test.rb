require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  
  test "create post" do
    user = User.new
    user.email = "admin@fake.dom"
    user.password = "somepassword"
    assert user.save
  end
  
  test "find user" do
    user_id = users(:admin).id
    assert_nothing_raised { User.find(user_id) }
  end
  
  test "update user" do
    user = users(:admin)
    assert user.update_attributes(:password => 'newpass')
  end
  
  test "destroy user" do
    user = users(:admin)
    user.destroy
    assert_raise(ActiveRecord::RecordNotFound) { User.find(user.id) }
  end
  
  test "user validation" do
    user = User.new
    assert !user.valid?
    assert user.errors[:email].any?
    assert user.errors[:password].any?
    assert_equal ["can't be blank", "is invalid"], user.errors[:email]
    assert_equal ["can't be blank", "is too short (minimum is 6 characters)"], user.errors[:password]
    user.password = 'somepass'
    user[:password_confirmation] = 'somepass'
    assert_equal user[:password], user[:password_confirmation]
    assert !user.save
  end
end
