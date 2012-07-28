require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  
  test "create comment" do
    post = posts(:hello_world)
    comment = post.comments.new
    comment.name = "visitor"
    comment.comment = "testin testing, only testing"
    
    assert comment.save
  end
  
  test "find comment" do
    comment = posts(:hello_world).comments.first
    comment_id = comment.id
    assert_nothing_raised { Comment.find(comment_id) }
  end
  
  test "update comment" do
    comment = posts(:hello_world).comments.first
    assert comment.update_attributes(:comment => 'comment updated!')
  end
  
  test "destroy comment" do
    comment = comments(:some_comment)
    comment.destroy
    assert_raise(ActiveRecord::RecordNotFound) { Comment.find(comment.id) }
  end
  
  test "comment validation" do
    comment = Comment.new
    assert !comment.valid?
    assert comment.errors[:name].any?
    assert comment.errors[:comment].any?
    assert_equal ["can't be blank"], comment.errors[:name]
    assert_equal ["can't be blank", "is too short (minimum is 3 characters)"], comment.errors[:comment]
    assert !comment.save
  end
end
