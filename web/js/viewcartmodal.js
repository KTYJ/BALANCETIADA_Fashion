const modal = document.getElementById('editModal');
const modalImg = document.getElementById('modal-img');
const modalTitle = document.getElementById('modal-title');
const modalPrice = document.getElementById('modal-price');
const modalSize = document.getElementById('modal-size');
const modalQuantity = document.getElementById('modal-quantity');

document.querySelectorAll('.edit-button').forEach(btn => {
    btn.addEventListener('click', () => {
        const item = btn.closest('.main');
        const uid = item.querySelector('input[type="checkbox"]').value;
        const img = item.getAttribute('data-img');
        const name = item.getAttribute('data-name');
        const size = item.getAttribute('data-size');
        const qty = item.getAttribute('data-qty');
        const price = item.getAttribute('data-price');

        document.getElementById('modal-uid').value = uid;
        document.getElementById('modal-img').src = img;
        document.getElementById('modal-title').innerText = name;
        document.getElementById('modal-price').innerText = "RM " + parseFloat(price).toFixed(2);
        document.getElementById('modal-size').value = size;
        document.getElementById('modal-quantity').value = qty;

        modal.style.display = 'flex';
    });
});

function closeModal() {
    modal.style.display = 'none';
}

// Optional: Close modal on outside click
window.onclick = function (event) {
    if (event.target === modal) {
        closeModal();
    }
};


const paymentSelect = document.querySelector("select");
const visaFieldsContainer = document.getElementById("visa-fields");

paymentSelect.addEventListener("change", function () {
    const selected = this.value;

    if (selected === "Visa") {
        visaFieldsContainer.innerHTML = `
              <p style="color: black; margin-top: -20px; padding-left: 0;">Card Number</p>
              <input type="text" class="form-control mb-2" placeholder="Card Number">

              <div class="row" style="margin-top: 20px;">
                  <div class="col" style="margin-right: 10px; padding-left: 0;">
                      <p style="color: black;">Expires Date</p>
                      <input type="text" class="form-control" placeholder="MM/YY">
                  </div>
                  <div class="col">
                      <p style="color: black; padding-left: 0;">CVC</p>
                      <input type="text" class="form-control" placeholder="CVC">
                  </div>
              </div>
              
              <div style="margin-bottom: 5px;"></div>
          `;
    } else {
        visaFieldsContainer.innerHTML = ""; // Clear fields if not Visa
    }
});

const addressTextarea = document.getElementById('address');

addressTextarea.addEventListener('input', function () {
    this.style.height = 'auto'; // Reset height
    this.style.height = (this.scrollHeight) + 'px'; // Set new height
});

const shippingSelect = document.getElementById("shippingMethodSelect");
shippingSelect.addEventListener("change", function () {
    updateSummary();
});
