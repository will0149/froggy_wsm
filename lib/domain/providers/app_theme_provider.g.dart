// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_theme_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Made for parkea.
/// By User: josedominguez
/// Date: 08/03/23

@ProviderFor(AppTheme)
const appThemeProvider = AppThemeProvider._();

/// Made for parkea.
/// By User: josedominguez
/// Date: 08/03/23
final class AppThemeProvider extends $NotifierProvider<AppTheme, bool> {
  /// Made for parkea.
  /// By User: josedominguez
  /// Date: 08/03/23
  const AppThemeProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appThemeProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appThemeHash();

  @$internal
  @override
  AppTheme create() => AppTheme();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$appThemeHash() => r'99070f42cf110ad848faa056fb9f4a69c138c57a';

/// Made for parkea.
/// By User: josedominguez
/// Date: 08/03/23

abstract class _$AppTheme extends $Notifier<bool> {
  bool build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<bool, bool>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<bool, bool>,
              bool,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
