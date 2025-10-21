// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_detail_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(getEventDetail)
const getEventDetailProvider = GetEventDetailFamily._();

final class GetEventDetailProvider
    extends
        $FunctionalProvider<AsyncValue<EventDTO>, EventDTO, FutureOr<EventDTO>>
    with $FutureModifier<EventDTO>, $FutureProvider<EventDTO> {
  const GetEventDetailProvider._({
    required GetEventDetailFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'getEventDetailProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$getEventDetailHash();

  @override
  String toString() {
    return r'getEventDetailProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<EventDTO> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<EventDTO> create(Ref ref) {
    final argument = this.argument as int;
    return getEventDetail(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is GetEventDetailProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$getEventDetailHash() => r'0636240fea7af57d562632967e543ebd8575b6a8';

final class GetEventDetailFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<EventDTO>, int> {
  const GetEventDetailFamily._()
    : super(
        retry: null,
        name: r'getEventDetailProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  GetEventDetailProvider call(int id) =>
      GetEventDetailProvider._(argument: id, from: this);

  @override
  String toString() => r'getEventDetailProvider';
}
