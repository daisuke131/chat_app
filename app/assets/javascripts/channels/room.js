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
        // $("#messages").append(data["message"]);
        if ($("#messages").data("user_id") == data["user_id"]) {
            $("#messages").append(data["me_message"]);
        } else {
            $("#messages").append(data["you_message"]);
        }
        $('html,body').animate({scrollTop: $('body').height()});
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
