require 'test_helper'

class OrisMailerTest < ActionMailer::TestCase
  test "contact_message_request" do
    mail = OrisMailer.contact_message_request
    assert_equal "Contact message request", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

  test "subscription_request" do
    mail = OrisMailer.subscription_request
    assert_equal "Subscription request", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

  test "order_service_request" do
    mail = OrisMailer.order_service_request
    assert_equal "Order service request", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

  test "vacancy_request" do
    mail = OrisMailer.vacancy_request
    assert_equal "Vacancy request", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
