import 'dart:convert';

import 'package:equatable/equatable.dart';

class LoginErrorModel extends Equatable {
  final String? status;
  final String? message;

  const LoginErrorModel({this.status, this.message});

  factory LoginErrorModel.fromMap(Map<String, dynamic> data) {
    return LoginErrorModel(
      status: data['status'] as String?,
      message: data['message'] as String?,
    );
  }

  Map<String, dynamic> toMap() => {'status': status, 'message': message};

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [LoginErrorModel].
  factory LoginErrorModel.fromJson(String data) {
    return LoginErrorModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [LoginErrorModel] to a JSON string.
  String toJson() => json.encode(toMap());

  LoginErrorModel copyWith({String? status, String? message}) {
    return LoginErrorModel(
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [status, message];
}
