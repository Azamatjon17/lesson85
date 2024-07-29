import 'package:bloc/bloc.dart';
import 'package:lesson85/bloc/quiz_event.dart';
import 'package:lesson85/bloc/quiz_state.dart';
import 'package:lesson85/models/quiz.dart';

class QuizBloc extends Bloc<QuizBlocEvent, QuizBlocState> {
  List<Quiz> quizzes = [
    Quiz(
      images: [
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR8Hn6LLw-7M4LwpzFAALvLAKkrMO730vlqYA&usqp=CAU",
        "https://w7.pngwing.com/pngs/519/775/png-transparent-100-us-dollar-banknote-lot-stay-with-the-money-cash-mouse-trap-3-illustration-bunch-of-money-investment-wealth-bank-thumbnail.png",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR8Hn6LLw-7M4LwpzFAALvLAKkrMO730vlqYA&usqp=CAU",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR8Hn6LLw-7M4LwpzFAALvLAKkrMO730vlqYA&usqp=CAU",
      ],
      hint: ["p", "r", "o", "g", "a", "m", "e", "a", "c", "y"],
      correctAnswer: "programmer",
    ),
  ];

  QuizBloc() : super(QuizBlocInitial()) {
    on<FirsQuizEvent>((event, emit) {
      emit(QuizQuestion(quiz: quizzes[0], guessedLetters: []));
    });

    on<SubmitAnswer>((event, emit) {
      final currentState = state;
      if (currentState is QuizQuestion) {
        // Compare guessed letter with correct answer
        final guess = event.answer;
        final correctAnswer = currentState.quiz.correctAnswer;
        final guessedLetters = List<String>.from(currentState.guessedLetters);

        if (correctAnswer.contains(guess)) {
          guessedLetters.add(guess);
          emit(QuizQuestion(quiz: currentState.quiz, guessedLetters: guessedLetters));
        } else {
          emit(AnswerWrong());
          emit(QuizQuestion(quiz: currentState.quiz, guessedLetters: guessedLetters));
        }

        // Check if all letters are guessed
        if (guessedLetters.toSet().containsAll(correctAnswer.split(''))) {
          emit(QuizComplete());
        }
      }
    });

    on<NextQuestion>((event, emit) {
      emit(QuizBlocInitial());
    });
  }
}
