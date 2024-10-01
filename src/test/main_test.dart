
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:simple_app/main.dart';

class MockAuthCubit extends Mock implements AuthCubit {}

void main() {
	group('MyApp', () {
		testWidgets('renders MyApp', (tester) async {
			await tester.pumpWidget(MyApp());
			expect(find.byType(MaterialApp), findsOneWidget);
		});
	});

	group('MaterialApp', () {
		testWidgets('has LoginScreen as the initial route', (tester) async {
			await tester.pumpWidget(MyApp());
			expect(find.byType(LoginScreen), findsOneWidget);
		});
	});
}
