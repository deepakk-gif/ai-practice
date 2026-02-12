# gemma_poc

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

FOR MAC RESET OF DATABASE LOCK
rm -rf build
rm -rf macos/Flutter/ephemeral
rm -rf ~/Library/Developer/Xcode/DerivedData
rm -rf ~/Library/Developer/Xcode/ModuleCache.noindex
rm -rf ~/Library/Caches/org.swift.swiftpm
Now also clean global Swift cache:

sudo rm -rf /private/var/folders/*

🚀 After Restart

Go to new project folder:

cd ~/Dev/gemma_poc_app   # or wherever you moved it


Then:

flutter clean
flutter pub get
flutter run -d macos


⚠️ Important Rule

After moving or renaming a macOS Flutter project:

Always run:

flutter clean
rm -rf ~/Library/Developer/Xcode/DerivedData
