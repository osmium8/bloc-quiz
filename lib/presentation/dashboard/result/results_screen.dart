import 'package:bloc_quiz/bloc/results/results_event.dart';
import 'package:bloc_quiz/presentation/dashboard/result/result_item.dart';
import 'package:bloc_quiz/utility/category_detail_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../bloc/results/results_bloc.dart';
import '../../../bloc/results/results_state.dart';

class Results extends StatelessWidget {
  Results({Key? key}) : super(key: key);

  final db = FirebaseFirestore.instance;
  final CollectionReference _scores =
      FirebaseFirestore.instance.collection('score');

  List<Color> gradientColors = [
    Colors.grey,
    Colors.greenAccent,
  ];

  final List<String> categories = [for (var e in categoryDetailList) e.title];

  final List<String> difficultyLevel = ['easy', 'medium', 'hard'];

  String selectedCategoryValue = '';
  String selectedDifficultyLevelValue = '';

  @override
  Widget build(BuildContext context) {
    selectedCategoryValue = '';
    selectedDifficultyLevelValue = '';
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          physics: const ScrollPhysics(),
          child: Container(
            margin:
                const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BlocProvider(
                    create: (context) => ResultsBloc(),
                    child: BlocListener<ResultsBloc, ResultsState>(
                      listener: (context, state) {
                        if (state is Error) {
                          showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                    title: const Text('Error'),
                                    content: Text(state.error),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text('Ok'),
                                      ),
                                    ],
                                  ));
                        }
                      },
                      child: BlocBuilder<ResultsBloc, ResultsState>(
                          builder: (context, state) {
                        if (state is Success) {
                          if (state.data == null) {
                            return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Scores',
                                    style: TextStyle(
                                      fontSize: 40,
                                      fontWeight: FontWeight.w900,
                                      color: Colors.black,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  buildDropdownCategoryEmpty(state, context),
                                  const SizedBox(height: 5),
                                  buildDropdownDifficultyLevelEmpty(state, context),
                                ]);
                          }
                          else if (state.data.docs.length > 0) {
                            return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Scores',
                                    style: TextStyle(
                                      fontSize: 40,
                                      fontWeight: FontWeight.w900,
                                      color: Colors.black,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  buildDropdownCategory(state, context),
                                  const SizedBox(height: 5),
                                  buildDropdownDifficultyLevel(state, context),
                                  const SizedBox(height: 5),
                                  AspectRatio(
                                      aspectRatio: 1.70,
                                      child: Padding(
                                          padding: const EdgeInsets.only(
                                            right: 18,
                                            left: 0,
                                            top: 20,
                                            bottom: 0,
                                          ),
                                          child: LineChart(
                                            LineChartData(
                                              borderData: FlBorderData(
                                                show: true,
                                                border: Border.all(
                                                    color: Colors.grey),
                                              ),
                                              titlesData: FlTitlesData(
                                                show: true,
                                                bottomTitles: AxisTitles(
                                                  sideTitles: SideTitles(
                                                      showTitles: false),
                                                ),
                                                topTitles: AxisTitles(
                                                  sideTitles: SideTitles(
                                                      showTitles: false),
                                                ),
                                                rightTitles: AxisTitles(
                                                  sideTitles: SideTitles(
                                                      showTitles: false),
                                                ),
                                              ),
                                              minX: 1,
                                              maxX: (state.data.docs.length *
                                                  1.0),
                                              minY: -4,
                                              maxY: 10,
                                              lineBarsData: [
                                                // The red line
                                                LineChartBarData(
                                                  spots: state.analysisData,
                                                  isCurved: true,
                                                  barWidth: 5,
                                                  isStrokeCapRound: true,
                                                  color: Colors.green,
                                                  gradient: LinearGradient(
                                                    colors: gradientColors,
                                                  ),
                                                  belowBarData: BarAreaData(
                                                    show: true,
                                                    gradient: LinearGradient(
                                                      colors: [
                                                        ColorTween(
                                                                begin:
                                                                    gradientColors[
                                                                        0],
                                                                end:
                                                                    gradientColors[
                                                                        1])
                                                            .lerp(0.2)!
                                                            .withOpacity(0.1),
                                                        ColorTween(
                                                                begin:
                                                                    gradientColors[
                                                                        0],
                                                                end:
                                                                    gradientColors[
                                                                        1])
                                                            .lerp(0.2)!
                                                            .withOpacity(0.1),
                                                      ],
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ))),
                                  SingleChildScrollView(
                                    physics: const ScrollPhysics(),
                                    child: Container(
                                      margin: const EdgeInsets.only(
                                          top: 10,
                                          left: 20,
                                          right: 20,
                                          bottom: 10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          ListView.builder(
                                            itemCount: state.data!.docs.length,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            itemBuilder: (context, index) {
                                              return ResultItem(index,
                                                  state.data!.docs[index]);
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ]);
                          }
                          else {
                            return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Scores',
                                    style: TextStyle(
                                      fontSize: 40,
                                      fontWeight: FontWeight.w900,
                                      color: Colors.black,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  buildDropdownCategory(state, context),
                                  const SizedBox(height: 5),
                                  buildDropdownDifficultyLevel(state, context),
                                  const SizedBox(height: 100),
                                  const Text(
                                    'Data Unavailable, Play some more games under this difficulty level :)',
                                    style: TextStyle(
                                      fontSize: 23,
                                      fontWeight: FontWeight.w900,
                                      color: Colors.black,
                                    ),
                                  ),
                                ]);
                          }
                        }

                        if (state is Error) {
                          return const Text(
                            'Backend Error',
                            style: TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.w900,
                              color: Colors.black,
                            ),
                          );
                        }

                        // state is loading
                        return Center(
                          child: LoadingAnimationWidget.discreteCircle(
                            color: Colors.orangeAccent,
                            size: 50,
                          ),
                        );
                      }),
                    ))
              ],
            ),
          ),
        ));
  }

  DropdownButtonFormField2<String> buildDropdownDifficultyLevel(
      Success state, BuildContext context) {
    return DropdownButtonFormField2(
      decoration: InputDecoration(
        isDense: true,
        contentPadding: EdgeInsets.zero,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      value: state.diffLevel,
      isExpanded: true,
      hint: const Text(
        'Select a level',
        style: TextStyle(fontSize: 14),
      ),
      icon: const Icon(
        Icons.arrow_drop_down,
        color: Colors.black45,
      ),
      iconSize: 30,
      buttonHeight: 60,
      buttonPadding: const EdgeInsets.only(left: 20, right: 10),
      dropdownDecoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
      ),
      items: difficultyLevel
          .map((item) => DropdownMenuItem<String>(
                value: item,
                child: Text(
                  item,
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
              ))
          .toList(),
      validator: (value) {
        if (value == null) {
          return 'Please select difficulty level';
        }
      },
      onChanged: (value) {
        //Do something when changing the item if you want.
        debugPrint('onChanged $value');
        selectedDifficultyLevelValue = value as String;
        if (selectedCategoryValue != '') {
          BlocProvider.of<ResultsBloc>(context).add(CategoryDataRequested(
              selectedCategoryValue, selectedDifficultyLevelValue));
        }
      },
      onSaved: (value) {
        // selectedValue = value.toString();
        debugPrint('onSave $value');
      },
    );
  }

  DropdownButtonFormField2<String> buildDropdownCategory(
      Success state, BuildContext context) {
    return DropdownButtonFormField2(
      decoration: InputDecoration(
        isDense: true,
        contentPadding: EdgeInsets.zero,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      isExpanded: true,
      hint: const Text(
        'select a category',
        style: TextStyle(fontSize: 14),
      ),
      icon: const Icon(
        Icons.arrow_drop_down,
        color: Colors.black45,
      ),
      value: state.category,
      iconSize: 30,
      buttonHeight: 60,
      buttonPadding: const EdgeInsets.only(left: 20, right: 10),
      dropdownDecoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
      ),
      items: categories
          .map((item) => DropdownMenuItem<String>(
                value: item,
                child: Text(
                  item,
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
              ))
          .toList(),
      validator: (value) {
        if (value == null) {
          return 'Please select a category.';
        }
      },
      onChanged: (value) {
        //Do something when changing the item if you want.
        debugPrint('onChanged $value');
        selectedCategoryValue = value as String;
        if (selectedDifficultyLevelValue != '') {
          BlocProvider.of<ResultsBloc>(context).add(CategoryDataRequested(
              selectedCategoryValue, selectedDifficultyLevelValue));
        }
      },
      onSaved: (value) {
        debugPrint('onSave $value');
      },
    );
  }

  DropdownButtonFormField2<String> buildDropdownDifficultyLevelEmpty(
      Success state, BuildContext context) {
    return DropdownButtonFormField2(
      decoration: InputDecoration(
        isDense: true,
        contentPadding: EdgeInsets.zero,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      isExpanded: true,
      hint: const Text(
        'Select a level',
        style: TextStyle(fontSize: 14),
      ),
      icon: const Icon(
        Icons.arrow_drop_down,
        color: Colors.black45,
      ),
      iconSize: 30,
      buttonHeight: 60,
      buttonPadding: const EdgeInsets.only(left: 20, right: 10),
      dropdownDecoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
      ),
      items: difficultyLevel
          .map((item) => DropdownMenuItem<String>(
        value: item,
        child: Text(
          item,
          style: const TextStyle(
            fontSize: 14,
          ),
        ),
      ))
          .toList(),
      validator: (value) {
        if (value == null) {
          return 'Please select difficulty level';
        }
      },
      onChanged: (value) {
        //Do something when changing the item if you want.
        debugPrint('onChanged $value');
        selectedDifficultyLevelValue = value as String;
        if (selectedCategoryValue != '') {
          BlocProvider.of<ResultsBloc>(context).add(CategoryDataRequested(
              selectedCategoryValue, selectedDifficultyLevelValue));
        }
      },
      onSaved: (value) {
        // selectedValue = value.toString();
        debugPrint('onSave $value');
      },
    );
  }

  DropdownButtonFormField2<String> buildDropdownCategoryEmpty(
      Success state, BuildContext context) {
    return DropdownButtonFormField2(
      decoration: InputDecoration(
        isDense: true,
        contentPadding: EdgeInsets.zero,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      isExpanded: true,
      hint: const Text(
        'select a category',
        style: TextStyle(fontSize: 14),
      ),
      icon: const Icon(
        Icons.arrow_drop_down,
        color: Colors.black45,
      ),
      iconSize: 30,
      buttonHeight: 60,
      buttonPadding: const EdgeInsets.only(left: 20, right: 10),
      dropdownDecoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
      ),
      items: categories
          .map((item) => DropdownMenuItem<String>(
        value: item,
        child: Text(
          item,
          style: const TextStyle(
            fontSize: 14,
          ),
        ),
      ))
          .toList(),
      validator: (value) {
        if (value == null) {
          return 'Please select a category.';
        }
      },
      onChanged: (value) {
        //Do something when changing the item if you want.
        debugPrint('onChanged $value');
        selectedCategoryValue = value as String;
        if (selectedDifficultyLevelValue != '') {
          BlocProvider.of<ResultsBloc>(context).add(CategoryDataRequested(
              selectedCategoryValue, selectedDifficultyLevelValue));
        }
      },
      onSaved: (value) {
        debugPrint('onSave $value');
      },
    );
  }
}
