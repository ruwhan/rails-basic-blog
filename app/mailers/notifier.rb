class Notifier < ActionMailer::Base
  default from: "from@example.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notifier.send_notification.subject
  #
  def send_notification(receiver_email_address)
    @greeting = "Hello, thanks for register at blog learning."

    mail :to => receiver_email_address, :subject => 'Welcome to blog learning'
  end
end
