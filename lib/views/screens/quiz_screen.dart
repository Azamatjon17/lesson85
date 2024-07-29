import 'package:flutter/material.dart';
import 'package:lesson85/models/quiz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lesson85/bloc/quiz_bloc.dart';
import 'package:lesson85/bloc/quiz_event.dart';

// ignore: must_be_immutable
class QuizScreen extends StatefulWidget {
  final Quiz quiz;
  final List<String> guessedLetters;

  const QuizScreen({
    super.key,
    required this.quiz,
    required this.guessedLetters,
  });

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<QuizBloc>(context);

    return Scaffold(
      backgroundColor: Colors.blue.shade200,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            children: [
              Expanded(
                flex: 2,
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  itemCount: widget.quiz.images.length,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Image.network(
                        widget.quiz.images[index],
                      ),
                    );
                  },
                ),
              ),
              const Spacer(),
              Wrap(
                children: widget.quiz.correctAnswer.split('').map((letter) {
                  return Container(
                    padding: const EdgeInsets.all(5),
                    margin: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.blueAccent),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      widget.guessedLetters.contains(letter) ? letter : '_',
                      style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                }).toList(),
              ),
              const Spacer(),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: 25,
                    mainAxisSpacing: 25,
                    crossAxisCount: 5,
                  ),
                  itemCount: widget.quiz.hint.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        // Submit the tapped letter as a guess
                        bloc.add(SubmitAnswer(widget.quiz.hint[index]));
                      },
                      child: Container(
                        padding: const EdgeInsets.all(1),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          widget.quiz.hint[index],
                          style: const TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 25,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
