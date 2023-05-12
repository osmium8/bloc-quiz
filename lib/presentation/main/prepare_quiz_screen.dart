import 'package:bloc_quiz/bloc/quiz_data/quiz_data_bloc.dart';
import 'package:bloc_quiz/bloc/quiz_data/quiz_data_event.dart';
import 'package:bloc_quiz/bloc/quiz_data/quiz_data_state.dart';
import 'package:bloc_quiz/presentation/main/question_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_quiz/utility/category_detail_list.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../data/repositories/quiz_repo.dart';

class PrepareQuizScreen extends StatelessWidget {
  final int index;
  final String selectedDif;

  const PrepareQuizScreen({required this.index, required this.selectedDif});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
        create: (context) => QuizDataRepository(
            'https://the-trivia-api.com/api/questions?categories=' +
                categoryDetailList[index].category +
                '&limit=10&difficulty=' +
                selectedDif),
        child: BlocProvider(
            create: (context) => QuizDataBloc(repository: RepositoryProvider.of<QuizDataRepository>(context),)
              ..add(DataRequested()),
            child: Container(
                decoration: BoxDecoration(
                  color: categoryDetailList[index].textColor,
                ),
                child: BlocListener<QuizDataBloc, QuizDataState>(
                  listener: (context, state) {
                    if (state is Success) {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: ((context) => QuestionsScreen(
                            questionData: state.data,
                            categoryIndex: index,
                            difficultyLevel: selectedDif,
                          )),
                        ),
                      );
                    }
                    if (state is Error) {
                      showDialog(context: context, builder: (_) => AlertDialog(
                        title: const Text('Error'),
                        content: Text(state.error),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.pop(context);
                            },
                            child: const Text('Ok'),
                          ),
                        ],
                      ));
                    }
                  },
                  child: BlocBuilder<QuizDataBloc, QuizDataState>(
                      builder: (context, state) {
                        // state is loading
                        return Scaffold(
                          backgroundColor: Colors.transparent,
                          body: Center(
                            child: LoadingAnimationWidget.discreteCircle(
                              color: Colors.orangeAccent,
                              size: 50,
                            ),
                          ),
                        );
                      }
                  ),
                ))));
  }
}
