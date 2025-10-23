import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:sikovis/cubit/history_cubit/history_cubit.dart';
import 'package:sikovis/cubit/history_cubit/history_state.dart';
import 'package:sikovis/presentation/history_card.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  late final HistoryCubit _historyCubit;

  @override
  void initState() {
    super.initState();
    final token = Hive.box('user').get('token');
    _historyCubit = HistoryCubit();
    _historyCubit.fetchHistories(token);
  }

  @override
  void dispose() {
    _historyCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _historyCubit,
      child: Scaffold(
        body: BlocBuilder<HistoryCubit, HistoryState>(
          builder: (context, state) {
            if (state is HistoryLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is HistoryLoaded) {
              if (state.histories.isEmpty) {
                return const Center(child: Text('Tidak ada data.'));
              }
              return ListView.builder(
                itemCount: state.histories.length,
                itemBuilder: (context, index) {
                  final item = state.histories[index];
                  return HistoryCard(history: item);
                },
              );
            } else if (state is HistoryError) {
              return Center(child: Text(state.message));
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
