# 🎮 MastermindV – Color Guessing Game

A fun and interactive **Mastermind-inspired game** built with **Flutter**, where players must crack a secret 4-color code within a limited number of attempts and time.

---

## 📌 Features

* 🎯 **Secret Code Generation** – Random 4-color sequence generated at the start.
* ⏳ **Timer** – Countdown timer with custom time limit.
* 🧩 **Attempts Limit** – Configurable maximum attempts.
* 🎨 **Interactive Color Picker** – Tap to pick colors from a dialog grid.
* 📜 **Guess History** – View all past guesses with result hints.
* ✅ **Feedback System** – Black & White peg feedback (like classic Mastermind):

  * ⚪ White Peg → Correct color in correct position.
  * ⚫ Black Peg → Correct color but wrong position.
* 🏆 **Result Page** – Displays whether the code was cracked, remaining time, and the secret code.
* 🖼️ **Beautiful UI** – Gradient effects, 3D styled pegs, smooth layouts.

---

## 🚀 Getting Started

### 1️⃣ Prerequisites

Ensure you have the following installed:

* [Flutter SDK](https://docs.flutter.dev/get-started/install) (latest stable)
* [Dart SDK](https://dart.dev/get-dart)
* Android Studio / VS Code with Flutter plugin

Check your setup:

```bash
flutter doctor
```

---

### 2️⃣ Installation

Clone the repo:

```bash
git clone https://github.com/the-madhankumar/mastermindv.git
cd mastermindv
```

Get dependencies:

```bash
flutter pub get
```

---

### 3️⃣ Run the App

On an emulator or connected device:

```bash
flutter run
```

Build APK:

```bash
flutter build apk
```
---

## 🎮 Gameplay Rules

1. The game randomly generates a **4-color secret code**.
2. The player makes guesses by selecting **4 colors**.
3. After each guess, feedback is shown:

   * ⚪ White = Right color in the right spot.
   * ⚫ Black = Right color in the wrong spot.
4. Game ends if:

   * ✅ Player cracks the code (all 4 correct).
   * ⏳ Time runs out.
   * ❌ Attempts are exhausted.

---
## 🖼️ Screenshots

| Home Page | Game Page | Color Picker | Result Page |
|-----------|-----------|--------------|-------------|
| ![Home](https://github.com/the-madhankumar/MasterMindV1/blob/main/assets/home.png) | ![Game](https://github.com/the-madhankumar/MasterMindV1/blob/main/assets/game.png) | ![Picker](https://github.com/the-madhankumar/MasterMindV1/blob/main/assets/pickColor.png) | ![Result](https://github.com/the-madhankumar/MasterMindV1/blob/main/assets/result.png) |
---

## ⚙️ Customization

You can easily modify game parameters:

* **Maximum Attempts**

  ```dart
  GamePage(maxAttempts: 10, timeLimit: 60)
  ```

* **Timer Limit**
  Defined in `timeLimit` (seconds).

* **Color Set**
  Edit `ColorCode` list in `GamePage.dart`:

  ```dart
  final List<int> ColorCode = [1, 2, 3, 4, 5, 6];
  ```

---

## 🤝 Contribution

Contributions are welcome!

1. Fork the repo
2. Create your branch

   ```bash
   git checkout -b feature-name
   ```
3. Commit changes

   ```bash
   git commit -m "Add new feature"
   ```
4. Push branch & open a PR

---

## 📜 License

This project is licensed under the MIT License – feel free to use and modify it.

---

🔥 Now you’ve got a **complete README** with setup, gameplay rules, and customization.
Would you like me to also **add badges (e.g., Flutter version, MIT license, build status)** at the top for a more professional look?
