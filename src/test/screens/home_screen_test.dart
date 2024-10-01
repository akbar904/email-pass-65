
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:com.example.simple_app/screens/home_screen.dart';

// Mock Cubit
class MockAuthCubit extends MockCubit<AuthState> implements AuthCubit {}

void main() {
	group('HomeScreen Widget Tests', () {
		late MockAuthCubit mockAuthCubit;

		setUp(() {
			mockAuthCubit = MockAuthCubit();
		});

		testWidgets('HomeScreen displays logout button', (WidgetTester tester) async {
			when(() => mockAuthCubit.state).thenReturn(Authenticated());

			await tester.pumpWidget(
				MaterialApp(
					home: BlocProvider<AuthCubit>(
						create: (_) => mockAuthCubit,
						child: const HomeScreen(),
					),
				),
			);

			expect(find.byType(LogoutButton), findsOneWidget);
		});

		testWidgets('Logout button has correct text', (WidgetTester tester) async {
			when(() => mockAuthCubit.state).thenReturn(Authenticated());

			await tester.pumpWidget(
				MaterialApp(
					home: BlocProvider<AuthCubit>(
						create: (_) => mockAuthCubit,
						child: const HomeScreen(),
					),
				),
			);

			expect(find.text('Logout'), findsOneWidget);
		});
	});
}
