jQuery(document).on "turbolinks:load", ->
  App.user_status = App.cable.subscriptions.create "UserStatusChannel",

    received: (data) ->
      { id, online, nickname } = data.user

      user_tag = $("#users-list").find("#user_#{id}")

      if (!online)
        user_tag.remove()

      if (online && user_tag.length != 1)
        $("#users-list").append(
          """
          <li id="user_#{id}">
            ● #{nickname}
          </li>
          """
        )
