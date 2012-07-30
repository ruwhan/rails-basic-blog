require 'test_helper'

class NotifierTest < ActionMailer::TestCase
  test "send_notification" do  
    mail = Notifier.send_notification('ruwhan@windowslive.com')
    # assert !ActionMailer::Base.deliveries.empty?
    assert_equal "Welcome to blog learning", mail.subject
    assert_equal ["ruwhan@windowslive.com"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hello, thanks for register at blog learning.", mail.body.encoded
  end

end
