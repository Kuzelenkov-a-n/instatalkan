class RoomChannel < ApplicationCable::Channel
  def subscribed
    @room = Room.find(params[:roomId])

    stream_from "room_channel_#{@room.id}"

    return unless UserStatusService.connection_count(current_user) == 1

    logger.info "Subscribed to RoomChannel, roomId: #{params[:roomId]}"

    speak("message" => "* * * joined the room * * *")
  end

  def unsubscribed
    return unless UserStatusService.connection_count(current_user).zero?

    logger.info "Unsubscribed to RoomChannel"

    speak("message" => "* * * left the room * * *")
  end

  def speak(data)
    logger.info "RoomChannel, speak: #{data.inspect}"

    MessageService.new(
      body: data["message"], room: @room, user: current_user
    ).perform
  end
end
