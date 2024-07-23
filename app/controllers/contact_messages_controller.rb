class ContactMessagesController < ApplicationController
  def new
    @contact_message = ContactMessage.new
  end

  def create
    Rails.logger.debug("Raw parameters: #{params.inspect}")
    @contact_message = ContactMessage.new(contact_message_params)
    Rails.logger.debug("ContactMessage attributes: #{@contact_message.attributes.inspect}")

    if @contact_message.save
      UserMailer.success_email(@contact_message).deliver
      Rails.logger.info("Sent email to: #{@contact_message.email}")
      sleep 1.5
      flash[:notice] = 'Message sent successfully!'
      redirect_to contact_messages_new_path
    else
      flash[:notice] = "Message is not delivered!"
      redirect_to contact_messages_new_path
    end
  end

  private

  def contact_message_params
    params.require(:contact_message).permit(:name, :email, :subject, :body)
  end
end