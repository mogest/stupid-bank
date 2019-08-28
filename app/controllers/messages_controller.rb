class MessagesController < ApplicationController
  before_action :ensure_logged_in
  before_action :ensure_admin_access, except: [:new, :create]
  layout 'user'

  def index
    @messages = Message.order(:created_at => :desc)
  end

  def show
    @message = Message.find(params[:id])
  end

  def new
    @message = Message.new
  end

  def create
    @message = current_user.messages.new(params.require(:message).permit(:subject, :body))
    if @message.save
      redirect_to accounts_path, notice: 'Your message has been sent.  It will be reviewed within the next 48 business days.'
    else
      render 'new'
    end
  end

  private

  def ensure_admin_access
    if !is_admin_user?
      redirect_to accounts_path, alert: 'No access to this page.'
    end
  end
end
