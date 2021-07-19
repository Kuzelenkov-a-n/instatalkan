jQuery(document).on "turbolinks:load", ->
  messages = $("#messages")

  if messages.length > 0
    createRoomChannel messages.data("room-id")

  $(document).on "keypress", "#message_body", (event) ->
    message = event.target.value
    if event.keyCode is 13
      event.preventDefault()

      if message != ""
       App.room.speak(message)
       event.target.value = ""

createRoomChannel = (roomId) ->
  App.room = App.cable.subscriptions.create {channel: "RoomChannel", roomId: roomId},

    received: (data) ->
      $("#messages").append data["message"]
      $("#messages, #message").last()[0].scrollIntoView()

    speak: (message) ->
      @perform "speak", message: message
