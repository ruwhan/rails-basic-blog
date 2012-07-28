require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  
  test "create comment" do
    post = comments(:some_comment).post
    comment = post.comments.new
    comment.name = "visitor"
    comment.comment = "testin testing, only testing"
    
    assert comment.save
  end
  
  test "find comment" do
    comment = comments(:some_comment)
    assert_nothing_raised { Comment.find(comment.id) }
  end
  
  test "update comment" do
    comment = comments(:some_comment)
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
    assert_equal nil, comment.post
    assert !comment.save
  end
end
