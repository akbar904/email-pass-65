
import 'package:bloc/bloc.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
	AuthCubit() : super(AuthInitial());

	Future<void> login(String email, String password) async {
		try {
			// Simulate a login process
			await Future.delayed(Duration(seconds: 1));
			emit(Authenticated());
		} catch (e) {
			emit(Unauthenticated());
		}
	}

	void logout() {
		emit(Unauthenticated());
	}
}
