import 'package:bloc/bloc.dart';
import '../models/user.dart' as user_model;
import 'auth_state.dart' as auth_state;

class AuthCubit extends Cubit<auth_state.AuthState> {
  AuthCubit() : super(auth_state.AuthInitial());

  Future<void> login(String email, String password) async {
    try {
      // Simulate a login process
      await Future.delayed(Duration(seconds: 1));
      // Assuming 'user' is created or fetched here
      user_model.User user = user_model.User(id: '123', email: email);
      emit(auth_state.Authenticated(user));
    } catch (e) {
      emit(auth_state.Unauthenticated());
    }
  }

  void logout() {
    emit(auth_state.Unauthenticated());
  }
}
