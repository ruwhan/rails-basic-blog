require 'test_helper'
require 'digest'

class NotifierTest < ActionMailer::TestCase
  test "send_notification" do  
    token = Digest::SHA1.hexdigest("ruwhan@windowslive.com")
    mail = Notifier.send_notification("ruwhan@windowslive.com", "http://localhost:3000/verify/", token)
    # assert !ActionMailer::Base.deliveries.empty?
    assert_equal "Welcome to blog learning", mail.subject
    assert_equal ["ruwhan@windowslive.com"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hello, thanks for register at blog learning. To verify you account please click the following link: http://localhost:3000/verify/88944a4a146d1e0573a990bb499d9ac5df5b9390", mail.body.encoded
  end

end
