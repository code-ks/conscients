import { Controller } from "stimulus";

// Hide or show the billing address (if different from the delivery address)
export default class extends Controller {
  static targets = ["hideable", "checkable", "requireable"];

  toggleDisplay() {
    const addressForm = this.hideableTarget;
    const checkBox = this.checkableTarget;
    const fieldsToRequire = this.requireableTargets;
    if (checkBox.checked) {
      addressForm.classList.add("d-none");
      fieldsToRequire.forEach(field => {
        field.removeAttribute("required");
      });
    } else {
      addressForm.classList.remove("d-none");
      fieldsToRequire.forEach(field => {
        field.setAttribute("required", "");
      });
    }
  }
}
