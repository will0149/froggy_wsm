// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fetch_promotions_uc.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(FetchPromotionsUC)
const fetchPromotionsUCProvider = FetchPromotionsUCProvider._();

final class FetchPromotionsUCProvider
    extends $AsyncNotifierProvider<FetchPromotionsUC, List<PromotionDTO>> {
  const FetchPromotionsUCProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'fetchPromotionsUCProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$fetchPromotionsUCHash();

  @$internal
  @override
  FetchPromotionsUC create() => FetchPromotionsUC();
}

String _$fetchPromotionsUCHash() => r'fb3e47e88c9c50849c9901d2405d0fc717e94712';

abstract class _$FetchPromotionsUC extends $AsyncNotifier<List<PromotionDTO>> {
  FutureOr<List<PromotionDTO>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref as $Ref<AsyncValue<List<PromotionDTO>>, List<PromotionDTO>>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<List<PromotionDTO>>, List<PromotionDTO>>,
        AsyncValue<List<PromotionDTO>>,
        Object?,
        Object?>;
    element.handleValue(ref, created);
  }
}

@ProviderFor(FetchPromotionDetailUC)
const fetchPromotionDetailUCProvider = FetchPromotionDetailUCFamily._();

final class FetchPromotionDetailUCProvider
    extends $AsyncNotifierProvider<FetchPromotionDetailUC, PromotionDTO> {
  const FetchPromotionDetailUCProvider._(
      {required FetchPromotionDetailUCFamily super.from,
      required int super.argument})
      : super(
          retry: null,
          name: r'fetchPromotionDetailUCProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$fetchPromotionDetailUCHash();

  @override
  String toString() {
    return r'fetchPromotionDetailUCProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  FetchPromotionDetailUC create() => FetchPromotionDetailUC();

  @override
  bool operator ==(Object other) {
    return other is FetchPromotionDetailUCProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$fetchPromotionDetailUCHash() =>
    r'3d95d3b6e13c7f357a5862822342161657d1569e';

final class FetchPromotionDetailUCFamily extends $Family
    with
        $ClassFamilyOverride<FetchPromotionDetailUC, AsyncValue<PromotionDTO>,
            PromotionDTO, FutureOr<PromotionDTO>, int> {
  const FetchPromotionDetailUCFamily._()
      : super(
          retry: null,
          name: r'fetchPromotionDetailUCProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  FetchPromotionDetailUCProvider call(
    int id,
  ) =>
      FetchPromotionDetailUCProvider._(argument: id, from: this);

  @override
  String toString() => r'fetchPromotionDetailUCProvider';
}

abstract class _$FetchPromotionDetailUC extends $AsyncNotifier<PromotionDTO> {
  late final _$args = ref.$arg as int;
  int get id => _$args;

  FutureOr<PromotionDTO> build(
    int id,
  );
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(
      _$args,
    );
    final ref = this.ref as $Ref<AsyncValue<PromotionDTO>, PromotionDTO>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<PromotionDTO>, PromotionDTO>,
        AsyncValue<PromotionDTO>,
        Object?,
        Object?>;
    element.handleValue(ref, created);
  }
}
