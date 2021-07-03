class RoomsController < ApplicationController
  before_action :set_room, only: %i[show destroy]
  before_action :set_users, only: %i[index show]

  def index
    @rooms = Room.all
    @room = Room.new
  end

  def show
  end

  def create
    @room = Room.create!(user_id: current_user.id)

    redirect_to room_path(@room.token), notice: 'Room was successfully created.'
  end

  def destroy
    if @room.user_id == current_user.id
      @room.destroy

      redirect_to root_path, notice: 'Room was successfully deleted.'
    else
      redirect_to root_path, notice: 'It is not your room!'
    end
  end

  private

  def set_room
    @room = Room.find_by(params[:id])
  end

  def set_users
    @users = User.online.map(&:nickname)
  end
end
