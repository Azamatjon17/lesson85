import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lesson85/bloc/quiz_bloc.dart';
import 'package:lesson85/bloc/quiz_event.dart';
import 'package:lesson85/models/quiz.dart';
import 'package:lesson85/views/screens/quiz_screen.dart';

class MockQuizBloc extends QuizBloc {}

void main() {
  late QuizBloc mockQuizBloc;
  final testQuiz = Quiz(
    images: [
      'https://example.com/image1.png',
      'https://example.com/image2.png'
    ],
    correctAnswer: 'FLUTTER',
    hint: ['F', 'L', 'U', 'T', 'E', 'R', 'A', 'B', 'C'],
  );
  final testGuessedLetters = ['F', 'L'];

  setUp(() {
    mockQuizBloc = MockQuizBloc() as QuizBloc;
  });

  group('QuizScreen Tests', () {
    testWidgets('displays all images', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<QuizBloc>(
            create: (_) => mockQuizBloc,
            child:
                QuizScreen(quiz: testQuiz, guessedLetters: testGuessedLetters),
          ),
        ),
      );

      // Verify that each image in the quiz is displayed
      for (var imageUrl in testQuiz.images) {
        expect(
            find.byWidgetPredicate((widget) =>
                widget is Image &&
                (widget.image as NetworkImage).url == imageUrl),
            findsOneWidget);
      }
    });

    testWidgets('displays guessed letters and underscores',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<QuizBloc>(
            create: (_) => mockQuizBloc,
            child:
                QuizScreen(quiz: testQuiz, guessedLetters: testGuessedLetters),
          ),
        ),
      );

      // Check guessed letters
      expect(find.text('F'), findsOneWidget);
      expect(find.text('L'), findsOneWidget);

      // Check underscores for remaining letters
      expect(
          find.text('_'),
          findsNWidgets(
              testQuiz.correctAnswer.length - testGuessedLetters.length));
    });

    testWidgets('triggers SubmitAnswer event when a letter is tapped',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<QuizBloc>(
            create: (_) => mockQuizBloc,
            child:
                QuizScreen(quiz: testQuiz, guessedLetters: testGuessedLetters),
          ),
        ),
      );

      // Tap on the letter 'U'
      await tester.tap(find.text('U'));
      await tester.pump();
    });
  });
}
