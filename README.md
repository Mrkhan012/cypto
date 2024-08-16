# Crypto App

A Flutter application that provides a dashboard for viewing cryptocurrency data. The app features a main screen with multiple tabs, a home screen displaying real-time crypto data using WebSockets, and a splash screen for a smooth startup experience.

## Project Structure

- **`lib/`**: Contains the main application code.
  - **`main.dart`**: Entry point of the application. Sets up `ChangeNotifierProvider` and launches the `SplashScreen`.
  - **`view/`**: Contains UI components.
    - **`home.dart`**: Displays the home screen with a list of cryptocurrencies and search functionality.
    - **`splash_screen.dart`**: Shows the splash screen with a loading indicator and version information.
  - **`provider/`**: Contains providers for state management.
    - **`webSocketProvider.dart`**: Manages WebSocket connection and data processing.
  - **`model/`**: Contains data models.
    - **`crypto_data.dart`**: Defines the `CryptoData` model for cryptocurrency data.
  - **`Repository/`**: Contains services for data handling.
    - **`web_socket_service.dart`**: Manages WebSocket connection and subscription to crypto data updates.

## Features

- **Splash Screen**: Displays a loading screen with the app logo and version number before navigating to the main screen.
- **Home Screen**: Shows real-time cryptocurrency data fetched via WebSocket, with search and filter capabilities.
- **Bottom Navigation**: Provides tabs for navigating between the home, coin, wallet, and profile screens.
- **WebSocket Integration**: Utilizes WebSocket for real-time updates on cryptocurrency prices.

## Getting Started

### Prerequisites

- Flutter SDK installed on your machine.
- An editor like Visual Studio Code or Android Studio.

### Installation

1. **Clone the repository:**

   ```sh
   git clone <https://github.com/Mrkhan012/cypto>
   cd <project-directory>
