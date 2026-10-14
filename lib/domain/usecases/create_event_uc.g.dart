// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_event_uc.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Crea un evento (cuenta verificada) y luego sube su banner. El estado solo
/// indica si hay una petición en curso.

@ProviderFor(CreateEventUC)
const createEventUCProvider = CreateEventUCProvider._();

/// Crea un evento (cuenta verificada) y luego sube su banner. El estado solo
/// indica si hay una petición en curso.
final class CreateEventUCProvider
    extends $AsyncNotifierProvider<CreateEventUC, void> {
  /// Crea un evento (cuenta verificada) y luego sube su banner. El estado solo
  /// indica si hay una petición en curso.
  const CreateEventUCProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'createEventUCProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$createEventUCHash();

  @$internal
  @override
  CreateEventUC create() => CreateEventUC();
}

String _$createEventUCHash() => r'2efe448983d4b2f70e7b7570509488d0a1ae99ad';

/// Crea un evento (cuenta verificada) y luego sube su banner. El estado solo
/// indica si hay una petición en curso.

abstract class _$CreateEventUC extends $AsyncNotifier<void> {
  FutureOr<void> build();
  @$mustCallSuper
  @override
  void runBuild() {
    build();
    final ref = this.ref as $Ref<AsyncValue<void>, void>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<void>, void>,
        AsyncValue<void>,
        Object?,
        Object?>;
    element.handleValue(ref, null);
  }
}
