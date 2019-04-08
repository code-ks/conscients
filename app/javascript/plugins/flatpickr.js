import flatpickr from "flatpickr";
import "flatpickr/dist/themes/light.css";
import "flatpickr/dist/l10n/fr.js";

function launchFlatpickr(id, displayedDate) {
  flatpickr(id, {
    dateFormat: "d-m-Y",
    locale,
    allowInput: true,
    defaultDate: displayedDate,
    minDate: new Date(new Date().getFullYear(), 0, 1)
  });
}

document.addEventListener("turbolinks:load", () => {
  const dataDate = document
    .getElementById("datepicker")
    .getAttribute("data-current-date");
  // Allow the displayed date to be today or the selected date when the datepicker opens depending on the value of the field (for example when the user come back to modify a line item)
  const displayedDate = dataDate == "" ? "today" : new Date(dataDate);
  launchFlatpickr("#datepicker", displayedDate);
});

window.launchFlatpickr = launchFlatpickr;
