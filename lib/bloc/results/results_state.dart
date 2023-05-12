import 'package:equatable/equatable.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';

@immutable
abstract class ResultsState extends Equatable {}

class Loading extends ResultsState {
  @override
  List<Object?> get props => [];
}

class Success extends ResultsState {
  final dynamic data;
  final List<FlSpot>? analysisData;
  final String category;
  final String diffLevel;

  Success(this.data, this.analysisData, this.category, this.diffLevel);

  @override
  List<Object?> get props => [data];
}

class Error extends ResultsState {
  final String error;

  Error(this.error);
  @override
  List<Object?> get props => [error];
}
