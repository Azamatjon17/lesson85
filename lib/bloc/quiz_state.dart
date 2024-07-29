import 'package:lesson85/models/quiz.dart';

abstract class QuizBlocState {}

class QuizBlocInitial extends QuizBlocState {}

class QuizQuestion extends QuizBlocState {
  final Quiz quiz;
  final List<String> guessedLetters;

  QuizQuestion({
    required this.quiz,
    required this.guessedLetters,
  });
}

class AnswerCorrect extends QuizBlocState {}

class AnswerWrong extends QuizBlocState {}

class QuizComplete extends QuizBlocState {}
