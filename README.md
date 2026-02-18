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
| **Flutter Intl** | Internationalization (Spanish primary, 7 languages) |

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

- **Fonts**: GothicA1 family
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
