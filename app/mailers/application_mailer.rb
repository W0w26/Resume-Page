class ApplicationMailer < ActionMailer::Base
  default from: ENV['GMAIL_USERNAME']
  layout "mailer"
  def send_email(contact_message)
    @contact_message = contact_message

    mail(:to => contact_message.email, :subject => contact_message.subject, :body => contact_message.body)
  end
end
