
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:simple_app/models/user.dart';

void main() {
	group('User Model Tests', () {
		test('User model should correctly serialize and deserialize', () {
			// Arrange
			final user = User(id: '123', email: 'test@example.com');
			final userJson = {'id': '123', 'email': 'test@example.com'};

			// Act
			final serializedUser = user.toJson();
			final deserializedUser = User.fromJson(userJson);

			// Assert
			expect(serializedUser, userJson);
			expect(deserializedUser.id, user.id);
			expect(deserializedUser.email, user.email);
		});

		test('User model should return correct properties', () {
			// Arrange
			final user = User(id: '123', email: 'test@example.com');

			// Act & Assert
			expect(user.id, '123');
			expect(user.email, 'test@example.com');
		});
	});
}
