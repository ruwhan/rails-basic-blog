require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end
  
  setup do
    @user = users(:admin)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user" do
    assert_difference('User.count') do
      post :create, :user => { :email => 'someemail@fake.dom', 
							:password => 'abc123',
							:password_confirmation => 'abc123' }
    end
    
    assert_response :redirect
    assert_redirected_to posts_path
  end

  test "should get edit" do
    login_as(:admin)
    get :edit, id: @user
    assert_response :success
  end

  test "should update user" do
    login_as(:admin)
    put :update, id: @user, user: { email: @user.email, password: 'newpass', password_confirmation: 'newpass' }
    assert_redirected_to posts_path
  end
end
