require 'test_helper'

class PostsControllerTest < ActionController::TestCase
  setup do
    @post = posts(:hello_world)
  end

  test "should get index" do
    login_as(:admin)
    get :index
    assert_response :success
    assert_template 'index'
    assert_not_nil assigns(:posts)
  end

  test "should get new" do
    login_as(:admin)
    get :new
    assert_response :success
  end

  test "should create post" do
	login_as(:admin)
    assert_difference('Post.count') do
      post :create, :post => { :title => 'New Title', 
							:content => 'New test content',
							:created_at => DateTime.now,
							:last_updated_at => DateTime.now }
    end
    
    assert_response :redirect
    assert_redirected_to post_path(assigns(:post))
  end

  test "should show post" do
    get :show, id: @post.to_param
    assert_response :success
    assert_template :show
    
    assert_not_nil assigns(:post)
    assert assigns(:post).valid?
  end

  test "should get edit" do
    login_as(:admin)
    get :edit, id: @post
    assert_response :success
  end

  test "should update post" do
    login_as(:admin)
    put :update, id: @post, post: { content: @post.content, created_at: @post.created_at, last_updated_at: @post.last_updated_at, title: 'Title Updated!' }
    assert_redirected_to post_path(assigns(:post))
  end

  test "should destroy post" do
    login_as(:admin)
    
    assert_nothing_raised { Post.find(@post) }
    
    assert_difference('Post.count', -1) do
      delete :destroy, id: @post
    end

    assert_response :redirect
    assert_redirected_to posts_path
    
    assert_raise(ActiveRecord::RecordNotFound) { Post.find(@post) }
  end
end
