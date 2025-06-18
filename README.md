# altfit

ALTFit — Personalized Fitness Program App
ALTFit is a Flutter-based mobile application that delivers customized fitness programs using a dynamic UI and real-time Firebase backend. Users can explore and enroll in various fitness plans based on their personal goals like muscle gain, weight loss, or strength training.

Features:
1. Explore and filter fitness programs by goal, difficulty, and duration
2. Real-time data from Firebase Firestore
3. Tabbed interface for “My Programs” and “Explore Programs”
4. Light/Dark mode toggle
5. Profile page with enrolled programs and logout option
6. Filter dropdown with icon trigger
7. Bottom navigation bar (Home / Tracker / Profile)

Built With:
Flutter (UI Framework)
Firebase Firestore (Real-time NoSQL database)
Firebase Auth (User Authentication)
Git + Git LFS 

Folder Structure:
lib/
 ┣ screens/
 ┃ ┣ programs_screen.dart
 ┃ ┣ program_detail_screen.dart
 ┃ ┗ profile_screen.dart
 ┣ providers/
 ┃ ┗ theme_provider.dart
 ┗ firebase_options.dart    # (not included in repo)
 
Firebase Credentials:
For security reasons: google-services.json and firebase_options.dart are excluded from this repository.

To run this project:

Set up your own Firebase project
Add the google-services.json file inside android/app/
Generate firebase_options.dart using:
flutterfire configure
cd ALTFit
flutter pub get
flutter run

APK Build:
To generate the APK: flutter build apk
Find the APK at: build/app/outputs/flutter-apk/app-release.apk

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
