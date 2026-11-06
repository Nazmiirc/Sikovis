import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  // Ambil dari Hive (sebelumnya dari API)
  Future<void> fetchProfile(String token) async {
    emit(ProfileLoading());

    try {
      final box = Hive.box('user');
      final name = box.get('name') ?? '';
      final email = box.get('email') ?? '';

      if (name.isNotEmpty && email.isNotEmpty) {
        emit(ProfileLoaded(
          id: '0', 
          name: name,
          email: email,
        ));
      } else {
        emit(ProfileError('Gagal mengambil data profil'));
      }
    } catch (e) {
      emit(ProfileError('Terjadi kesalahan: $e'));
    }
  }

  // Hapus profil (Logout)
  Future<void> deleteProfile(String id, String token) async {
    emit(ProfileLoading());

    try {
      final box = Hive.box('user');
      await box.clear();

      emit(ProfileInitial());
    } catch (e) {
      emit(ProfileError('Terjadi kesalahan: $e'));
    }
  }

  // Ambil dari Hive (sama dengan fetchProfile untuk offline mode)
  Future<void> loadProfile() async {
    emit(ProfileLoading());

    try {
      final box = Hive.box('user');
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
