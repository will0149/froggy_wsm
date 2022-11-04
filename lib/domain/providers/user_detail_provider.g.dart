// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_detail_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// ignore_for_file: avoid_private_typedef_functions, non_constant_identifier_names, subtype_of_sealed_class, invalid_use_of_internal_member, unused_element, constant_identifier_names, unnecessary_raw_strings, library_private_types_in_public_api

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

String $getUserDetailHash() => r'3f13407534464fcf9ba6f0a6d270f0e1c884d75b';

/// See also [getUserDetail].
class GetUserDetailProvider extends AutoDisposeFutureProvider<UserDTO> {
  GetUserDetailProvider(
    this.email,
  ) : super(
          (ref) => getUserDetail(
            ref,
            email,
          ),
          from: getUserDetailProvider,
          name: r'getUserDetailProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : $getUserDetailHash,
        );

  final String email;

  @override
  bool operator ==(Object other) {
    return other is GetUserDetailProvider && other.email == email;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, email.hashCode);

    return _SystemHash.finish(hash);
  }
}

typedef GetUserDetailRef = AutoDisposeFutureProviderRef<UserDTO>;

/// See also [getUserDetail].
final getUserDetailProvider = GetUserDetailFamily();

class GetUserDetailFamily extends Family<AsyncValue<UserDTO>> {
  GetUserDetailFamily();

  GetUserDetailProvider call(
    String email,
  ) {
    return GetUserDetailProvider(
      email,
    );
  }

  @override
  AutoDisposeFutureProvider<UserDTO> getProviderOverride(
    covariant GetUserDetailProvider provider,
  ) {
    return call(
      provider.email,
    );
  }

  @override
  List<ProviderOrFamily>? get allTransitiveDependencies => null;

  @override
  List<ProviderOrFamily>? get dependencies => null;

  @override
  String? get name => r'getUserDetailProvider';
}
