# Flutter App with dev and prod Flavors

This guide explains how to set up a Flutter app with **dev** and **prod** flavors, supporting Android and iOS platforms.

---

## Step 1: Create a New Flutter Project

Run the following command to create a new Flutter app:

```bash
flutter create my_app
cd my_app
```

---

## Step 2: Set Up Separate Entry Points

Create separate Dart entry points for dev and prod:

1. **dev (`lib/main_dev.dart`)**:

   ```dart
   import 'main.dart';

   void main() {
     runApp(MyApp(flavor: "dev"));
   }
   ```

2. **prod (`lib/main_prod.dart`)**:

   ```dart
   import 'main.dart';

   void main() {
     runApp(MyApp(flavor: "prod"));
   }
   ```

3. **Shared Logic (`lib/main.dart`)**:

   ```dart
   import 'package:flutter/material.dart';

   class MyApp extends StatelessWidget {
     final String flavor;

     const MyApp({required this.flavor});

     @override
     Widget build(BuildContext context) {
       return MaterialApp(
         title: '$flavor App',
         home: Scaffold(
           appBar: AppBar(
             title: Text('$flavor App'),
           ),
           body: Center(
             child: Text('Running $flavor flavor'),
           ),
         ),
       );
     }
   }
   ```

---

## Step 3: Configure Flavors for Android

1. Open `android/app/build.gradle`.
2. Define flavors:

   ```gradle
   android {
       flavorDimensions "default"
       productFlavors {
           dev {
               dimension "default"
               applicationIdSuffix ".dev"
               versionNameSuffix "-dev"
           }
           prod {
               dimension "default"
           }
       }
   }
   ```

3. Create separate `AndroidManifest.xml` files:

   - Copy `android/app/src/main/` into `src/dev/` and `src/prod/`.
   - Modify each `AndroidManifest.xml` as needed (e.g., change app name or icons).

4. Run the app with the desired flavor:
   ```bash
   flutter run --flavor dev -t lib/main_dev.dart
   flutter run --flavor prod -t lib/main_prod.dart
   ```

---

## Step 4: Configure Flavors for iOS

1. Open `ios/Runner.xcworkspace` in Xcode.
2. Add Build Configurations:

   - Go to **Runner > Info > Configurations**.
   - Duplicate `Debug` and `Release` configurations for each flavor:
     - `Debug` → `Debug-dev` and `Debug-prod`
     - `Release` → `Release-dev` and `Release-prod`

3. Create Schemes:

   - Go to **Product > Scheme > Manage Schemes**.
   - Duplicate the `Runner` scheme for `dev` and `prod`.
   - For each scheme:
     - Click **Edit Scheme**.
     - Select the appropriate build configuration (`Debug-dev`, `Release-prod`, etc.).

4. Update `Podfile`:
   Modify the `Podfile` in the `ios` directory:

   ```ruby
   project 'Runner', {
     'Debug-dev' => :debug,
     'Profile-dev' => :release,
     'Release-dev' => :release,
     'Debug-prod' => :debug,
     'Profile-prod' => :release,
     'Release-prod' => :release,
   }

   target 'Runner' do
     flutter_install_all_ios_pods File.dirname(File.realpath(__FILE__))

     if ENV['FLAVOR'] == 'dev'
       # dev-specific settings (e.g., Firebase dev plist)
     elsif ENV['FLAVOR'] == 'prod'
       # prod-specific settings (e.g., Firebase prod plist)
     end
   end
   ```

5. Run the app with the desired flavor:
   ```bash
   flutter run --flavor dev -t lib/main_dev.dart
   flutter run --flavor prod -t lib/main_prod.dart
   ```

---

## Step 5: Build the App

To generate APKs or iOS builds:

1. **Build APKs**:

   ```bash
   flutter build apk --flavor dev -t lib/main_dev.dart
   flutter build apk --flavor prod -t lib/main_prod.dart
   ```

2. **Build iOS Apps**:
   ```bash
   flutter build ios --flavor dev -t lib/main_dev.dart
   flutter build ios --flavor prod -t lib/main_prod.dart
   ```

---

## Optional: Add Flavor-Specific Resources

- **Launcher Icons**: Use [flutter_launcher_icons](https://pub.dev/packages/flutter_launcher_icons) to define separate icons for each flavor.
- **Environment Variables**: Pass environment-specific configurations using `Dart-define`:
  ```bash
  flutter run --dart-define=FLAVOR=dev -t lib/main_dev.dart
  ```

---

This setup ensures a clean and organized project structure for managing **dev** and **prod** flavors in your Flutter app. Let me know if you encounter any issues!

---

## Reference

For more details on configuring flavors in Flutter, visit the official documentation:
[Flutter Flavors Documentation](https://docs.flutter.dev/deployment/flavors)
