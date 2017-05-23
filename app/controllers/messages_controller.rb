class MessagesController < ApplicationController
  before_action :require_login

  def require_login
    redirect_to '/users/login' unless session[:user_id]
  end
  def index
    @inbox = Message.where('recipient_id = ?', session[:user_id]) 
    @outbox = Message.where('sender_id = ?', session[:user_id]) 
    @users = User.where.not(id: session[:user_id])
  end

  def new
    @message = Message.new(content: message_params[:content], sender_id: message_params[:sender], recipient_id: message_params[:recipient])
    if @message.save
 
      redirect_to '/'
    else
      flash[:errors] = @message.errors.full_messages
      redirect_to :back
    end

  end

private
  def message_params
    params.require(:message).permit(:content,:recipient,:sender)
  end
end
