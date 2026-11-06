import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sikovis/data/models/history_model/history_model.dart';
import 'history_state.dart';

class HistoryCubit extends Cubit<HistoryState> {
  HistoryCubit() : super(HistoryInitial());

  Future<void> fetchHistories(String token) async {
    if (isClosed) return;
    emit(HistoryLoading());
    try {
      final box = Hive.box('bookings');
      
      // Ambil semua data dari box dan ubah menjadi list HistoryModel
      final List<HistoryModel> list = [];
      for (var key in box.keys) {
        final Map<dynamic, dynamic> rawData = box.get(key);
        // Cast the map to Map<String, dynamic>
        final Map<String, dynamic> data = Map<String, dynamic>.from(rawData);
        list.add(HistoryModel.fromJson(data));
      }

      if (isClosed) return;
      
      // Sort list by date descending (newest first)
      list.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      
      emit(HistoryLoaded(list));
    } catch (e) {
      if (!isClosed) emit(HistoryError('Terjadi kesalahan: ${e.toString()}'));
    }
  }
}
