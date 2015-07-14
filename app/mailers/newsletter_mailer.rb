class NewsletterMailer < ApplicationMailer
  # default :css => :email, :from => 'nazariy.papizh@gmail.com'

  include Roadie::Rails::Automatic
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.newsletter_mailer.welcome.subject
  #
  def welcome(email)
    @greeting = "Hi"

    mail to: email, subject: "Email template"
  end
end
