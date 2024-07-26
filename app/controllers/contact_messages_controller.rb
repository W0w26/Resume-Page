class ContactMessagesController < ApplicationController
  def new
    @contact_message = ContactMessage.new
    @contact_messages = ContactMessage.all
  end

  def show
    @contact_message = ContactMessage.find(params[:params])
  end

  def create
    @contact_message = ContactMessage.new(contact_message_params)

    if @contact_message.save
      UserMailer.success_email(@contact_message).deliver_now
      ApplicationMailer.send_email(@contact_message).deliver_now
      sleep 1.5
      flash[:notice] = 'Message sent successfully!'
      redirect_to contact_messages_new_path
    else
      flash[:alert] = "Message is not delivered!"
      redirect_to contact_messages_new_path
    end
  end

  private

  def contact_message_params
    params.require(:contact_message).permit(:name, :email, :subject, :body)
  end
end