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

  def data_template(emailTemplate, email)
    et = 'email_confirmation'
    if emailTemplate == '1'
      et = 'email_confirmation'
    elsif emailTemplate == '2'
      et = 'welcome_to_ud'
    end

    mail(:template_path => 'newsletter_mailer', :template_name => et, layout: false, :subject => "tests emails", to: email)

  end
end
