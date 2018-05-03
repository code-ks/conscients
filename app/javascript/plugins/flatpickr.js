import flatpickr from "flatpickr";
import "flatpickr/dist/themes/light.css";
import "flatpickr/dist/l10n/fr.js";

function launchFlatpickr(id) {
  flatpickr(id, {
    dateFormat: "d-m-Y",
    locale
  });
}

document.addEventListener("turbolinks:load", () => {
  launchFlatpickr("#datepicker");
});

window.launchFlatpickr = launchFlatpickr;
