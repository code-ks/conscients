import "bootstrap/dist/js/bootstrap";

$("#carouselIndicators").carousel({
  pause: true,
  interval: false
});

function launchModal(id) {
  $(id).modal("show", "focus");
}

window.launchModal = launchModal;
