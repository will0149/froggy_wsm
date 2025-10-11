# 1. froggysoft

App for logistic management

## 1.1. Getting Started

## 1.2. Helpers commands
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