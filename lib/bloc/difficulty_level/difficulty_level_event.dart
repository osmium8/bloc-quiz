import 'package:equatable/equatable.dart';

abstract class DifficultyLevelEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class InitEvent extends DifficultyLevelEvent {
  final int categoryIndex;

  InitEvent(this.categoryIndex);

  @override
  List<Object> get props => [categoryIndex];
}


class DifficultyLevelSelectedEvent extends DifficultyLevelEvent {
  final int selectedIndex;
  final String selectedDiff;

  DifficultyLevelSelectedEvent(this.selectedDiff, this.selectedIndex);


  @override
  List<Object> get props => [selectedIndex];
}
