require 'test_helper'

class PlannieNotifierTest < ActionMailer::TestCase
  test "last_sign_in" do
    mail = PlannieNotifier.last_sign_in
    assert_equal "Last sign in", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
