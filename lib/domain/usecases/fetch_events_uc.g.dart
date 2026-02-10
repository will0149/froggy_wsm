// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fetch_events_uc.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(FetchEventsUC)
const fetchEventsUCProvider = FetchEventsUCProvider._();

final class FetchEventsUCProvider
    extends $AsyncNotifierProvider<FetchEventsUC, List<EventDTO>> {
  const FetchEventsUCProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'fetchEventsUCProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$fetchEventsUCHash();

  @$internal
  @override
  FetchEventsUC create() => FetchEventsUC();
}

String _$fetchEventsUCHash() => r'9bed5d0c57724b261784b3cb21d3fd65a86d5492';

abstract class _$FetchEventsUC extends $AsyncNotifier<List<EventDTO>> {
  FutureOr<List<EventDTO>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<List<EventDTO>>, List<EventDTO>>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<List<EventDTO>>, List<EventDTO>>,
        AsyncValue<List<EventDTO>>,
        Object?,
        Object?>;
    element.handleValue(ref, created);
  }
}

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
    r'859d3cf074edec4ced653a9a9c56b8926dec5be7';

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
