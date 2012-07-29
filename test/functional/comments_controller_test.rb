require 'test_helper'

class CommentsControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end
  setup do
    @post = posts(:hello_world)
    @comment = comments(:some_comment)
  end
  
  test "should get new" do 
    get :new, :post_id => @post.id
    assert_response :success
  end
  
  test "should create comment" do
    # testing html response
    assert_difference('Comment.count') do
      post :create, :post_id => @post.id, :comment => { :name => 'tester', :comment => 'just testing' }
    end
    
    assert_response :redirect
    assert_redirected_to post_path(assigns(:post))
    
    # testing js response
    assert_difference('Comment.count') do
      post :create, :post_id => @post.id, :comment => { :name => 'js tester', :comment => 'just testing javascript response' }, format: :js
    end
    
    assert_response :success
  end
  
  
  
  test "should destroy comment" do
    login_as(:admin)
    
    assert_nothing_raised { @post.comments.find(@comment) }
    
    assert_difference('Comment.count', -1) do
      delete :destroy, :post_id => @post.id, id: @comment.id
    end

    assert_response :redirect
    assert_redirected_to post_path(@post)
    
    assert_raise(ActiveRecord::RecordNotFound) { @post.comments.find(@comment) }
  end
  
  test "should destroy comment and respond with js" do
    login_as(:admin)
    
    assert_nothing_raised { @post.comments.find(@comment) }
    
    assert_difference('Comment.count', -1) do
      delete :destroy, :post_id => @post.id, id: @comment.id, format: :js
    end

    assert_response :success
    
    assert_raise(ActiveRecord::RecordNotFound) { @post.comments.find(@comment) }
  end
end
