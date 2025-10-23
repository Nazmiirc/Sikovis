import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:sikovis/data/models/login_response_model/login_response_model.dart';
import 'package:sikovis/data/models/register_response_model/register_response_model.dart';

class AuthService {
  final dio = Dio(BaseOptions(connectTimeout: Duration(seconds: 5)));

  ///register
  Future<Either<String, RegisterResponseModel>> register(
    String name,
    String email,
    String phone,
    String password,
  ) async {
    try {
      var response = await dio.post(
        'https://servismotor.sikoteng.my.id/api/register',
        data: {
          "name": name,
          "email": email,
          "phone": phone,
          "password": password
        },
      );

      var dataResponse = RegisterResponseModel.fromMap(response.data);
      return Right(dataResponse);
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        var errorResponse = e.response?.data['message'];
        return Left('Error : $errorResponse');
      } else if (e.response?.statusCode == 401) {
        var errorResponse = e.response?.data['message'];
        return Left('Error : $errorResponse');
      } else {
        return Left('Undhandle Error : ${e.message}');
      }
    }
  }

  ///login
  Future<Either<String, LoginResponseModel>> login(
    String email,
    String password,
  ) async {
    try {
      var response = await dio.post(
        'https://servismotor.sikoteng.my.id/api/login',
        data: {"email": email, "password": password},
      );

      var dataResponse = LoginResponseModel.fromMap(response.data);
      return Right(dataResponse);
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        var errorResponse = e.response?.data['message'];
        return Left('Error : $errorResponse');
      } else if (e.response?.statusCode == 401) {
        var errorResponse = e.response?.data['message'];
        return Left('Error : $errorResponse');
      } else {
        return Left('Undhandle Error : ${e.message}');
      }
    }
  }
}
