module RoomConnectionsChecker
  class << self
    attr_reader :room_id, :current_user

    def connected?(room_id, current_user, channel_action)
      @room_id = room_id.to_s
      @current_user = current_user

      case channel_action
      when :subscribed then current_room_id_count == 1
      when :unsubscribed then users_connections.include?(@room_id)
      end
    end

    private

    def current_room_id_count
      users_connections.select { |id| id == room_id }.count
    end

    def users_connections
      ActionCable.server.connections.filter_map do |c|
        c.subscriptions.identifiers.to_s.match(/#{room_id}/).to_s if c.current_user == current_user
      end
    end
  end
end