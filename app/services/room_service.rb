class RoomService
  attr_reader :room_id, :current_user

  def initialize(room_id, current_user)
    @room_id = room_id
    @current_user = current_user
  end

  def current_room_id_count
    users_connections.select { |id| id == "#{room_id}" }.count
  end

  def users_connections
    ActionCable.server.connections.filter_map do |c|
      c.subscriptions.identifiers.to_s.match(/#{room_id}/).to_s if c.current_user == current_user
    end
  end
end
