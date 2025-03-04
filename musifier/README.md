# Musifier 🎵
A sleek and user-friendly music streaming app designed for a seamless and enjoyable listening experience.

## 🚀 Features
- 🔐 **User Authentication** – Secure account creation and login via Firebase.
- 🔍 **Music Search** – Easily find songs and artists.
- 🎵 **Music Playback** – Smooth and intuitive music player using `just_audio`.
- 📂 **Categories & Playlists** – Browse by category and discover new tracks.
- 👤 **Profile Management** – Customize and edit user profiles.

---

## 🛠️ Core Technologies Used

| Technology                  | Purpose                                     |
|-----------------------------|---------------------------------------------|
| **Flutter**                 | Cross-platform framework for UI development |
| **Dart**                    | Programming language used for Flutter       |
| **Firebase Authentication** | Secure user authentication                  |
| **Cloud Firestore**         | NoSQL database for storing user data        |
| **Firebase Storage**        | Cloud storage for managing media files      |

---

## 📂 File and Folder Structure

Musifier follows a **monorepo approach**, with all internal libraries and shared components maintained within the `musifier/` folder.

### **Project Structure**
```bash
musifier/
├── lib/
│   ├── auth/         # Handles authentication (login, registration, user sessions)
│   ├── fonts/        # Custom fonts used in the app
│   ├── models/       # Defines data models
│   ├── pages/        # Screens/pages of the app
│   ├── providers/    # State management using Provider
│   ├── services/     # Backend API calls
│   ├── widgets/      # Reusable UI components
```  

---

## 🛠️ Application Build Process  

Follow these steps to set up and run the project:

```sh
# 1️⃣ Clone the repository
git clone https://github.com/tosek4/Musifier.git

# 2️⃣ Navigate to the project directory
cd musifier

# 3️⃣ Install dependencies
flutter pub get

# 4️⃣ Run the application
flutter run
