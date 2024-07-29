import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lesson85/bloc/quiz_bloc.dart';
import 'package:lesson85/bloc/quiz_event.dart';
import 'package:lesson85/bloc/quiz_state.dart';
import 'package:lesson85/views/screens/home_screen.dart';
import 'package:lesson85/views/screens/quiz_screen.dart';

class BlocScreen extends StatefulWidget {
  const BlocScreen({super.key});

  @override
  State<BlocScreen> createState() => _BlocScreenState();
}

class _BlocScreenState extends State<BlocScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuizBloc, QuizBlocState>(
      builder: (context, state) {
        if (state is QuizBlocInitial) {
          return const HomeScreen();
        } else if (state is QuizQuestion) {
          return QuizScreen(
              quiz: state.quiz, guessedLetters: state.guessedLetters);
        } else if (state is QuizComplete) {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Congratulations! You've completed the quiz!",
                    style: TextStyle(fontSize: 24),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      BlocProvider.of<QuizBloc>(context).add(NextQuestion());
                    },
                    child: const Text("Play Again"),
                  ),
                ],
              ),
            ),
          );
        } else if (state is AnswerWrong) {
          return const Center(
            child: Text(
              "Wrong Guess! Try Again!",
              style: TextStyle(fontSize: 24, color: Colors.red),
            ),
          );
        }

        return const Scaffold();
      },
    );
  }
}
