# frozen_string_literal: true

class RoomChannel < ApplicationCable::Channel
  def subscribed
    stream_from "room_channel_#{params["room_id"]}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    message = Message.create!(content: data["message"], room_id: params["room_id"], user_id: params["user_id"])
    ActionCable.server.broadcast "room_channel_#{params["room_id"]}", me_message: render_me_message(message), you_message: render_you_message(message), user_id: message.user_id
  end

  private

    def render_me_message(message)
      ApplicationController.renderer.render(partial: "messages/me-message", locals: { message: message })
    end

    def render_you_message(message)
      ApplicationController.renderer.render(partial: "messages/you-message", locals: { message: message })
    end
end
