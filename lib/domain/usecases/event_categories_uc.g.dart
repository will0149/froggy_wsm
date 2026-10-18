// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_categories_uc.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Categorías habilitadas en el admin (`events/categories/`), en su orden;
/// las que no son visibles ni creables no vienen. Las que la app no conoce
/// se omiten. Si el API falla devuelve null y cada pantalla usa todas las
/// de [EventCategory]: si alguna no se puede usar, el API lo dirá al crear.

@ProviderFor(eventCategoriesUC)
const eventCategoriesUCProvider = EventCategoriesUCProvider._();

/// Categorías habilitadas en el admin (`events/categories/`), en su orden;
/// las que no son visibles ni creables no vienen. Las que la app no conoce
/// se omiten. Si el API falla devuelve null y cada pantalla usa todas las
/// de [EventCategory]: si alguna no se puede usar, el API lo dirá al crear.

final class EventCategoriesUCProvider extends $FunctionalProvider<
        AsyncValue<List<CategoryOption>?>,
        List<CategoryOption>?,
        FutureOr<List<CategoryOption>?>>
    with
        $FutureModifier<List<CategoryOption>?>,
        $FutureProvider<List<CategoryOption>?> {
  /// Categorías habilitadas en el admin (`events/categories/`), en su orden;
  /// las que no son visibles ni creables no vienen. Las que la app no conoce
  /// se omiten. Si el API falla devuelve null y cada pantalla usa todas las
  /// de [EventCategory]: si alguna no se puede usar, el API lo dirá al crear.
  const EventCategoriesUCProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'eventCategoriesUCProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$eventCategoriesUCHash();

  @$internal
  @override
  $FutureProviderElement<List<CategoryOption>?> $createElement(
          $ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<List<CategoryOption>?> create(Ref ref) {
    return eventCategoriesUC(ref);
  }
}

String _$eventCategoriesUCHash() => r'1b06eb8b8182fefe58f83c3b5e68f509e14be4b6';
