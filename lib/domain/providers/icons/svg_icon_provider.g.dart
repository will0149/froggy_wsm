// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'svg_icon_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Made for parkea.
/// By User: josedominguez
/// Date: 01/16/24

@ProviderFor(SvgIcon)
const svgIconProvider = SvgIconProvider._();

/// Made for parkea.
/// By User: josedominguez
/// Date: 01/16/24
final class SvgIconProvider extends $NotifierProvider<SvgIcon, bool> {
  /// Made for parkea.
  /// By User: josedominguez
  /// Date: 01/16/24
  const SvgIconProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'svgIconProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$svgIconHash();

  @$internal
  @override
  SvgIcon create() => SvgIcon();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$svgIconHash() => r'd80d460c2b498eb2bbe8d6f745fda45411a3adf7';

/// Made for parkea.
/// By User: josedominguez
/// Date: 01/16/24

abstract class _$SvgIcon extends $Notifier<bool> {
  bool build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<bool, bool>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<bool, bool>, bool, Object?, Object?>;
    element.handleValue(ref, created);
  }
}
