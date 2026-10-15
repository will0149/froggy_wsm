// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fetch_events_uc.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(FetchEventDetailUC)
const fetchEventDetailUCProvider = FetchEventDetailUCFamily._();

final class FetchEventDetailUCProvider
    extends $AsyncNotifierProvider<FetchEventDetailUC, EventDTO> {
  const FetchEventDetailUCProvider._(
      {required FetchEventDetailUCFamily super.from,
      required int super.argument})
      : super(
          retry: null,
          name: r'fetchEventDetailUCProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$fetchEventDetailUCHash();

  @override
  String toString() {
    return r'fetchEventDetailUCProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  FetchEventDetailUC create() => FetchEventDetailUC();

  @override
  bool operator ==(Object other) {
    return other is FetchEventDetailUCProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$fetchEventDetailUCHash() =>
    r'5f3dd2b3898ce93df7a7e5d88a50bbcae83f3ed1';

final class FetchEventDetailUCFamily extends $Family
    with
        $ClassFamilyOverride<FetchEventDetailUC, AsyncValue<EventDTO>, EventDTO,
            FutureOr<EventDTO>, int> {
  const FetchEventDetailUCFamily._()
      : super(
          retry: null,
          name: r'fetchEventDetailUCProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  FetchEventDetailUCProvider call(
    int id,
  ) =>
      FetchEventDetailUCProvider._(argument: id, from: this);

  @override
  String toString() => r'fetchEventDetailUCProvider';
}

abstract class _$FetchEventDetailUC extends $AsyncNotifier<EventDTO> {
  late final _$args = ref.$arg as int;
  int get id => _$args;

  FutureOr<EventDTO> build(
    int id,
  );
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(
      _$args,
    );
    final ref = this.ref as $Ref<AsyncValue<EventDTO>, EventDTO>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<EventDTO>, EventDTO>,
        AsyncValue<EventDTO>,
        Object?,
        Object?>;
    element.handleValue(ref, created);
  }
}
