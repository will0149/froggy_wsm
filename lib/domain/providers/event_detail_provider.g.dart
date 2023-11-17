// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_detail_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getEventDetailHash() => r'd25abf1359fe509242145b3a1cde63013544710b';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [getEventDetail].
@ProviderFor(getEventDetail)
const getEventDetailProvider = GetEventDetailFamily();

/// See also [getEventDetail].
class GetEventDetailFamily extends Family<AsyncValue<EventDTO>> {
  /// See also [getEventDetail].
  const GetEventDetailFamily();

  /// See also [getEventDetail].
  GetEventDetailProvider call(
    int id,
  ) {
    return GetEventDetailProvider(
      id,
    );
  }

  @override
  GetEventDetailProvider getProviderOverride(
    covariant GetEventDetailProvider provider,
  ) {
    return call(
      provider.id,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'getEventDetailProvider';
}

/// See also [getEventDetail].
class GetEventDetailProvider extends AutoDisposeFutureProvider<EventDTO> {
  /// See also [getEventDetail].
  GetEventDetailProvider(
    int id,
  ) : this._internal(
          (ref) => getEventDetail(
            ref as GetEventDetailRef,
            id,
          ),
          from: getEventDetailProvider,
          name: r'getEventDetailProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getEventDetailHash,
          dependencies: GetEventDetailFamily._dependencies,
          allTransitiveDependencies:
              GetEventDetailFamily._allTransitiveDependencies,
          id: id,
        );

  GetEventDetailProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final int id;

  @override
  Override overrideWith(
    FutureOr<EventDTO> Function(GetEventDetailRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetEventDetailProvider._internal(
        (ref) => create(ref as GetEventDetailRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<EventDTO> createElement() {
    return _GetEventDetailProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetEventDetailProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetEventDetailRef on AutoDisposeFutureProviderRef<EventDTO> {
  /// The parameter `id` of this provider.
  int get id;
}

class _GetEventDetailProviderElement
    extends AutoDisposeFutureProviderElement<EventDTO> with GetEventDetailRef {
  _GetEventDetailProviderElement(super.provider);

  @override
  int get id => (origin as GetEventDetailProvider).id;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
