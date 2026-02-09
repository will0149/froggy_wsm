// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_detail_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(getUserDetail)
const getUserDetailProvider = GetUserDetailProvider._();

final class GetUserDetailProvider extends $FunctionalProvider<
        AsyncValue<BaseResponseEntity<UserProfileDTO>>,
        BaseResponseEntity<UserProfileDTO>,
        FutureOr<BaseResponseEntity<UserProfileDTO>>>
    with
        $FutureModifier<BaseResponseEntity<UserProfileDTO>>,
        $FutureProvider<BaseResponseEntity<UserProfileDTO>> {
  const GetUserDetailProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'getUserDetailProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$getUserDetailHash();

  @$internal
  @override
  $FutureProviderElement<BaseResponseEntity<UserProfileDTO>> $createElement(
          $ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<BaseResponseEntity<UserProfileDTO>> create(Ref ref) {
    return getUserDetail(ref);
  }
}

String _$getUserDetailHash() => r'8fff875fd21c9ee4dc0bc802014c18e359370a8f';
