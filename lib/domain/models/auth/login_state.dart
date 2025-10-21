import 'package:flutter/material.dart';

import '../../../data/entities/auth/auth_response_entity.dart';
import '../../../data/entities/common/base_response_entity.dart';

/// Made for parkea.
/// By User: josedominguez
/// Date: 06/17/25

class LoginState {
  final bool isLoading;
  final BaseResponseEntity<AuthResponseEntity>? response;
  final String? error;

  LoginState({this.isLoading = false, this.response, this.error});

  LoginState copyWith({
    bool? isLoading,
    BaseResponseEntity<AuthResponseEntity>? response,
    String? error,
  }) {
    return LoginState(
      isLoading: isLoading ?? this.isLoading,
      response: response ?? this.response,
      error: error ?? this.error,
    );
  }
}