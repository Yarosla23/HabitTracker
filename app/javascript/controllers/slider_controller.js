import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ["slider"];

  connect() {
    console.log("Slider controller connected");
  }

  scrollLeft() {
    this.sliderTarget.scrollBy({ left: -200, behavior: 'smooth' });
  }

  scrollRight() {
    this.sliderTarget.scrollBy({ left: 200, behavior: 'smooth' });
  }
}
