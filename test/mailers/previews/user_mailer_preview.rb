# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview
  def new_message
    message = ContactMessage.last
    UserMailer.success_email(message)
  end
end
