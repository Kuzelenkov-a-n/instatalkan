class UserStatusChannel < ApplicationCable::Channel
  def subscribed
    stream_from "user_status_channel"

    UserStatusService.make_online(current_user)
  end

  def unsubscribed
    UserStatusService.make_offline(current_user)
  end
end
