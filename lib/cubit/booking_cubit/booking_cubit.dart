// File: lib/cubit/booking_cubit/booking_cubit.dart

import 'package:bloc/bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
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

      final box = Hive.box('bookings');
      
      // Generate a unique ID for the booking
      final id = DateTime.now().millisecondsSinceEpoch;
      
      // Add standard fields to bookingData
      final Map<String, dynamic> finalBookingData = Map.from(bookingData);
      finalBookingData['id'] = id;
      finalBookingData['created_at'] = DateTime.now().toIso8601String();
      
      // Save to Hive using an auto-incrementing key or the generated ID
      await box.put(id, finalBookingData);

      emit(BookingSuccess(message: 'Booking berhasil!'));
    } catch (e) {
      emit(BookingError('Terjadi kesalahan tidak terduga: $e'));
    }
  }
}