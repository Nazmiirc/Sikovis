import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'user.dart';

class LoginResponseModel extends Equatable {
  final String? token;
  final String? message;
  final User? user;

  const LoginResponseModel({this.token, this.message, this.user});

  factory LoginResponseModel.fromMap(Map<String, dynamic> data) {
    return LoginResponseModel(
      token: data['token'] as String?,
      message: data['message'] as String?,
      user:
          data['user'] == null
              ? null
              : User.fromMap(data['user'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toMap() => {
    'token': token,
    'message': message,
    'user': user?.toMap(),
  };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [LoginResponseModel].
  factory LoginResponseModel.fromJson(String data) {
    return LoginResponseModel.fromMap(
      json.decode(data) as Map<String, dynamic>,
    );
  }

  /// `dart:convert`
  ///
  /// Converts [LoginResponseModel] to a JSON string.
  String toJson() => json.encode(toMap());

  LoginResponseModel copyWith({String? token, String? message, User? user}) {
    return LoginResponseModel(
      token: token ?? this.token,
      message: message ?? this.message,
      user: user ?? this.user,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [token, message, user];
}
