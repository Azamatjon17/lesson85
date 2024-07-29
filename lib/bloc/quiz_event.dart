// quiz_event.dart
abstract class QuizBlocEvent {}

class FirsQuizEvent extends QuizBlocEvent {}

class SubmitAnswer extends QuizBlocEvent {
  final String answer;

  SubmitAnswer(this.answer);
}

class NextQuestion extends QuizBlocEvent {}
