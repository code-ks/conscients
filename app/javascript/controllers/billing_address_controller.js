import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ["hideable", "checkable"];

  toggleDisplay() {
    const addressForm = this.hideableTarget;
    const checkBox = this.checkableTarget;
    if (checkBox.checked) {
      addressForm.classList.add("d-none");
    } else {
      addressForm.classList.remove("d-none");
    }
  }
}
