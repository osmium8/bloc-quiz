import 'package:bloc_quiz/bloc/difficulty_level/difficulty_level_state.dart';
import 'package:bloc/bloc.dart';
import '../../utility/category_detail_list.dart';
import 'difficulty_level_event.dart';

class DifficultyLevelBloc extends Bloc<DifficultyLevelEvent, DifficultyLevelState> {

  DifficultyLevelBloc() : super(InitState()) {
    on<DifficultyLevelSelectedEvent>((event, emit) async {
      emit(StartQuizState(event.selectedIndex, event.selectedDiff));
    });

    on<InitEvent>((event, emit) async {
      emit(LoadedState(categoryDetailList[event.categoryIndex].textColor, categoryDetailList[event.categoryIndex].title));
    });
  }

}