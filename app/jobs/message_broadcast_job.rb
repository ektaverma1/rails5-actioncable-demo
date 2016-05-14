class MessageBroadcastJob < ApplicationJob
  queue_as :default

  def perform(data)
    message = Message.create! content: data
    ActionCable.server.broadcast 'room_channel', message: render_message(message)
  end

  private

  def render_message(message)
    ApplicationController.renderer.render(partial: 'messages/message', locals: { message: message })
  end
end
