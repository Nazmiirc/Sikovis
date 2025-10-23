import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:hive/hive.dart';
import 'dart:convert';
import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  // Ambil dari API
  Future<void> fetchProfile(String token) async {
    emit(ProfileLoading());

    try {
      final response = await http.get(
        Uri.parse('https://servismotor.sikoteng.my.id/api/profile'),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final user = data['user'];

        final box = await Hive.openBox('user');
        await box.put('name', user['name']);
        await box.put('email', user['email']);

        emit(ProfileLoaded(
          id: user['id'].toString(),
          name: user['name'],
          email: user['email'],
        ));
      } else {
        emit(ProfileError('Gagal mengambil data profil dari server'));
      }
    } catch (e) {
      emit(ProfileError('Terjadi kesalahan: $e'));
    }
  }

  // Hapus profil dari API
  Future<void> deleteProfile(String id, String token) async {
    emit(ProfileLoading());

    try {
      final response = await http.delete(
        Uri.parse('https://servismotor.sikoteng.my.id/api/profile/delete/$id'),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final box = await Hive.openBox('user');
        await box.clear();

        emit(ProfileInitial());
      } else {
        emit(ProfileError('Gagal menghapus profil'));
      }
    } catch (e) {
      emit(ProfileError('Terjadi kesalahan: $e'));
    }
  }

  // Ambil dari Hive
  Future<void> loadProfile() async {
    emit(ProfileLoading());

    try {
      final box = await Hive.openBox('user');
      final name = box.get('name') ?? '';
      final email = box.get('email') ?? '';

      if (name.isNotEmpty && email.isNotEmpty) {
        emit(ProfileLoaded(id: '0', name: name, email: email)); // id dummy
      } else {
        emit(ProfileError('Data profil tidak ditemukan di Hive'));
      }
    } catch (e) {
      emit(ProfileError('Gagal memuat profil dari Hive: $e'));
    }
  }
}
