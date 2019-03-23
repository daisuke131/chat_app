class RoomChannel < ApplicationCable::Channel
  def subscribed
    stream_from "room_channel_#{params['room_id']}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    message = Message.create!(content: data['message'],room_id: params['room_id'], user_id: params['user_id'])
    # message_temp = ApplicationController.renderer.render(partial: 'messages/message', locals: {message: message})
    # ActionCable.server.broadcast 'room_channel', {message_temp: message_temp, room_id: data['room_id']}
    # ActionCable.server.broadcast 'room_channel', {message: @message_temp}


    # Message.create!(content: data['message'],room_id: 1, user_id: 1)
    # # ActionCable.server.broadcast('room_channel', message: data['message'])
    ActionCable.server.broadcast "room_channel_#{params['room_id']}", message: render_message(message)
  end

  private

    def render_message(message)
        if params['user_id'] == message.user_id
            ApplicationController.renderer.render(partial: 'messages/me-message', locals: {message: message})
        else
            ApplicationController.renderer.render(partial: 'messages/you-message', locals: {message: message})
        end
    end
end
