// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require tether
//= require bootstrap
//= require turbolinks
//= require_tree .

$(document).on('turbolinks:load', function() {
  $(".alert").fadeIn(0).delay(5000).fadeOut(500);
  $(".js-update-room-activity").click(function (e) {
    $.ajax({
      method: "PATCH",
      url: "/room_activities/" + $(this).data("id"),
      data: { room_activity: { enabled: this.checked } }
    })
      .done(function( msg ) {
        console.log( msg );
        alert( "Updated");
      })
      .fail(function( msg ) {
        console.log( msg );
      });
  });
});

navigator.serviceWorker && navigator.serviceWorker.register('/service_worker.js')
