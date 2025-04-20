const modal = document.getElementById('editModal');
const modalImg = document.getElementById('modal-img');
const modalTitle = document.getElementById('modal-title');
const modalPrice = document.getElementById('modal-price');
const modalSize = document.getElementById('modal-size');
const modalQuantity = document.getElementById('modal-quantity');
const modalForm = document.querySelector('#editModal form');

// Clear modal data when closing
function clearModalData() {
    if (modal) {
        document.getElementById('modal-uid').value = '';
        document.getElementById('modal-sku').value = '';
        document.getElementById('modal-img').src = '';
        document.getElementById('modal-title').innerText = '';
        document.getElementById('modal-price').innerText = '';
        document.getElementById('modal-quantity').value = '1';
        document.getElementById('modal-size').innerHTML = '';
    }
}

function closeModal() {
    if (modal) {
        modal.style.display = 'none';
        clearModalData();
    }
}

// Initialize modal functionality
function initializeModal() {
    // Attach event listeners to edit buttons
    document.querySelectorAll('.edit-button').forEach(btn => {
        btn.addEventListener('click', () => {
            clearModalData();
            
            const item = btn.closest('.main');
            const checkbox = item.querySelector('input[type="checkbox"]');
            if (!checkbox) {
                console.error('Could not find checkbox for this item');
                return;
            }

            const uid = checkbox.value;
            const img = item.getAttribute('data-img');
            const name = item.getAttribute('data-name');
            const currentSize = item.getAttribute('data-size');
            const qty = item.getAttribute('data-qty');
            const price = item.getAttribute('data-price');
            const sku = item.getAttribute('data-sku');

            // Update form fields
            document.getElementById('modal-uid').value = uid;
            document.getElementById('modal-sku').value = sku;
            document.getElementById('modal-img').src = img;
            document.getElementById('modal-title').innerText = name;
            document.getElementById('modal-price').innerText = "RM " + parseFloat(price).toFixed(2);
            document.getElementById('modal-quantity').value = qty;

            // Fetch product sizes from the server
            fetch('GetProductSizes?sku=' + sku)
                .then(response => response.text())
                .then(sizes => {
                    const sizeSelect = document.getElementById('modal-size');
                    sizeSelect.innerHTML = '';
                    
                    sizes.split('|').forEach(size => {
                        const option = document.createElement('option');
                        option.value = size.trim();
                        option.textContent = size.trim();
                        if (size.trim() === currentSize) {
                            option.selected = true;
                        }
                        sizeSelect.appendChild(option);
                    });
                })
                .catch(error => {
                    console.error('Error fetching sizes:', error);
                });

            modal.style.display = 'flex';
        });
    });

    // Attach form submit handler
    const form = document.querySelector('#editModal form');
    if (form) {
        form.addEventListener('submit', function(e) {
            const size = document.getElementById('modal-size').value;
            const qty = document.getElementById('modal-quantity').value;
            
            if (!size || !qty || qty < 1) {
                e.preventDefault();
                alert('Please fill in all required fields with valid values');
                return;
            }
        });
    }

    // Close modal on outside click
    window.onclick = function(event) {
        if (event.target === modal) {
            closeModal();
        }
    };
}

// Initialize on page load
document.addEventListener('DOMContentLoaded', initializeModal);

// Payment method handling
const paymentSelect = document.querySelector("select[name='paymentMethod']");
const visaFieldsContainer = document.getElementById("visa-fields");

if (paymentSelect) {
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
            visaFieldsContainer.innerHTML = "";
        }
    });
}

// Address textarea auto-resize
const addressTextarea = document.querySelector('textarea[name="address"]');
if (addressTextarea) {
    addressTextarea.addEventListener('input', function () {
        this.style.height = 'auto';
        this.style.height = (this.scrollHeight) + 'px';
    });
}

// Shipping method handling
const shippingSelect = document.getElementById("shippingMethodSelect");
if (shippingSelect) {
    shippingSelect.addEventListener("change", function () {
        if (typeof updateSummary === 'function') {
            updateSummary();
        }
    });
}
