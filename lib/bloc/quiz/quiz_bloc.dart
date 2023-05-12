import 'package:bloc_quiz/bloc/quiz/quiz_event.dart';
import 'package:bloc_quiz/bloc/quiz/quiz_state.dart';
import 'package:bloc/bloc.dart';

import '../../utility/prepare_quiz.dart';

class QuizBloc extends Bloc<QuizEvent, QuizState> {

  PrepareQuiz prepareQuizHelper;
  int currentCorrectAttempts = 0;
  int currentIndex = 0;
  int currentAttempts = 0;
  int currentWrongAttempts = 0;

  QuizBloc(this.prepareQuizHelper) : super(QuizOnGoingState(0, 0, 0, 0, 0, prepareQuizHelper.getQuestion(0), prepareQuizHelper.getOptions(0))) {

    double _getScore() {
      return (currentCorrectAttempts * 1) - (currentWrongAttempts * 0.25);
    }

    on<QuizFinished>((event, emit) async {
      if (event.selectedIndex != -1 && prepareQuizHelper.isCorrect(currentIndex, event.selectedIndex)) {
        ++currentCorrectAttempts;
      }
      currentAttempts = currentIndex + 1;
      currentWrongAttempts = currentAttempts - currentCorrectAttempts;
      double formulaScore = _getScore();
      ++currentIndex;
      QuizState finishedState = QuizFinishedState(
          formulaScore,
          currentIndex,
          currentAttempts,
          currentWrongAttempts,
          currentCorrectAttempts
      );
      emit(finishedState);
    });

    on<NextQuestion>((event, emit) async {
      if (event.selectedIndex != -1 && prepareQuizHelper.isCorrect(currentIndex, event.selectedIndex)) {
        ++currentCorrectAttempts;
      }
      currentAttempts = currentIndex + 1;
      currentWrongAttempts = currentAttempts - currentCorrectAttempts;
      double formulaScore = _getScore();
      ++currentIndex;
      QuizState nextQuestionState = QuizOnGoingState(
          formulaScore,
          currentIndex,
          currentAttempts,
          currentWrongAttempts,
          currentCorrectAttempts,
          prepareQuizHelper.getQuestion(currentIndex),
          prepareQuizHelper.getOptions(currentIndex),
      );
      emit(nextQuestionState);
    });

  }

}