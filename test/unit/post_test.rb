require 'test_helper'

class PostTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  
  test "should create post" do
    post = Post.new
    post.user = users(:admin)
    post.title = "Hello World"
    post.content = "First rails unit test on my blog post"
    assert post.save
  end
  
  test "should find post" do
    post_id = posts(:hello_world).id
    assert_nothing_raised { Post.find(post_id) }
  end
  
  test "should update post" do
    post = posts(:hello_world)
    assert post.update_attributes(:title => 'New Title')
  end
  
  test "should destroy post" do
    post = posts(:hello_world)
    post.destroy
    assert_raise(ActiveRecord::RecordNotFound) { Post.find(post.id) }
  end
  
  test "should not create and article without title nor body" do
    post = Post.new
    assert !post.valid?
    assert post.errors[:title].any?
    assert post.errors[:content].any?
    assert_equal ["can't be blank", "is too short (minimum is 3 characters)"], post.errors[:title]
    assert_equal ["can't be blank", "is too short (minimum is 10 characters)"], post.errors[:content]
    assert !post.save
  end
end
