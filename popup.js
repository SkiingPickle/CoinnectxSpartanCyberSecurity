document.addEventListener('DOMContentLoaded', function() {
    // Set your invoice ID (update this as needed)
    const invoiceId = "2fMTOuywFBEsCbGTp6UR";
    
    // Get references to the DOM elements
    const loadingEl = document.getElementById("loading");
    const statusContainer = document.getElementById("status-container");
    const subscriptionStatusEl = document.getElementById("subscription-status");
    const creditsCountEl = document.getElementById("credits-count");
    const accessStatusEl = document.getElementById("access-status");
    const signInBtn = document.getElementById("sign-in-btn");
    const paymentBtn = document.getElementById("payment-btn");
  
    // Initialize the SDK
    coinnectSdk.initCoinnect(invoiceId)
      .then(result => {
        // Hide the loading message and show the status container
        loadingEl.style.display = "none";
        statusContainer.style.display = "block";
        
        // Always update subscription and credits information
        subscriptionStatusEl.textContent = result.subscription;
        creditsCountEl.textContent = result.credits;
        
        // Check access status:
        // If the user is subscribed/have access, show "Access granted".
        // Otherwise, show "Access denied" and reveal the "Go to Payment" button.
        if (result.hasAccess) {
          accessStatusEl.textContent = "Access granted";
          accessStatusEl.classList.add("status-success");
        } else {
          accessStatusEl.textContent = "Access denied";
          accessStatusEl.classList.add("status-error");
          paymentBtn.style.display = "block";
        }
      })
      .catch(error => {
        // In case of error, display the error status
        loadingEl.style.display = "none";
        statusContainer.style.display = "block";
        accessStatusEl.textContent = "Error initializing: " + error.message;
        accessStatusEl.classList.add("status-error");
      });
  
    // Bind the Payment button to redirect to the payment page when clicked
    paymentBtn.addEventListener("click", function() {
      coinnectSdk.redirectToPayment();
    });
  
    // Optional: Bind the sign-in button for manual sign-in if needed.
    signInBtn.addEventListener("click", function() {
      coinnectSdk.initCoinnect(invoiceId);
    });
  });
  