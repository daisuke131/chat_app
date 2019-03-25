# frozen_string_literal: true

class RoomsController < ApplicationController
  before_action :authenticate_user!

  PER = 8

  def index
    @rooms = Room.order(created_at: :desc).page(params[:page]).per(PER)
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
