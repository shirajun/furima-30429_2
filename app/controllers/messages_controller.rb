class MessagesController < ApplicationController
  # def new
  #   # @item = Item.find(params[:item_id])
  #   @messages = Message.all
  #   @message = Message.new
  # end

  def create
    # @item = Item.find(params[:item_id])
    @message = Message.new(message_params)
    if @message.save
      ActionCable.server.broadcast 'message_channel', content: @message
    end
  end

  private
  
  def message_params
    params.require(:message).permit(
      :text
    ).merge(
      user_id: current_user.id,
      item_id: params[:item_id]
    )
  end
end
