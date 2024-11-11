# InScribe

## Overview

**InScribe** is a mobile application designed to connect students with disabilities (SWDs) with volunteer scribes who assist during exams. Developed with Flutter and Firebase, InScribe includes a secure authentication system, profile management, and a scribe-matching feature, making it easier for SWDs to find and connect with available volunteers.

## Features

### 1. User Types
- **SWD (Student with Disability)**: Students needing assistance during exams.
- **Scribe**: Volunteers who act as scribes to help SWDs in exams.

### 2. Authentication System
- Firebase Authentication enables secure sign-up and login for both SWDs and scribes.

### 3. Profile Management
- SWDs and scribes can create and update profiles with key details, allowing SWDs to view and select suitable scribes.

### 4. Scribe Matching
- SWDs can view available scribes based on preferences and location.
- InScribe supports scheduling assistance, real-time availability updates, and communication.

## Technology Stack

- **Frontend**: Flutter
- **Backend**: Firebase (Firebase Authentication and Firestore)

## Getting Started

### Prerequisites
- [Flutter](https://flutter.dev/docs/get-started/install) SDK
- Firebase project set up for authentication and Firestore database

### Installation
1. Clone the repository:
   ```bash
   git clone https://github.com/Jerry-britto/Inscribe.git
   cd InScribe
   ```
2. Install dependencies:
   ```bash
   flutter pub get
   ```
3. Set up Firebase by following [this guide](https://firebase.flutter.dev/docs/overview) and add `google-services.json` or `GoogleService-Info.plist`.

4. Run the app:
   ```bash
   flutter run
   ```

## Usage
- **SWD Users**: Sign up or log in to find available scribes and schedule exam assistance.
- **Scribe Users**: Sign up or log in to manage availability and provide exam assistance.

## Future Enhancements
- **Notifications**: Push notifications for reminders and updates.
- **Feedback System**: Ratings for scribes to improve matching quality.

## Project Team
This project was collaboratively developed by a dedicated team:
- **Isha Tanna** - Project Manager
- **Jerry Britto** - Developer
- **Johanna Rodrigues** - Designer
- **Sahil Shaikh** - Quality Assurance and Testing
- **Nestor Noronha** - Documentation
- **Shubham Mashalkar** - Documentation

## Contributing
Contributions are welcome! Please fork the repository and create a pull request for any updates.
