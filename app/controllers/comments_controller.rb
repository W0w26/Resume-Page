class CommentsController < ApplicationController

  def create
    Rails.logger.info("Params: #{params.inspect}")
    @contact_message = ContactMessage.find(params[:contact_message_id])
    @comment = @contact_message.comment.build(comment_params)

    if @comment.save
      flash[:notice] = "Comment created successfully."
    else
      flash[:alert] = "Comment could not be created."
    end

    redirect_to contact_messages_new_path(@contact_message)
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
