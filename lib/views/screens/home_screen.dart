import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lesson85/bloc/quiz_bloc.dart';
import 'package:lesson85/bloc/quiz_event.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<QuizBloc>(context);
    return Scaffold(
      body: Center(
        child: FilledButton(
          onPressed: () {
            bloc.add(
              FirsQuizEvent(),
            );
          },
          child: const Text("Start"),
        ),
      ),
    );
  }
}
