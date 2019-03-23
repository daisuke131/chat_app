$(document).on("turbolinks:request-start", function() {
  App.room.unsubscribe();
});
$(document).on("turbolinks:load", function() {
  App.room = App.cable.subscriptions.create(
    {
      channel: "RoomChannel",
      user_id: $("#messages").data("user_id"),
      room_id: $("#messages").data("room_id")
    },
    {
      received: function(data) {
        // Called when there's incoming data on the websocket for this channel
        // debugger
        $("#messages").append(data["message"]);
        // $(body).animate({scrollTop: $(body)[0].scrollHeight}, 'fast');
        // $("body")
        //   .delay(100)
        //   .animate({ scrollTop: $(document).height() }, 1500);
      },

      speak: function(message) {
        return this.perform("speak", { message: message });
      }
    },

    //   $(function() {
    //     $(document).on('keypress', function(e) {
    //         if (e.keyCode === 13) {
    //             App.room.speak($("#txt-chat").val());
    //             $("#txt-chat").val() = '';
    //             e.preventDefault();
    //         }
    //     })
    //   })

    $(function() {
      $("#message-btn").click(function(e) {
        App.room.speak($("#txt-chat").val());
        $("#txt-chat").val("");
        // e.preventDefault();
      });
    })
  );
});
