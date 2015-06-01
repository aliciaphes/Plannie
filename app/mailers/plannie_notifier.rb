class PlannieNotifier < ActionMailer::Base
  default from: "from@example.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.plannie_notifier.last_sign_in.subject
  #
  def last_sign_in
    @greeting = "Hi"

    #mail to: "to@example.org"
    mail to: current_user.email, subject: 'Last sign in information'
  end
end
