📝 Mindful App
A sleek, minimalist Flutter application designed to provide daily inspiration and a personalized mindfulness experience. This project demonstrates core Flutter concepts, including NoSQL local databases, persistent user settings, and custom UI layouts.

🚀 Key Features
Personalized Experience: Users can save their name and select a background theme (Lake, Mountain, etc.) which persists across app restarts.

Daily Quotes: View and manage a collection of inspirational quotes.

Local Persistence: * Sembast (NoSQL): Used for storing and retrieving complex Quote objects.

Shared Preferences: Used for lightweight key-value storage of user preferences.

Dynamic UI: Backgrounds and greetings update dynamically based on user data.

🛠️ Tech Stack & Learning Objectives
This project was built to master the following Flutter/Dart concepts:

Stateful Lifecycle: Managing app state and loading data during initState.

Data Modeling: Creating robust Data Models with fromJson and toMap capabilities.

Asynchronous Programming: Handling Future and async/await for database operations.

Asset Management: Handling local image assets and dynamic pathing.

📂 Project Structure
Plaintext

lib/
├── data/
│   ├── db_helper.dart    # Sembast NoSQL implementation
│   ├── quote.dart        # Data model for quotes
│   └── sp_helper.dart    # Shared Preferences wrapper
├── screens/
│   ├── intro_screen.dart # User onboarding & theme selection
│   └── quote_screen.dart # Quote display logic
└── main.dart             # App entry point & Root widget
⚙️ Installation & Setup
Clone the repository:

Bash

git clone https://github.com/your-username/mindful_app.git
Install dependencies:

Bash

flutter pub get
Run the app:

Bash

flutter run
