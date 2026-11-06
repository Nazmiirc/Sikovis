import 'package:either_dart/either.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sikovis/data/models/login_response_model/login_response_model.dart';
import 'package:sikovis/data/models/login_response_model/user.dart';
import 'package:sikovis/data/models/register_response_model/register_response_model.dart';

class AuthService {
  ///register
  Future<Either<String, RegisterResponseModel>> register(
    String name,
    String email,
    String phone,
    String password,
  ) async {
    try {
      final box = Hive.box('users');
      
      // Check if user already exists
      if (box.containsKey(email)) {
        return Left('Error : Email sudah terdaftar');
      }

      // Save user data
      final userData = {
        'name': name,
        'email': email,
        'phone': phone,
        'password': password,
        'id': DateTime.now().millisecondsSinceEpoch,
      };
      
      await box.put(email, userData);

      var dataResponse = const RegisterResponseModel(
        message: 'Registrasi berhasil',
        token: 'mock_token_register',
      );
      return Right(dataResponse);
    } catch (e) {
      return Left('Undhandle Error : ${e.toString()}');
    }
  }

  ///login
  Future<Either<String, LoginResponseModel>> login(
    String email,
    String password,
  ) async {
    try {
      final box = Hive.box('users');
      
      if (!box.containsKey(email)) {
        return Left('Error : Akun tidak ditemukan');
      }

      final userData = box.get(email);
      
      if (userData['password'] != password) {
        return Left('Error : Password salah');
      }

      var dataResponse = LoginResponseModel(
        message: 'Login berhasil',
        token: 'mock_token_${DateTime.now().millisecondsSinceEpoch}',
        user: User(
          id: userData['id'],
          name: userData['name'],
          email: userData['email'],
        ),
      );
      
      // Save current user to the 'user' box for profile fetch
      final userBox = Hive.box('user');
      await userBox.put('name', userData['name']);
      await userBox.put('email', userData['email']);
      
      return Right(dataResponse);
    } catch (e) {
      return Left('Undhandle Error : ${e.toString()}');
    }
  }
}
