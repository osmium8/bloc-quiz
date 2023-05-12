import 'package:bloc_quiz/bloc/results/results_event.dart';
import 'package:bloc_quiz/bloc/results/results_state.dart';
import 'package:bloc_quiz/data/repositories/result_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class ResultsBloc extends Bloc<ResultsEvent, ResultsState> {
  final repo = ResultRepo();

  ResultsBloc() : super(Success(null, null, 'Choose category', 'Choose difficulty level')) {
    on<CategoryDataRequested>((event, emit) async {
      emit(Loading());
      try {
        bool result = await checkConnectivity();
        if (result) {
          final data = await repo.getLastTenScores(event.category, event.diffLevel);
          if (event.category == 'None') {
            emit(Success(const [], const [], 'Choose category', 'Choose difficulty level'));
          }
          else {
            List<FlSpot> dataList = _getScores(data.docs);
            emit(Success(data, dataList, event.category, event.diffLevel));
          }
        } else {
          emit(Error("No internet connection. Try again later."));
        }
      } catch (e) {
        emit(Error(e.toString()));
      }
    });
  }

  Future<bool> checkConnectivity() async {
    bool result = await InternetConnectionChecker().hasConnection;
    return result;
  }

  dynamic _getScores(List<QueryDocumentSnapshot<Object?>> docs) {
    List<double> lastFiveScores = [];
    for (var e in docs) {
      lastFiveScores.add(double.parse(e['score']));
    }
    List<FlSpot> data = [];
    double index = 1.0;
    for (double score in lastFiveScores.reversed) {
      data.add(FlSpot(index, score));
      index += 1.0;
    }
    return data;
  }
}