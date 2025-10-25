// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database_notifier_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(databaseNotifier)
const databaseProvider = DatabaseNotifierProvider._();

final class DatabaseNotifierProvider extends $FunctionalProvider<
        AsyncValue<HandleCreateDatabase>,
        HandleCreateDatabase,
        FutureOr<HandleCreateDatabase>>
    with
        $FutureModifier<HandleCreateDatabase>,
        $FutureProvider<HandleCreateDatabase> {
  const DatabaseNotifierProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'databaseProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$databaseNotifierHash();

  @$internal
  @override
  $FutureProviderElement<HandleCreateDatabase> $createElement(
          $ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<HandleCreateDatabase> create(Ref ref) {
    return databaseNotifier(ref);
  }
}

String _$databaseNotifierHash() => r'4d4f7bf16f9816599ad43b7e5c55eb858e0d6425';
