### 🚀 AUVNET Internship Submission – Flutter App

This is a complete production-grade Flutter application built for the AUVNET internship challenge. Beyond just UI demonstration, it’s architected with **Clean Architecture**, **Firebase integration**, and **robust caching**, making it scalable and maintainable for real-world scenarios.

---

### 🧱 Layered Project Architecture

The project follows a strict Clean Architecture approach, broken into clearly separated layers:

* **🔁 Domain Layer**: Core business logic including entities, repositories, and use cases.
* **📡 Data Layer**: Handles remote data access via Firebase and local caching with Hive.
* **🎨 Presentation Layer**: Built using `flutter_bloc` for reactive state management and modular widget composition.
* **🛠️ Core Layer**: Includes shared utilities like network detection, exception handling, service locators, and themes.

---

### 🔥 Firebase-Driven Features

* Authentication (Sign up, Sign in, Email Verification) via `FirebaseAuth`.
* Structured data access using `Cloud Firestore` collections like `/services`, `/restaurants`.
* `HomeRemoteDataSource` handles data mapping from Firestore into typed domain models.
* All external data operations are abstracted via use cases and the repository pattern.

---

### 💾 Offline-First Caching with Hive

For seamless offline experience:

* First-time remote fetches from Firebase are saved locally using Hive.
* If no internet is available, the app gracefully loads from local Hive boxes.
* This ensures fast startup, minimal re-fetching, and smooth UX regardless of connectivity.

---

### 🌐 Smart Connectivity Handling

Using `internet_connection_checker_plus`, the app intelligently detects network state before performing any data fetch:

* If online ➜ fetch from Firebase ➜ cache to Hive
* If offline ➜ load last valid local data from Hive

---

### ❌ Robust Error Handling

Custom error types ensure smooth and understandable error handling across the app:

* Auth, network, cache, and server errors are clearly separated.
* Failures are caught and wrapped in the repository layer.
* Bloc handles all exceptions and emits UI-friendly error states.

---

### ✨ UI and Device Support

* Fully responsive UI using `flutter_screenutil`.
* Supports all screen sizes and orientations.
* Cleanly separated widgets for better readability and reuse.

---

### 📦 Features Summary

* 🔐 Authentication (signup, login, via mail & password)
* 🧱 Bloc-based architecture
* 🔥 Full Firebase integration (auth + Firestore + Cloud Storage)
* 💾 Local caching with Hive
* 📶 Smart connectivity-aware data handling
* 🧪 Separation of concerns with Clean Architecture
* 🧰 Dependency injection via GetIt
* ❌ Centralized exception handling
* 📱 responsive UI
* Native splash screen via (`flutter_native_splash`)
* 🖼️ Custom app icon manually integrated using (Icon Kitchen)


---

## 📦 Project Setup & Installation Guide

> **Prerequisites**:

* Flutter 3.x or higher
* Firebase CLI & Firebase project set up
* Hive generator (build\_runner)

### 🔧 Installation

```bash
git clone https://github.com/shahbbo/auvent_flutter_internship_assessment.git
cd auvent_flutter_internship_assessment

flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
```

---

## 🧠 Architectural Overview & Rationale

The architecture is inspired by real-world production standards, following Uncle Bob’s Clean Architecture principles:

| Layer            | Responsibility                                                                                       |
| ---------------- | ---------------------------------------------------------------------------------------------------- |
| **Domain**       | Pure logic, independent of any package or plugin. Ideal for testing.                                 |
| **Data**         | Bridges Firebase/Storage APIs with the domain through well-structured mappers and models.            |
| **Presentation** | Completely UI-focused, driven by Bloc and state transitions. UI doesn't touch data sources directly. |
| **Core**         | Shared logic, including service locators, network utilities, themes, constants, and errors.          |

Benefits:

✅ **Testability** – Each layer can be independently tested
✅ **Scalability** – Easily expandable for future features (e.g. notifications, payments)
✅ **Separation of Concerns** – UI, logic, and data are loosely coupled
✅ **Offline support** – Thanks to the Hive layer and intelligent network checks

---
