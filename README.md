# 1. froggysoft

App for logistic management

## 1.1. Getting Started

## 1.2. Project Architecture

### Project Structure
- **lib/app/**: App-level configuration, themes, routing, and shared widgets
- **lib/data/**: Data layer with entities, repositories, and API configurations
- **lib/domain/**: Business logic layer with DTOs, providers, logics, and interfaces
- **lib/device/**: Device-specific utilities (connectivity, device info, logging)
- **lib/generated/**: Auto-generated internationalization files

### State Management
- Uses **Riverpod** as the primary state management solution
- Providers are defined in `lib/domain/providers/` and follow the pattern `[feature]_provider.dart`
- Code generation with `riverpod_annotation` and `riverpod_generator`

### Database
- **SQLite** via `sqflite` for local data storage
- Database schema definitions in `lib/data/repositories/schemas/local_tables.dart`
- Database helper class: `lib/data/repositories/localdb/database_helper.dart`

### Routing
- **GoRouter** for navigation with nested routes
- Main router configuration in `lib/app/pages/app_router.dart`
- Authentication-aware routing with redirect logic

### Data Flow
1. **Entities**: Raw data models from API (`lib/data/entities/`)
2. **DTOs**: Data transfer objects for business logic (`lib/domain/dtos/`)
3. **Repositories**: Data access layer (`lib/data/repositories/`)
4. **Logics**: Business logic implementations (`lib/domain/logics/`)
5. **Providers**: Riverpod providers exposing data to UI (`lib/domain/providers/`)

### API Integration
- HTTP-based API communication
- Base response/entity patterns for consistent data handling
- Environment-specific API endpoints configured via flavors

### Internationalization
- Uses `flutter_localization` with generated files
- ARB files in `lib/l10n/` (Spanish as main locale)
- Generated classes in `lib/generated/`

### Key Dependencies
- **flutter_riverpod**: State management
- **go_router**: Navigation
- **json_annotation/json_serializable**: JSON serialization
- **sqflite**: Local database
- **flutter_secure_storage**: Secure token storage
- **connectivity_plus**: Network connectivity checking

### Flavor Configuration
- Three environments: development, stage, production
- Flavor-specific configuration in `flavorizr.yaml`
- Different API endpoints per environment
- Environment-specific app icons and bundle IDs

### Form Management
- Custom form widgets in `lib/app/widgets/forms/`
- Input validation utilities in `lib/domain/utils/`
- Reusable input components for consistent UX

## 1.3. Helpers commands
Building serializable objects
```shell
dart run build_runner build --delete-conflicting-outputs
```
Build apk release or debug
```shell
flutter build apk --release 
```
Build apk/appBundle with flavors (dev Example)
```shell
flutter build apk --release --flavor development -t lib/main_development.dart
flutter build appbundle --release --flavor development -t lib/main_development.dart
```

Fix dart code issues
```shell
dart fix --dry-run;
dart fix --apply;
```