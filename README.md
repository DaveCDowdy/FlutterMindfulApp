📖 About This Project
This app was developed as a "code-along" project during the Flutter Fundamentals course by Simone Alessandria.
While following the course's core architecture, I implemented several key features to solidify my understanding of the Flutter framework, specifically focusing on how data flows from a local persistence layer up to the UI.

🚀 Key Features
Personalized Experience: Users can save their name and select a background theme (Lake, Mountain, etc.) which persists across app restarts.

Daily Quotes: View and manage a collection of inspirational quotes.

Local Persistence: * Sembast (NoSQL): Used for storing and retrieving complex Quote objects.

Shared Preferences: Used for lightweight key-value storage of user preferences.

Dynamic UI: Backgrounds and greetings update dynamically based on user data.

🛠️ Tech Stack & Learning Objectives
* Course: Flutter Fundamentals (Simone Alessandria)
* Data Persistence: * Sembast: Implemented a NoSQL database to handle quote storage, demonstrating a "Singleton" pattern for the database helper.
    * Shared Preferences: Used for storing simple user configuration (Name and Background selection).
* Architecture: Followed a clean separation of concerns by splitting the project into data, screens, and models.
* Asynchronous Logic: Managed data initialization using Future and async/await patterns within the Widget lifecycle.

📂 Project Structure
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
