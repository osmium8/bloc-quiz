import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
abstract class DifficultyLevelState extends Equatable {}

class InitState extends DifficultyLevelState {
  @override
  List<Object?> get props => [];
}

class LoadedState extends DifficultyLevelState {
  final Color color;
  final String title;

  LoadedState(this.color, this.title);

  @override
  List<Object?> get props => [];
}

class StartQuizState extends DifficultyLevelState {
  final int selectedIndex;
  final String selectedDiff;

  StartQuizState(this.selectedIndex, this.selectedDiff);

  @override
  List<Object?> get props => [];
}

class Error extends DifficultyLevelState {
  final String error;

  Error(this.error);
  @override
  List<Object?> get props => [error];
}
