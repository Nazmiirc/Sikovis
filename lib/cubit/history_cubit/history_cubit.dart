import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:sikovis/data/models/history_model/history_model.dart';
import 'dart:convert';
import 'history_state.dart';

class HistoryCubit extends Cubit<HistoryState> {
  HistoryCubit() : super(HistoryInitial());

  Future<void> fetchHistories(String token) async {
  if (isClosed) return;
  emit(HistoryLoading());
  try {
    final response = await http.get(
      Uri.parse('https://servismotor.sikoteng.my.id/api/pemesanan'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (isClosed) return;
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final list = (data['data'] as List)
          .map((json) => HistoryModel.fromJson(json))
          .toList();

      emit(HistoryLoaded(list));
    } else {
      emit(HistoryError('Gagal mengambil data riwayat.'));
    }
  } catch (e) {
    if (!isClosed) emit(HistoryError('Terjadi kesalahan: ${e.toString()}'));
  }
}

}
