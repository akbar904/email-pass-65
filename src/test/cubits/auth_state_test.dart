
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:com.example.simple_app/cubits/auth_state.dart';

void main() {
	group('AuthState', () {
		group('AuthInitial', () {
			test('should be an instance of AuthState', () {
				expect(AuthInitial(), isA<AuthState>());
			});
		});

		group('Authenticated', () {
			final user = User(id: '1', email: 'test@example.com');
			test('should be an instance of AuthState', () {
				expect(Authenticated(user), isA<AuthState>());
			});

			test('should have correct user data', () {
				final authState = Authenticated(user);
				expect(authState.user.id, '1');
				expect(authState.user.email, 'test@example.com');
			});
		});
		
		group('Unauthenticated', () {
			test('should be an instance of AuthState', () {
				expect(Unauthenticated(), isA<AuthState>());
			});
		});
	});
}
