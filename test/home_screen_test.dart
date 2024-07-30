import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lesson85/bloc/quiz_bloc.dart';
import 'package:lesson85/views/screens/home_screen.dart';

class MockQuizBloc extends QuizBloc {}

void main() {
  late QuizBloc mockQuizBloc;

  setUp(() {
    mockQuizBloc = MockQuizBloc();
  });

  group('HomeScreen Tests', () {
    testWidgets('renders Start button', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<QuizBloc>(
            create: (_) => mockQuizBloc,
            child: const HomeScreen(),
          ),
        ),
      );

      expect(find.text('Start'), findsOneWidget);
    });

    testWidgets('triggers FirsQuizEvent when Start button is tapped',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<QuizBloc>(
            create: (_) => mockQuizBloc,
            child: const HomeScreen(),
          ),
        ),
      );

      await tester.tap(find.byType(FilledButton));
      await tester.pump();
    });
  });
}
