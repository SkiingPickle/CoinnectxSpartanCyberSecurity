# CoinnectxSpartanCyberSecurity

CoinnectxSpartanCyberSecurity is a **dummy** Chrome extension that integrates the Coinnect SDK for seamless authentication, access control, and payment redirection. This extension leverages Firebase and Google OAuth to authenticate users and verify their subscription or credit access before allowing payments.

## Features

- **Google Authentication:** Uses Firebase and Chrome Identity APIs for secure user authentication.  
- **Access Control:** Verifies user subscription status and available credits via the Coinnect API.  
- **Payment Redirection:** Automatically opens the payment page if access is denied.  
- **Modular SDK Integration:** Bundled Coinnect SDK simplifies integration with your existing systems.  
- **Manifest V3 Compliant:** Built to meet Chrome’s latest extension security standards.  

## Installation

1. **Download and Unzip:**  
   - Download the repository as a ZIP file.  
   - Unzip the file to your desired location.

2. **Load the Extension in Chrome:**  
   - Open Chrome and navigate to `chrome://extensions/`.  
   - Enable **Developer mode** (toggle in the upper right).  
   - Click **Load unpacked** and select the unzipped project directory.

## Usage

1. **Launching the Extension:**  
   - Click on the extension icon in your Chrome toolbar to open the popup.

2. **Authentication & Access Check:**  
   - The extension will automatically initialize and prompt you to sign in with your Google account.  
   - Once authenticated, the extension verifies your subscription status and available credits.  
   - If access is granted, your subscription and credit information will be displayed.  
   - If access is denied, a **Go to Payment** button will appear to redirect you to the payment page.

3. **Manual Sign-In:**  
   - If needed, you can manually trigger the sign-in process using the provided **Sign In** button in the popup.

## File Structure

- **manifest.json:** Defines extension settings, permissions, and CSP.  
- **popup.html:** The main HTML file for the extension’s popup UI.  
- **popup.css:** Styling for the extension’s popup.  
- **popup.js:** Handles DOM events and integrates with the Coinnect SDK.  
- **dist/coinnectSdk.bundle.js:** Bundled Coinnect SDK, including authentication and access control logic.

## Repository and Contributions

- **Public Repository:** If this repository is public, note that not everyone can push to it directly. Only collaborators with push permissions can make changes. Others can fork the repository and propose changes via pull requests.

## Credits

A huge thank you to all **Spartan Blockchain** and **Spartan Cybersecurity** members for taking the time to contribute, test, and provide invaluable feedback on this project. Your support and expertise have been essential in making this extension a success.

## PRIZES

*Sorry I am so broke, but I have a few vulnerabilities that I challenge you to find.*

- **\$1** – This one is simple; I estimate it will be found within 10 minutes.  
- **\$5** – This one is a bit more difficult; think architecture and you’ll likely uncover it.  
- **\$10** – This one is sneaky. I'll give you a hint, its a gateway between web2.0 and web3.0. Get creative (or don’t, so I can buy a fifth of tequila).
