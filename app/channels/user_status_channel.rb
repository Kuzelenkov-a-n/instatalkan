class UserStatusChannel < ApplicationCable::Channel
  def subscribed
    current_user.update(online: true)
    stream_from 'user_status_channel'
    online_users
  end

  def unsubscribed
    current_user.update(online: false)
  end

  private

  def online_users
    ActionCable.server.broadcast 'user_status_channel', users: render_users_list
  end

  def render_users_list
    ApplicationController.renderer.render(partial: 'users/user',
                                          locals: { users: User.where(online: true) })
  end
end
