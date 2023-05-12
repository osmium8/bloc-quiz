import 'package:bloc_quiz/bloc/difficulty_level/difficulty_level_bloc.dart';
import 'package:bloc_quiz/bloc/difficulty_level/difficulty_level_state.dart';
import 'package:bloc_quiz/presentation/main/prepare_quiz_screen.dart';
import 'package:flutter/material.dart';
import 'package:bloc_quiz/widgets/close_button.dart';
import 'package:bloc_quiz/widgets/difficulty_level_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/difficulty_level/difficulty_level_event.dart';

class DifficultyScreen extends StatelessWidget {
  const DifficultyScreen({required this.categoryIndex});

  final int categoryIndex;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) =>
            DifficultyLevelBloc()..add(InitEvent(categoryIndex)),
        child: BlocListener<DifficultyLevelBloc, DifficultyLevelState>(
          listener: (context, state) {
            if (state is StartQuizState) {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PrepareQuizScreen(
                            index: state.selectedIndex,
                            selectedDif: state.selectedDiff,
                          )));
            }
          },
          child: BlocBuilder<DifficultyLevelBloc, DifficultyLevelState>(
              builder: (context, state) {
            if (state is LoadedState) {
              return Container(
                padding: const EdgeInsets.only(
                    left: 20, right: 20, top: 40, bottom: 20),
                decoration: BoxDecoration(
                  color: state.color,
                ),
                child: Scaffold(
                  backgroundColor: Colors.transparent,
                  body: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: const [
                          RoundCloseButton(),
                        ],
                      ),
                      Text(
                        state.title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                          fontSize: 35,
                        ),
                      ),
                      Column(
                        children: const [
                          Text(
                            'Select Difficulty',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          DifficultyLevelWidget(
                              selectedIndex: categoryIndex, difficulty: 0),
                          const SizedBox(height: 20),
                          DifficultyLevelWidget(
                              selectedIndex: categoryIndex, difficulty: 1),
                          const SizedBox(height: 20),
                          DifficultyLevelWidget(
                              selectedIndex: categoryIndex, difficulty: 2),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }
            return Container();
          }),
        ));
  }
}
