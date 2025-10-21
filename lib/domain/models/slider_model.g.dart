// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'slider_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Made for parkea.
/// By User: josedominguez
/// Date: 10/11/22

@ProviderFor(SliderModel)
const sliderModelProvider = SliderModelProvider._();

/// Made for parkea.
/// By User: josedominguez
/// Date: 10/11/22
final class SliderModelProvider extends $NotifierProvider<SliderModel, double> {
  /// Made for parkea.
  /// By User: josedominguez
  /// Date: 10/11/22
  const SliderModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'sliderModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$sliderModelHash();

  @$internal
  @override
  SliderModel create() => SliderModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(double value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<double>(value),
    );
  }
}

String _$sliderModelHash() => r'a8cbcb30e14c4405103bd51bed28837ee41f1f7e';

/// Made for parkea.
/// By User: josedominguez
/// Date: 10/11/22

abstract class _$SliderModel extends $Notifier<double> {
  double build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<double, double>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<double, double>,
              double,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
