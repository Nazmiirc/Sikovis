import 'package:bloc/bloc.dart';
import 'package:sikovis/cubit/auth_cubit/auth_state.dart';
import 'package:sikovis/data/datasource/localstrorage/localstorage.dart';
import 'package:sikovis/data/datasource/services/auth_service.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthState());

  Future<void> doLogin(String email, String password) async {
    emit(state.copyWith(isLoading: true));

    var data = await AuthService().login(email, password);

    data.fold((left) => emit(state.copyWith(error: left)), (right) {
      emit(state.copyWith(loginResponse: right));
      LocalStorage().saveToken(right.token ?? '');
    });

    emit(state.copyWith(isLoading: false));
  }

  Future<void> doRegister(
    String name,
    String email,
    String phone,
    String password,
  ) async {
    emit(state.copyWith(isLoading: true));

    var data = await AuthService().register(name, email, phone, password);

    data.fold((left) => emit(state.copyWith(error: left)), (right) {
      emit(state.copyWith(registerResponse: right));
      LocalStorage().saveToken(right.token ?? '');
    });

    emit(state.copyWith(isLoading: false));
  }
}
