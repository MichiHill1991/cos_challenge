# COS Challenge App

This project was developed as part of a coding challenge. The goal is to demonstrate common UI,
architecture, and testing concepts in a clean Flutter application.

## 🔐 Login Simulation

Login is simulated via a mock API client. Each login attempt returns randomized outcomes to reflect:

- Successful login
- Invalid credentials (`401 Unauthorized`)
- Faulty request (`400 Bad Request`), etc.

## 🚘 VIN Lookup

After logging in, users can enter and validate a vehicle identification number (VIN).

### The VIN search uses a mocked API client that returns:

- ✅ **Single Message Response**  
  → Navigates to the **Auction Page** displaying vehicle details.

- 🟰 **Multiple Choice Response**  
  → Navigates to the **MultipleChoicesPage** where the user selects a matching entry.

- ❌ **Error Message Response**  
  → Shows a **Snackbar** with an error message based on the response.

### 🎲 Note

The outcome of each search is randomized to simulate and test different UI scenarios.

## 🧪 Testing

The project includes unit, widget, and integration tests:

- Form validation for login and VIN inputs
- UI tests for error handling and loading states
- Integration tests for various API outcomes (using the mock client)
