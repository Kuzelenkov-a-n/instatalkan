module UserStatusService
  def self.make_online(current_user)
    current_user.update(online: true)

    send_to_channel(current_user)
  end

  def self.make_offline(current_user)
    return unless connection_count(current_user).zero?

    current_user.update(online: false)

    send_to_channel(current_user)
  end

  def self.connection_count(current_user)
    ActionCable.server
               .connections
               .count { |c| c.current_user == current_user }
  end

  def self.send_to_channel(current_user)
    ActionCable.server.broadcast "user_status_channel", user: current_user
  end
end
