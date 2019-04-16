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
  if(document.getElementById("datepicker")){
    const dataDate = document
      .getElementById("datepicker")
      .getAttribute("data-current-date");
    const displayedDate = dataDate == "" ? "today" : new Date(dataDate);
    launchFlatpickr("#datepicker", displayedDate);
  }
});

window.launchFlatpickr = launchFlatpickr;
