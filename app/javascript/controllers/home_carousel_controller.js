import { Controller } from "stimulus";

export default class extends Controller {
  static targets = [
    "Tab0",
    "Tab1",
    "Tab2",
    "Carousel0",
    "Carousel1",
    "Carousel2"
  ];

  display0() {
    this.Tab0Target.classList.add("active");
    this.Tab1Target.classList.remove("active");
    this.Tab2Target.classList.remove("active");
    this.Carousel0Target.classList.remove("d-none");
    this.Carousel1Target.classList.add("d-none");
    this.Carousel2Target.classList.add("d-none");
  }

  display1() {
    this.Tab0Target.classList.remove("active");
    this.Tab1Target.classList.add("active");
    this.Tab2Target.classList.remove("active");
    this.Carousel0Target.classList.add("d-none");
    this.Carousel1Target.classList.remove("d-none");
    this.Carousel2Target.classList.add("d-none");
  }

  display2() {
    this.Tab0Target.classList.remove("active");
    this.Tab1Target.classList.remove("active");
    this.Tab2Target.classList.add("active");
    this.Carousel0Target.classList.add("d-none");
    this.Carousel1Target.classList.add("d-none");
    this.Carousel2Target.classList.remove("d-none");
  }
}
