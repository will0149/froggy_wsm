// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'items_logic_impl.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ItemsLogicImpl)
const itemsLogicImplProvider = ItemsLogicImplProvider._();

final class ItemsLogicImplProvider
    extends $NotifierProvider<ItemsLogicImpl, ItemsLoadState> {
  const ItemsLogicImplProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'itemsLogicImplProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$itemsLogicImplHash();

  @$internal
  @override
  ItemsLogicImpl create() => ItemsLogicImpl();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ItemsLoadState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ItemsLoadState>(value),
    );
  }
}

String _$itemsLogicImplHash() => r'5a637e5ba218299a0d2be97f4893fc56275a1def';

abstract class _$ItemsLogicImpl extends $Notifier<ItemsLoadState> {
  ItemsLoadState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<ItemsLoadState, ItemsLoadState>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<ItemsLoadState, ItemsLoadState>,
        ItemsLoadState,
        Object?,
        Object?>;
    element.handleValue(ref, created);
  }
}
