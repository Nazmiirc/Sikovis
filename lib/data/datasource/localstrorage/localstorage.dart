import 'package:hive_flutter/hive_flutter.dart';

class LocalStorage {
  Future<void> init() async {
    await Hive.initFlutter();
    await Hive.openBox('user');
  }

  Box get _userBox => Hive.box('user');

  void saveToken(String token) {
    _userBox.put('token', token);
  }

  String? getToken() {
    return _userBox.get('token');
  }

  void removeToken() {
    _userBox.delete('token');
  }
}
