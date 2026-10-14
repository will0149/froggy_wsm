// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'password_reset_uc.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Flujo de reset: solicitar el correo y confirmar con el uid/token del
/// enlace. No toca la sesión, por eso va aparte de [RestAuthUC].
/// El estado solo indica si hay una petición en curso.

@ProviderFor(PasswordResetUC)
const passwordResetUCProvider = PasswordResetUCProvider._();

/// Flujo de reset: solicitar el correo y confirmar con el uid/token del
/// enlace. No toca la sesión, por eso va aparte de [RestAuthUC].
/// El estado solo indica si hay una petición en curso.
final class PasswordResetUCProvider
    extends $AsyncNotifierProvider<PasswordResetUC, void> {
  /// Flujo de reset: solicitar el correo y confirmar con el uid/token del
  /// enlace. No toca la sesión, por eso va aparte de [RestAuthUC].
  /// El estado solo indica si hay una petición en curso.
  const PasswordResetUCProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'passwordResetUCProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$passwordResetUCHash();

  @$internal
  @override
  PasswordResetUC create() => PasswordResetUC();
}

String _$passwordResetUCHash() => r'b33985f725c6921a18e4eb7364f9f0b6c35bb88a';

/// Flujo de reset: solicitar el correo y confirmar con el uid/token del
/// enlace. No toca la sesión, por eso va aparte de [RestAuthUC].
/// El estado solo indica si hay una petición en curso.

abstract class _$PasswordResetUC extends $AsyncNotifier<void> {
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
