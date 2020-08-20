import Rails from "@rails/ujs";
let check_status = window.setInterval(function() {
  Rails.ajax({
    type: "GET",
    url: "/mfa/check",
    success: function(r) {
      if (r !== "sent") {
        Rails.ajax({
          type: "PATCH",
          url: "/mfa/finalize",
          success: function() {
            window.clearInterval(check_status);
            window.location.href = "/";
          },
          error: function() {
            console.log("Promoting PushAuth status failed.");
          }
        });
      }
    },
    error: function() {
      console.log("Checking for PushAuth status failed.");
    }
  });
}, 2000);
