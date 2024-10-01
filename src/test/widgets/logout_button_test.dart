
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:com.example.simple_app/widgets/logout_button.dart';
import 'package:com.example.simple_app/cubits/auth_cubit.dart';
import 'package:com.example.simple_app/cubits/auth_state.dart';

// Mock class for AuthCubit
class MockAuthCubit extends MockCubit<AuthState> implements AuthCubit {}

void main() {
	group('LogoutButton Widget Tests', () {
		testWidgets('renders Logout Button with correct text', (WidgetTester tester) async {
			// Arrange
			final mockAuthCubit = MockAuthCubit();
			
			// Act
			await tester.pumpWidget(
				MaterialApp(
					home: BlocProvider<AuthCubit>(
						create: (_) => mockAuthCubit,
						child: LogoutButton(),
					),
				),
			);
			
			// Assert
			expect(find.text('Logout'), findsOneWidget);
			expect(find.byType(ElevatedButton), findsOneWidget);
		});
		
		testWidgets('calls logout on button press', (WidgetTester tester) async {
			// Arrange
			final mockAuthCubit = MockAuthCubit();
			
			// Act
			await tester.pumpWidget(
				MaterialApp(
					home: BlocProvider<AuthCubit>(
						create: (_) => mockAuthCubit,
						child: LogoutButton(),
					),
				),
			);
			
			await tester.tap(find.byType(ElevatedButton));
			await tester.pump();
			
			// Assert
			verify(() => mockAuthCubit.logout()).called(1);
		});
	});

	group('LogoutButton Cubit Tests', () {
		late AuthCubit authCubit;
		
		setUp(() {
			authCubit = MockAuthCubit();
		});
		
		blocTest<AuthCubit, AuthState>(
			'emits Unauthenticated state when logout is called',
			build: () => authCubit,
			act: (cubit) => cubit.logout(),
			expect: () => [isA<Unauthenticated>()],
		);
	});
}
