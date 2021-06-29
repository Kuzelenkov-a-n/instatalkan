class RoomsController < ApplicationController
  before_action :set_room, only: [:show]
  before_action :set_users, only: %i[index show]

  def index
    @rooms = Room.all
    @room = Room.new
  end

  def show
  end

  def create
    @room = Room.create!

    redirect_to @room, notice: 'Room was successfully created.'
  end

  private

  def set_room
    @room = Room.find_by(token: params[:token])
  end

  def set_users
    @users = User.where(online: true)
  end
end
