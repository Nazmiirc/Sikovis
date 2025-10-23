// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

// import 'package:sikovis/data/models/login_error_model.dart';
import 'package:sikovis/data/models/login_response_model/login_response_model.dart';
import 'package:sikovis/data/models/register_response_model/register_response_model.dart';

class AuthState extends Equatable {
  const AuthState({
    this.loginResponse = const LoginResponseModel(),
    this.registerResponse = const RegisterResponseModel(),
    this.isLoading = false,
    this.error = '',
  });

  final LoginResponseModel loginResponse;
  final RegisterResponseModel registerResponse;
  final bool isLoading;
  final String error;

  @override
  List<Object> get props => [loginResponse, registerResponse, isLoading, error];

  AuthState copyWith({
    LoginResponseModel? loginResponse,
    RegisterResponseModel? registerResponse,
    bool? isLoading,
    String? error,
  }) {
    return AuthState(
      loginResponse: loginResponse ?? this.loginResponse,
      registerResponse: registerResponse ?? this.registerResponse,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}
