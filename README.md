# Parkea

A Flutter event management application with Firebase authentication and multi-language support. The app follows Clean Architecture principles with a layered structure separating presentation, domain, data, and device layers.

## Getting Started

### Prerequisites
- Flutter SDK
- Dart SDK
- Firebase CLI (for Firebase configuration)

### Installation
```bash
flutter pub get                    # Install dependencies
flutter pub upgrade               # Update dependencies
```

### Code Generation
The project uses code generation for Riverpod usecases and JSON serialization:
```bash
dart run build_runner build --delete-conflicting-outputs  # Generate code (DTOs, Usecases)
dart run build_runner watch                               # Watch for changes and regenerate automatically
```

### Running the App
```bash
flutter run                       # Run in debug mode
flutter run --release             # Run in release mode
```

### Local API & Test Users
The local API runs with podman on port **8080**: `http://10.0.2.2:8080/api/v1/` from the Android emulator, `http://localhost:8080/api/v1/` from the Mac and the iOS simulator (chosen in `lib/data/api_path_enums.dart`). On a physical device use `--dart-define=API_BASE_URL=http://192.168.x.x:8080/api/v1/`. These accounts only exist in the local database.

| User | Password | Type |
|------|----------|------|
| `qa_commerce` | `Qa-cb4789c9!` | COMMERCE, verified (can create events) |
| `qa203250` | `ZorroVolador77` | PERSON, unverified |

```bash
# Demo data: 40 events + 5 promotions (--events N --promotions N)
podman exec parkea_api_web_1 python manage.py seed_demo --reset

# Verify a new account so it can create events (new sign-ups are PERSON + unverified)
podman exec parkea_api_web_1 python manage.py shell -c "from django.contrib.auth.models import User; p=User.objects.get(username='<user>').profile; p.is_verified=True; p.save()"

# Password reset link (there is no SMTP locally)
podman logs parkea_api_web_1 | grep parkea://
```

### Testing & Quality
```bash
flutter test                      # Run all tests
flutter analyze                   # Static code analysis
```

### Build Commands
```bash
flutter build apk                 # Build Android APK
flutter build ios                 # Build iOS (requires macOS)
```

### Release APK for Remote Testing
To test from anywhere (mobile data, another Wi-Fi), expose the local API with a Cloudflare quick tunnel and build the APK against its URL. Keep the trailing `/api/v1/`:

```bash
# 1. Expose the local API; copy the https://<random>.trycloudflare.com URL it prints
cloudflared tunnel --url http://localhost:8080

# 2. Build the release APK against that URL
flutter build apk --release --dart-define=API_BASE_URL=https://<random>.trycloudflare.com/api/v1/

# 3. Install it on a phone connected over USB (Xiaomi: enable "Install via USB" in Developer options)
~/Library/Android/sdk/platform-tools/adb install -r build/app/outputs/flutter-apk/app-release.apk
```

The APK is at `build/app/outputs/flutter-apk/app-release.apk` (~97 MB; add `--split-per-abi` for ~35 MB per architecture). Notes:
- A quick tunnel gets a **new URL every time `cloudflared` restarts**, so the APK must be rebuilt with the new one.
- Use an `https://` URL: release builds block plain `http://` (only debug builds allow it).
- The release build is signed with the **debug key** (`android/app/build.gradle.kts`): fine for sharing test builds, not for Play Store.

## Architecture Overview

The project follows Clean Architecture with four main layers:

```
lib/
├── app/                          # Application/Presentation layer
│   ├── pages/                    # Screen widgets (auth, events, user, home)
│   │   └── login/
│   │       ├── login_controller.dart
│   │       ├── login_presenter.dart
│   │       └── login_view.dart
│   ├── widgets/                  # Reusable UI components (cards, forms, scaffolds)
│   ├── themes/                   # App theming and styling
│   └── utils/                    # UI utilities and transitions
│
├── domain/                       # Business logic layer (Pure Dart)
│   ├── providers/                # ⚠️ DEPRECATED - Being replaced by usecases
│   ├── usecases/                 # Business operations with integrated state management
│   │   └── login_usecase.dart    # Example: extends UseCase or CompletableUseCase
│   ├── models/                   # Domain models and state classes
│   └── routers/                  # Go Router navigation configuration
│
├── data/                         # Data access layer
│   ├── entities/                 # API response models with JSON serialization
│   ├── repositories/             # Data repositories for API calls
│   │   └── data_auth_repo.dart   # Example: handles all authentication
│   ├── helpers/                  # HTTP helpers and utilities
│   └── constants.dart            # API keys, routes, urls, etc.
│
├── device/                       # Platform-specific functionality
│   ├── repositories/             # Platform communication (GPS, etc.)
│   └── utils/                    # Device utilities (first run detection, logging)
│
└── main.dart                     # Entry point
```

## Key Technologies

| Technology | Purpose |
|------------|---------|
| **Riverpod 2.0** | State management with code generation |
| **Go Router** | Navigation with shell routes |
| **Firebase Auth** | Authentication + custom REST API |
| **http** | HTTP client |
| **json_annotation** | JSON serialization |
| **Flutter Intl** | Internationalization (Spanish primary, English secondary) |

## State Management

The project is transitioning from separated providers (`lib/domain/providers/` - deprecated) to integrated usecases (`lib/domain/usecases/`) that handle both business logic and state management with `@riverpod` annotations.

### Dependencies
- `flutter_hooks`
- `hooks_riverpod`
- `riverpod_generator` (dev)
- `build_runner` (dev)

### Code Generation Requirements
Always run `dart run build_runner build --delete-conflicting-outputs` after modifying:
- Files with `@riverpod` annotations (primarily in usecases)
- Files with `@JsonSerializable()` annotations
- ARB files for internationalization

## Navigation

Go Router implementation with:
- Shell routes for bottom navigation (Home, Profile)
- Auth flow with splash screen and onboarding
- Nested routes for event details and user settings
- Route protection based on authentication state

## Assets

- **Fonts**: Nunito family
- **Icons**: SVG for navigation
- **Animations**: Lottie for enhanced UX
- **Images**: Background images for auth screens
- **Data**: Sample JSON for development

## Firebase Configuration

- Firebase Auth configured for iOS and Android
- GoogleService configuration files present for both platforms
- Firebase initialization in `main.dart`

## Platform Support

| Platform | Status |
|----------|--------|
| Android (Kotlin) | Full support |
| iOS (Swift) | Full support |
| Web | Basic configuration |
| Linux | Basic configuration |
| macOS | Basic configuration |
| Windows | Basic configuration |
