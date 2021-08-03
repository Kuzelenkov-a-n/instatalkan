class RoomChannel < ApplicationCable::Channel
  def subscribed
    @room = Room.find(params[:roomId])

    stream_from "room_channel_#{@room.id}"

    return unless users_connections.count == 1

    logger.info "Subscribed to RoomChannel, roomId: #{params[:roomId]}"

    speak("message" => "* * * joined the room * * *")
  end

  def unsubscribed
    return if users_connections.include?("#{@room.id}")

    logger.info "Unsubscribed to RoomChannel"

    speak("message" => "* * * left the room * * *")
  end

  def speak(data)
    logger.info "RoomChannel, speak: #{data.inspect}"

    MessageService.new(
      body: data["message"], room: @room, user: current_user
    ).perform
  end

  def users_connections
    ActionCable.server.connections.filter_map do |c|
      c.subscriptions.identifiers.to_s.match(/#{@room.id}/).to_s if c.current_user == current_user
    end
  end
end
