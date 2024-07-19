class ContactMessagesController < ApplicationController
  def new
    @contact_message = ContactMessage.new
  end

  def create
    @contact_message = ContactMessage.new
    if @contact_message.save
      sleep 1
      flash[:notice] = 'Message sent successfully!'
      redirect_to hello_emailSend_path
    else
      render 'new'
    end
  end
end
