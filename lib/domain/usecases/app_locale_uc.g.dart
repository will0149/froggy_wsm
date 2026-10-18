// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_locale_uc.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Idioma elegido en Ajustes; null = el del dispositivo. Se guarda en el
/// dispositivo y se restaura al abrir la app.

@ProviderFor(AppLocaleUC)
const appLocaleUCProvider = AppLocaleUCProvider._();

/// Idioma elegido en Ajustes; null = el del dispositivo. Se guarda en el
/// dispositivo y se restaura al abrir la app.
final class AppLocaleUCProvider
    extends $NotifierProvider<AppLocaleUC, Locale?> {
  /// Idioma elegido en Ajustes; null = el del dispositivo. Se guarda en el
  /// dispositivo y se restaura al abrir la app.
  const AppLocaleUCProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'appLocaleUCProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$appLocaleUCHash();

  @$internal
  @override
  AppLocaleUC create() => AppLocaleUC();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Locale? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Locale?>(value),
    );
  }
}

String _$appLocaleUCHash() => r'dc2d33dd509721456e5df5255acdd3a70dfac979';

/// Idioma elegido en Ajustes; null = el del dispositivo. Se guarda en el
/// dispositivo y se restaura al abrir la app.

abstract class _$AppLocaleUC extends $Notifier<Locale?> {
  Locale? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<Locale?, Locale?>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<Locale?, Locale?>, Locale?, Object?, Object?>;
    element.handleValue(ref, created);
  }
}
