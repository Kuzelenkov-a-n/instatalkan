class RoomChannel < ApplicationCable::Channel
  attr_reader :room, :room_service

  def subscribed
    @room = Room.find(params[:roomId])

    stream_from "room_channel_#{room.id}"

    @room_service = RoomService.new("#{room.id}", current_user)

    return unless room_service.current_room_id_count == 1

    logger.info "Subscribed to RoomChannel, roomId: #{params[:roomId]}"

    speak("message" => "* * * joined the room * * *")
  end

  def unsubscribed
    return if room_service.users_connections.include?("#{room.id}")

    logger.info "Unsubscribed to RoomChannel"

    speak("message" => "* * * left the room * * *")
  end

  def speak(data)
    logger.info "RoomChannel, speak: #{data.inspect}"

    MessageService.new(
      body: data["message"], room: room, user: current_user
    ).perform
  end
end
