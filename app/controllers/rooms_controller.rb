# frozen_string_literal: true

class RoomsController < ApplicationController
  before_action :authenticate_user!

  def index
    @rooms = Room.all.order(created_at: :desc)
    @room = Room.new
  end

  def show
    @room = Room.find(params[:id])
    @messages = @room.messages
  end

  def create
    @room = Room.create!(room_params)
    redirect_to root_path
  end

  def destroy
    @room = Room.find(params[:id])
    @room.destroy
    redirect_to root_path
  end

  private

  def room_params
    params.require(:room).permit(:room_name).merge(user_id: current_user.id)
  end
end
