# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Parkea is a Flutter event management application with Firebase authentication and multi-language support. The app follows Clean Architecture principles with a layered structure separating presentation, domain, data, and device layers.

## Development Commands

### Build & Dependencies
```bash
flutter pub get                    # Install dependencies
flutter pub upgrade               # Update dependencies
dart run build_runner build --delete-conflicting-outputs  # Generate code (DTOs, Usecases)
dart run build_runner watch       # Watch for changes and regenerate code automatically
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
flutter run                       # Run in debug mode
flutter run --release             # Run in release mode
```

## Architecture Overview

### Project Structure
- **`lib/app/`** - Application/Presentation layer
  - `pages/` - Screen widgets (auth, events, user, home)
  - `widgets/` - Reusable UI components (cards, forms, scaffolds)
  - `themes/` - App theming and styling
  - `utils/` - UI utilities and transitions
  
- **`lib/domain/`** - Business logic layer (Pure Dart)
  - `providers/` - ⚠️ **DEPRECATED** - Being replaced by usecases
  - `usecases/` - Business operations with integrated state management (auth, events, users)
  - `models/` - Domain models and state classes
  - `routers/` - Go Router navigation configuration
  
- **`lib/data/`** - Data access layer
  - `entities/` - API response models with JSON serialization
  - `repositories/` - Data repositories for API calls
  - `constants.dart` - API paths and configuration
  
- **`lib/device/`** - Platform-specific functionality
  - `utils/` - Device utilities (first run detection, logging)

### Key Technologies
- **State Management**: Riverpod 2.0 with code generation
- **Navigation**: Go Router with shell routes
- **Authentication**: Firebase Auth + custom REST API
- **HTTP**: Dart http package
- **Serialization**: json_annotation + json_serializable
- **Internationalization**: Flutter Intl (Spanish primary, 7 languages supported)

### State Management Pattern
Uses Riverpod with code generation. The project is transitioning from separated providers (`lib/domain/providers/` - deprecated) to integrated usecases (`lib/domain/usecases/`) that handle both business logic and state management with `@riverpod` annotations.

### Navigation Structure
Go Router implementation with:
- Shell routes for bottom navigation (Home, Profile)
- Auth flow with splash screen and onboarding
- Nested routes for event details and user settings
- Route protection based on authentication state

### Code Generation
The project heavily uses code generation for:
- Riverpod usecases (`.g.dart` files in `domain/usecases/`)
- JSON serialization for DTOs (`.g.dart` files)
- Internationalization messages

Always run `dart run build_runner build --delete-conflicting-outputs` after modifying:
- Files with `@riverpod` annotations (primarily in usecases)
- Files with `@JsonSerializable()` annotations
- ARB files for internationalization

### Testing
Basic Flutter widget testing setup. Main test file: `test/widget_test.dart`

### Assets
- Custom fonts: GothicA1 family
- SVG icons for navigation
- Lottie animations for enhanced UX
- Background images for auth screens
- Sample JSON data for development

## Firebase Configuration
- Firebase Auth configured for iOS and Android
- GoogleService configuration files present for both platforms
- Firebase initialization in main.dart

## Platform Support
- Android (Kotlin)
- iOS (Swift) 
- Web, Linux, macOS, Windows (basic configuration present)