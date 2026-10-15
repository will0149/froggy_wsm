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

String _$fetchPromotionsUCHash() => r'958c66710fcd1b25ae109816ff160ae262475c6e';

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
