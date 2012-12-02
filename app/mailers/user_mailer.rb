class UserMailer < ActionMailer::Base
  default from: "from@example.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.signup.subject
  #
  def signup(email,password)
    @password = password
    @email = email
    mail to: email, subject: "Signup Confirmation"
  end
end
