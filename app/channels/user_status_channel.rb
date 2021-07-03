class UserStatusChannel < ApplicationCable::Channel
  def subscribed
    current_user.update(online: true)
    stream_from 'user_status_channel'
    online_users
  end

  def unsubscribed
    current_user.update(online: false)
    online_users
  end

  private

  def online_users
    ActionCable.server.broadcast 'user_status_channel', user: current_user
  end
end
