class UserMailer < ApplicationMailer
  default from: ENV['GMAIL_USERNAME']

  def success_email(contact_message)
    @contact_message = contact_message

    mail(:to => contact_message.email, :subject => contact_message.subject, :body => "Thank you for your email.") if contact_message.any?
  end

end
