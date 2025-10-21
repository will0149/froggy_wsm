// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'svg_icon_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Made for parkea.
/// By User: josedominguez
/// Date: 01/16/24

@ProviderFor(SvgIconModel)
const svgIconModelProvider = SvgIconModelProvider._();

/// Made for parkea.
/// By User: josedominguez
/// Date: 01/16/24
final class SvgIconModelProvider extends $NotifierProvider<SvgIconModel, bool> {
  /// Made for parkea.
  /// By User: josedominguez
  /// Date: 01/16/24
  const SvgIconModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'svgIconModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$svgIconModelHash();

  @$internal
  @override
  SvgIconModel create() => SvgIconModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$svgIconModelHash() => r'983b0036e3475ed514d35244fb5d923f176f3528';

/// Made for parkea.
/// By User: josedominguez
/// Date: 01/16/24

abstract class _$SvgIconModel extends $Notifier<bool> {
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
