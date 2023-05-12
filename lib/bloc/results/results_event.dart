import 'package:equatable/equatable.dart';

abstract class ResultsEvent extends Equatable {
  @override
  List<Object> get props => [];
}
class CategoryDataRequested extends ResultsEvent {
  final String category;
  final String diffLevel;

  CategoryDataRequested(this.category, this.diffLevel);

  @override
  List<Object> get props => [category];
}