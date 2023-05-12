import 'package:equatable/equatable.dart';

abstract class QuizDataEvent extends Equatable {
  @override
  List<Object> get props => [];
}
class DataRequested extends QuizDataEvent {
}
