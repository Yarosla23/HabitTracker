document.addEventListener("DOMContentLoaded", () => {
  const sliders = document.querySelectorAll(".slider-wrapper");

  sliders.forEach((slider) => {
    const container = slider.querySelector(".slider-container");
    const leftButton = slider.querySelector(".slider-button.left-0");
    const rightButton = slider.querySelector(".slider-button.right-0");

    const scrollAmount = 300; // Дистанция прокрутки

    leftButton.addEventListener("click", () => {
      container.scrollBy({ left: -scrollAmount, behavior: "smooth" });
    });

    rightButton.addEventListener("click", () => {
      container.scrollBy({ left: scrollAmount, behavior: "smooth" });
    });
  });
});
