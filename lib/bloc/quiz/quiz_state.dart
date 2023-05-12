import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
class QuizState extends Equatable {

  final double currentScore;
  final int currentIndex;
  final int currentAttempts;
  final int currentWrongAttempts;
  final int currentCorrectAttempts;

  const QuizState(this.currentScore, this.currentIndex, this.currentAttempts, this.currentWrongAttempts, this.currentCorrectAttempts);

  @override
  List<Object?> get props => [currentIndex];
}

class QuizOnGoingState extends QuizState {

  final dynamic currentQuestion;
  final dynamic options;

  const QuizOnGoingState(double currentScore, int currentIndex, int currentAttempts, int currentWrongAttempts, int currentCorrectAttempts, this.currentQuestion, this.options) : super(currentScore, currentIndex, currentAttempts, currentWrongAttempts, currentCorrectAttempts);

  @override
  List<Object?> get props => [currentQuestion];
}

class QuizFinishedState extends QuizState {
  const QuizFinishedState(double currentScore, int currentIndex, int currentAttempts, int currentWrongAttempts, int currentCorrectAttempts) : super(currentScore, currentIndex, currentAttempts, currentWrongAttempts, currentCorrectAttempts);
}

