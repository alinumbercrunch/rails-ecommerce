import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="cart"
export default class extends Controller {
  initialize() {
    const cart = JSON.parse(localStorage.getItem("cart"));
    if (!cart) {
      return;
    }
    let total = 0;
    for (let i = 0; i < cart.length; i++) {
      const item = cart[i];
      total += item.price * item.quantity;
      const div = document.createElement("div");
      div.classList.add(
        "flex",
        "justify-between",
        "items-center",
        "p-4",
        "mb-2",
        "bg-white",
        "rounded-lg",
        "shadow-md"
      );
      div.innerHTML = `
        <div>
          <h4 class="text-lg font-semibold">${item.name}</h4>
          <p class="text-sm text-gray-600">Size/Other details: ${item.size}</p>
          <p class="text-sm text-gray-600">Price: ¥${item.price}</p>
          <p class="text-sm text-gray-600">Quantity: ${item.quantity}</p>
        </div>
        <button value="${item.id}" class="bg-red-500 hover:bg-red-600 text-white font-bold py-1 px-3 rounded remove-button">Remove</button>
      `;
      this.element.prepend(div);
    }

    const totalEl = document.createElement("div");
    totalEl.innerHTML = `<p class="text-xl font-semibold">Total: ¥${total}</p>`;
    const totalContainer = document.getElementById("total");
    totalContainer.appendChild(totalEl);

    // Bind the removeFromCart method to the remove buttons
    document.querySelectorAll(".remove-button").forEach((button) => {
      button.addEventListener("click", this.removeFromCart.bind(this));
    });
  }

  clear() {
    localStorage.removeItem("cart");
    window.location.reload();
  }

  removeFromCart(event) {
    console.log("Removing item from cart...");
    const cart = JSON.parse(localStorage.getItem("cart"));
    const id = event.target.value;
    const index = cart.findIndex((item) => item.id === id);
    cart.splice(index, 1);
    localStorage.setItem("cart", JSON.stringify(cart));
    window.location.reload();
  }

  checkout() {
    console.log("checkout");
    const cart = JSON.parse(localStorage.getItem("cart"));
    const csrfToken = document.querySelector("[name='csrf-token']").content;

    const payload = {
      authenticity_token: csrfToken,
      cart: cart,
    };

    fetch("/checkout", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": csrfToken,
      },
      body: JSON.stringify(payload),
    })
      .then((response) => {
        if (response.ok) {
          response.json().then((body) => {
            window.location.href = body.url;
          });
        } else {
          response.json().then((body) => {
            const errorEl = document.createElement("div");
            errorEl.innerText = `There was an error while processing your order. ${body.error}`;
            let errorContainer = document.getElementById("errorContainer");
            errorContainer.appendChild(errorEl);
          });
        }
      })
      .catch((error) => {
        console.error("Error during fetch:", error);
        const errorEl = document.createElement("div");
        errorEl.innerText = `There was an error while processing your order. Please try again later.`;
        let errorContainer = document.getElementById("errorContainer");
        errorContainer.appendChild(errorEl);
      });
  }
}
