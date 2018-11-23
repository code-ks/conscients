import flatpickr from "flatpickr";
import "flatpickr/dist/themes/light.css";
import "flatpickr/dist/l10n/fr.js";

function launchFlatpickr(id) {
  flatpickr(id, {
    dateFormat: "d-m-Y",
    locale,
    allowInput: true,
    defaultDate: "today",
    minDate: new Date(new Date().getFullYear(), 0, 1)
  });
}

document.addEventListener("turbolinks:load", () => {
  launchFlatpickr("#datepicker");
});

window.launchFlatpickr = launchFlatpickr;
