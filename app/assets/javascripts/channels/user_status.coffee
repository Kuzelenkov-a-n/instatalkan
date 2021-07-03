jQuery(document).on 'turbolinks:load', ->
  App.user_status = App.cable.subscriptions.create 'UserStatusChannel',

    received: (data) ->
      $('#users-list').text(data['user'].nickname)
