// File: lib/cubit/booking_cubit/booking_cubit.dart

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:sikovis/cubit/booking_cubit/booking_state.dart';
import 'package:sikovis/data/datasource/localstrorage/localstorage.dart';

class BookingCubit extends Cubit<BookingState> {
  BookingCubit() : super(BookingInitial());

  Future<void> submitBooking(Map<String, dynamic> bookingData) async {
    emit(BookingLoading());

    try {
      final token = LocalStorage().getToken();
      if (token == null) {
        emit(BookingError('Token tidak ditemukan, silakan login kembali'));
        return;
      }

      final dio = Dio();
      final response = await dio.post(
        'https://servismotor.sikoteng.my.id/api/pemesanan/store',
        data: bookingData,
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Perbaikan di sini: tambahkan pesan ke BookingSuccess
        emit(BookingSuccess(message: response.data['message'] ?? 'Booking berhasil!'));
      } else {
        // Coba ambil pesan error dari response.data jika ada
        final errorMessage = response.data?['message'] ?? response.statusMessage ?? 'Gagal melakukan booking';
        emit(BookingError(errorMessage));
      }
    } on DioException catch (e) { // Tangani DioException secara spesifik
      String errorMessage = 'Terjadi kesalahan jaringan atau server';
      if (e.response != null) {
        // Coba ambil pesan error dari response Dio
        errorMessage = e.response!.data?['message'] ?? e.response!.statusMessage ?? errorMessage;
      } else {
        errorMessage = e.message ?? errorMessage;
      }
      emit(BookingError(errorMessage));
    } catch (e) {
      emit(BookingError('Terjadi kesalahan tidak terduga: $e'));
    }
  }
}