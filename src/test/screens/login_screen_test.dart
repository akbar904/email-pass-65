
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:com.example.simple_app/screens/login_screen.dart';
import 'package:com.example.simple_app/cubits/auth_cubit.dart';
import 'package:com.example.simple_app/cubits/auth_state.dart';

class MockAuthCubit extends MockCubit<AuthState> implements AuthCubit {}

void main() {
	group('LoginScreen Widget Tests', () {
		late MockAuthCubit mockAuthCubit;

		setUp(() {
			mockAuthCubit = MockAuthCubit();
		});

		testWidgets('should display email and password text fields', (WidgetTester tester) async {
			await tester.pumpWidget(
				MaterialApp(
					home: BlocProvider<AuthCubit>.value(
						value: mockAuthCubit,
						child: LoginScreen(),
					),
				),
			);

			expect(find.byKey(Key('emailField')), findsOneWidget);
			expect(find.byKey(Key('passwordField')), findsOneWidget);
		});

		testWidgets('should display login button', (WidgetTester tester) async {
			await tester.pumpWidget(
				MaterialApp(
					home: BlocProvider<AuthCubit>.value(
						value: mockAuthCubit,
						child: LoginScreen(),
					),
				),
			);

			expect(find.byKey(Key('loginButton')), findsOneWidget);
		});

		testWidgets('should display error message when AuthCubit emits AuthError', (WidgetTester tester) async {
			whenListen(
				mockAuthCubit,
				Stream<AuthState>.fromIterable([AuthError('Invalid credentials')]),
			);

			await tester.pumpWidget(
				MaterialApp(
					home: BlocProvider<AuthCubit>.value(
						value: mockAuthCubit,
						child: LoginScreen(),
					),
				),
			);

			await tester.pump();

			expect(find.text('Invalid credentials'), findsOneWidget);
		});
	});

	group('AuthCubit Tests', () {
		late MockAuthCubit mockAuthCubit;

		setUp(() {
			mockAuthCubit = MockAuthCubit();
		});

		blocTest<MockAuthCubit, AuthState>(
			'emit AuthAuthenticated when login is successful',
			build: () => mockAuthCubit,
			act: (cubit) => cubit.login('test@example.com', 'password123'),
			expect: () => [AuthAuthenticated()],
		);

		blocTest<MockAuthCubit, AuthState>(
			'emit AuthError when login fails',
			build: () => mockAuthCubit,
			act: (cubit) => cubit.login('test@example.com', 'wrongpassword'),
			expect: () => [AuthError('Invalid credentials')],
		);
	});
}
