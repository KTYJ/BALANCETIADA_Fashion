const modal = document.getElementById('editModal');
  const modalImg = document.getElementById('modal-img');
  const modalTitle = document.getElementById('modal-title');
  const modalType = document.getElementById('modal-type');
  const modalPrice = document.getElementById('modal-price');
  const modalSize = document.getElementById('modal-size');
  const modalQuantity = document.getElementById('modal-quantity');

  document.querySelectorAll('.edit-button').forEach((btn, index) => {
    btn.addEventListener('click', () => {
      const item = btn.closest('.main');
      modalImg.src = item.querySelector('img').src;
      modalTitle.innerText = item.querySelectorAll('.row')[1].innerText;
      modalType.innerText = item.querySelectorAll('.row')[0].innerText;
      modalPrice.innerText = item.querySelectorAll('.col')[3].innerText;
      modalSize.value = item.querySelector('.clothing-size').innerText;
      modalQuantity.value = item.querySelectorAll('.border')[0].innerText;

      modal.style.display = 'flex';
    });
  });

  function openModal() {
    document.getElementById("editModal").style.display = "flex";
  }
  
  function closeModal() {
    modal.style.display = 'none';
  }

  function saveChanges() {
    // Implement logic to apply changes to the item
    alert("Changes saved!");
    closeModal();
  }

  // Optional: close modal on background click
window.onclick = function(event) {
    const modal = document.getElementById("editModal");
    if (event.target === modal) {
      closeModal();
    }
  }


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