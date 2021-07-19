module UserStatusService
  def self.make_online(current_user)
    current_user.update(online: true)

    ActionCable.server.broadcast "user_status_channel", user: current_user
  end

  def self.make_offline(current_user)
    connection = ActionCable.server
                            .connections
                            .count { |c| c.current_user == current_user }

    return unless connection.zero?

    current_user.update(online: false)

    ActionCable.server.broadcast "user_status_channel", user: current_user
  end
end
