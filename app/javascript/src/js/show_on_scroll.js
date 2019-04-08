// Display logo differently on scroll
$(document).on("turbolinks:load", () => {
  $(window).scroll(() => {
    if ($(document).scrollTop() > 100) {
      $(".show-on-scroll").removeClass("d-md-none");
    } else {
      $(".show-on-scroll").addClass("d-md-none");
    }
  });
});
