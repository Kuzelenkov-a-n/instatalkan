class RoomsController < ApplicationController
  before_action :set_room, only: %i[show destroy]
  before_action :set_users, only: %i[index show destroy]

  def index
    @rooms = Room.all
    @room = Room.new
  end

  def show
  end

  def create
    @room = Room.create!(user_id: current_user.id)

    redirect_to room_path(@room.token), notice: 'Комната успешно создана!'
  end

  def destroy
    if @room.user_id == current_user.id
      @room.destroy

      redirect_to root_path, notice: 'Вы успешно удалили комнату.'
    else
      redirect_to root_path, notice: 'Это не Ваша комната!'
    end
  end

  private

  def set_room
    @room = Room.find_by(token: params[:token])
  end

  def set_users
    @users = User.online
  end
end
