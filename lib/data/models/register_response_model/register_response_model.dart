class RegisterResponseModel {
  final String? message;
  final String? token;

  const RegisterResponseModel({this.message, this.token});

  factory RegisterResponseModel.fromMap(Map<String, dynamic> json) {
    return RegisterResponseModel(
      message: json['message'],
      token: json['token'],
    );
  }
}
