module UserStatusService
  class << self
    attr_reader :current_user

    def make_online(current_user)
      @current_user = current_user

      broadcast if current_user.update(online: true)
    end

    def make_offline(current_user)
      @current_user = current_user

      return unless connections_count.zero?

      broadcast if current_user.update(online: false)
    end

    private

    def connections_count
      ActionCable.server.connections.count { |c| c.current_user == current_user }
    end

    def broadcast
      ActionCable.server.broadcast "user_status_channel", user: current_user
    end
  end
end
