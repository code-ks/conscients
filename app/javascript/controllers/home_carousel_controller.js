import { Controller } from "stimulus";

export default class extends Controller {
  static targets = [
    "firstTab",
    "secondTab",
    "thirdTab",
    "firstCarousel",
    "secondCarousel",
    "thirdCarousel"
  ];

  displayFirst() {
    this.firstTabTarget.classList.add("active");
    this.secondTabTarget.classList.remove("active");
    this.thirdTabTarget.classList.remove("active");
    this.firstCarouselTarget.classList.remove("d-none");
    this.secondCarouselTarget.classList.add("d-none");
    this.thirdCarouselTarget.classList.add("d-none");
  }

  displaySecond() {
    this.firstTabTarget.classList.remove("active");
    this.secondTabTarget.classList.add("active");
    this.thirdTabTarget.classList.remove("active");
    this.firstCarouselTarget.classList.add("d-none");
    this.secondCarouselTarget.classList.remove("d-none");
    this.thirdCarouselTarget.classList.add("d-none");
  }

  displayThird() {
    this.firstTabTarget.classList.remove("active");
    this.secondTabTarget.classList.remove("active");
    this.thirdTabTarget.classList.add("active");
    this.firstCarouselTarget.classList.add("d-none");
    this.secondCarouselTarget.classList.add("d-none");
    this.thirdCarouselTarget.classList.remove("d-none");
  }
}
