    // File: lib/cubit/booking_cubit/booking_state.dart

import 'package:equatable/equatable.dart';

abstract class BookingState extends Equatable {
  const BookingState();

  @override
  List<Object> get props => [];
}

class BookingInitial extends BookingState {}
class BookingLoading extends BookingState {}

class BookingSuccess extends BookingState {
  final String message; // Tambahkan properti message
  const BookingSuccess({this.message = 'Booking berhasil!'}); // Beri nilai default atau wajibkan

  @override
  List<Object> get props => [message]; // Sertakan message di props
}

class BookingError extends BookingState {
  final String message;
  const BookingError(this.message); // Constructor bisa disederhanakan jika hanya 1 properti

  @override
  List<Object> get props => [message];
}